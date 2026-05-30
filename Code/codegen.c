#include "codegen.h"
#include <bits/types/locale_t.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define MAX_VAR 10000
#define MAX_IR 10000
#define REG_NUM 18

typedef struct IREntry {
    IROp opcode;
    const char* result;
    const char* arg1;
    const char* arg2;
    Relop relop;
} IREntry;

typedef struct VarMap{
    const char* var_name;
    int idx;
} VarMap;

typedef struct RegDesc {
    int is_free;
    int var_idx;
    int dirty;
    int next_use; // 寄存器中变量的下一次使用位置, -1表示未计算
} RegDesc;

typedef struct VarDesc {
    int reg_idx;
    int slot; // 局部变量槽, 本质就是第几个局部变量
} VarDesc;

VarMap var_map[MAX_VAR];
int var_map_size = 0;

RegDesc regs[REG_NUM];
VarDesc vars[MAX_VAR];

FILE* output_file;
IREntry* ir_table;
int ir_count = 0;

int local_var_cnt = 0;

int is_var(const char* name) {
    return name[0] == 'v' || name[0] == 't';
}

int is_imm(const char* name) {
    return name[0] == '#';
}

int get_imm(const char* name) {
    assert(is_imm(name));
    return atoi(name + 1);
}

int get_var_idx(const char* var_name){
    assert(is_var(var_name));
    for(int i = 0; i < var_map_size; i++){
        if(strcmp(var_map[i].var_name, var_name) == 0){
            return var_map[i].idx;
        }
    }
    var_map[var_map_size].var_name = var_name;
    var_map[var_map_size].idx = var_map_size;
    return var_map_size++;
}

int make_local_slot(){
    return local_var_cnt++;
}

const char* get_reg_name(int reg_idx){
    switch (reg_idx) {
        case 0: return "t0";
        case 1: return "t1";
        case 2: return "t2";
        case 3: return "t3";
        case 4: return "t4";
        case 5: return "t5";
        case 6: return "t6";
        case 7: return "t7";
        case 8: return "t8";
        case 9: return "t9";
        case 10: return "s0";
        case 11: return "s1";
        case 12: return "s2";
        case 13: return "s3";
        case 14: return "s4";
        case 15: return "s5";
        case 16: return "s6";
        case 17: return "s7";
        default: return NULL;
    }
}

// register allocation
void init_allocation(){
    for(int i = 0; i < REG_NUM; i++){
        regs[i].is_free = 1;
        regs[i].var_idx = -1;
        regs[i].dirty = 0;
        regs[i].next_use = -1;
    }
    for(int i = 0; i < var_map_size; i++){
        vars[i].reg_idx = -1;
        vars[i].slot = -1; // -1表示未分配局部变量槽
    }
}

int allocate(const char* var_name){
    for(int i = 0; i < REG_NUM; i++){
        if(regs[i].is_free){
            regs[i].is_free = 0;
            regs[i].var_idx = get_var_idx(var_name);
            return i;
        }
    }
    int victim = -1;
    int farthest_next_use = -1;
    for(int i = 0; i < REG_NUM; i++){
        if(regs[i].next_use > farthest_next_use){
            farthest_next_use = regs[i].next_use;
            victim = i;
        }
    }
    if(regs[victim].dirty){
        int var_idx = regs[victim].var_idx;
        if(vars[var_idx].slot == -1){
            vars[var_idx].slot = make_local_slot(); // 分配局部变量槽
        }
        vars[var_idx].reg_idx = -1;
        // TODO: 栈结构待定
        fprintf(output_file, "sw %s, %d($fp)\n", get_reg_name(victim), vars[var_idx].slot * 4);
    }
    int var_idx = get_var_idx(var_name);
    regs[victim].var_idx = var_idx;
    regs[victim].is_free = 0;
    regs[victim].dirty = 0;
    regs[victim].next_use = -1;
    vars[var_idx].reg_idx = victim;
    return victim;
}

// 确保变量在寄存器中，返回寄存器编号
int ensure(const char* var_name){
    int var_idx = get_var_idx(var_name);
    if(vars[var_idx].reg_idx != -1){
        return vars[var_idx].reg_idx;
    }
    int reg_idx = allocate(var_name);
    vars[var_idx].reg_idx = reg_idx;
    if(vars[var_idx].slot == -1){
        vars[var_idx].slot = make_local_slot();
    }
    // TODO: 栈结构待定
    fprintf(output_file, "lw %s, %d($fp)\n", get_reg_name(reg_idx), vars[var_idx].slot * 4);
    return reg_idx;
}

void free_if_unused(int cur_ir_idx, int block_end, const char* var_name){
    int var_idx = get_var_idx(var_name);
    int reg_idx = vars[var_idx].reg_idx;
    int next_use = -1;
    for(int i = cur_ir_idx + 1; i < block_end; i++){
        if((ir_table[i].arg1 && strcmp(ir_table[i].arg1, var_name) == 0) || (ir_table[i].arg2 && strcmp(ir_table[i].arg2, var_name) == 0)){
            next_use = i;
            break;
        }
        if(ir_table[i].result && strcmp(ir_table[i].result, var_name) == 0){
            next_use = -1;
            break;
        }
    }
    regs[reg_idx].next_use = next_use;
    if(next_use == -1){
        if(regs[reg_idx].dirty){
            if(vars[var_idx].slot == -1){
                vars[var_idx].slot = make_local_slot();
            }
            // TODO: 栈结构待定
            fprintf(output_file, "sw %s, %d($fp)\n", get_reg_name(reg_idx), vars[var_idx].slot * 4);
        }
        regs[reg_idx].is_free = 1;
        regs[reg_idx].var_idx = -1;
        regs[reg_idx].dirty = 0;
        regs[reg_idx].next_use = -1;
        vars[var_idx].reg_idx = -1;
    }
}

void transform_ir(IRInst* ir);
void gencode_func(int begin, int end);
void gencode_block(int begin, int end);

void generate_code(IRInst* ir, FILE* output) {
    output_file = output;
    transform_ir(ir);
    for(int i = 0; i < ir_count;){
        if(ir_table[i].opcode == IR_OP_FUNCTION){
            int j = i + 1;
            while(j < ir_count && ir_table[j].opcode != IR_OP_FUNCTION) j++;
            gencode_func(i, j);
            i = j;
        } else{
            i++;
        }
    }
}

void transform_ir(IRInst* ir) {
    ir_count = 0;
    for(IRInst* p = ir; p; p = p->next){
        ir_count++;
    }
    ir_table = (IREntry*)malloc(sizeof(IREntry) * ir_count);

    int i = 0;
    for(IRInst* p = ir; p; p = p->next){
        ir_table[i].opcode = p->opcode;
        ir_table[i].result = p->result;
        ir_table[i].arg1 = p->arg1;
        ir_table[i].arg2 = p->arg2;
        ir_table[i].relop = p->relop;
        i++;
    }
}

void gencode_func(int begin, int end) {
    // TODO
    for(int i = begin + 1; i < end; i++) {
        if(ir_table[i].opcode == IR_OP_LABEL || ir_table[i].opcode == IR_OP_GOTO || ir_table[i].opcode == IR_OP_IF_GOTO){
            int j = i + 1;
            while(j < end && ir_table[j].opcode != IR_OP_LABEL && ir_table[j].opcode != IR_OP_GOTO && ir_table[j].opcode != IR_OP_IF_GOTO) j++;
            gencode_block(i, j);
            i = j - 1;
        }
    }
}

void gencode_block(int begin, int end) {
    for(int i = begin; i < end; i++) {
        IREntry* entry = &ir_table[i];
        switch(entry->opcode){
            case IR_OP_ADD: {
                if(is_imm(entry->arg1) && is_imm(entry->arg2)){
                    int res = get_imm(entry->arg1) + get_imm(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(dst), res);
                    free_if_unused(i, end, entry->result);
                } else if(is_imm(entry->arg1)){
                    int src = ensure(entry->arg2);
                    int val = get_imm(entry->arg1);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "addi %s, %s, %d\n", get_reg_name(dst), get_reg_name(src), val);
                    free_if_unused(i, end, entry->arg2);
                    free_if_unused(i, end, entry->result);
                } else if(is_imm(entry->arg2)){
                    int src = ensure(entry->arg1);
                    int val = get_imm(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "addi %s, %s, %d\n", get_reg_name(dst), get_reg_name(src), val);
                    free_if_unused(i, end, entry->arg1);
                    free_if_unused(i, end, entry->result);
                } else{
                    int src1 = ensure(entry->arg1);
                    int src2 = ensure(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "add %s, %s, %s\n", get_reg_name(dst), get_reg_name(src1), get_reg_name(src2));
                    free_if_unused(i, end, entry->arg1);
                    free_if_unused(i, end, entry->arg2);
                    free_if_unused(i, end, entry->result);
                }
                break;
            }
            case IR_OP_SUB: {
                if(is_imm(entry->arg1) && is_imm(entry->arg2)){
                    int res = get_imm(entry->arg1) - get_imm(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(dst), res);
                    free_if_unused(i, end, entry->result);
                } else if(is_imm(entry->arg1)){
                    int src = ensure(entry->arg2);
                    int val = get_imm(entry->arg1);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(dst), val);
                    fprintf(output_file, "sub %s, %s, %s\n", get_reg_name(dst), get_reg_name(dst), get_reg_name(src));
                    free_if_unused(i, end, entry->arg2);
                    free_if_unused(i, end, entry->result);
                } else if(is_imm(entry->arg2)){
                    int src = ensure(entry->arg1);
                    int val = get_imm(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "addi %s, %s, %d\n", get_reg_name(dst), get_reg_name(src), -val);
                    free_if_unused(i, end, entry->arg1);
                    free_if_unused(i, end, entry->result);
                } else{
                    int src1 = ensure(entry->arg1);
                    int src2 = ensure(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "sub %s, %s, %s\n", get_reg_name(dst), get_reg_name(src1), get_reg_name(src2));
                    free_if_unused(i, end, entry->arg1);
                    free_if_unused(i, end, entry->arg2);
                    free_if_unused(i, end, entry->result);
                }
                break;
            }      
        }
    }
}
