#include "codegen.h"

#include "ir.h"
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define MAX_VAR 10000
#define MAX_IR 10000
#define REG_NUM 19

#define OFFSET(slot) (-12 - (slot) * 4)

static const char* begin_asm = ".data\n_prompt: .asciiz \"Enter an integer:\"\n_ret: .asciiz \"\\n\"\n.globl main\n.text\nread:\nli $v0, 4\nla $a0, _prompt\nsyscall\nli $v0, 5\nsyscall\njr $ra\nwrite:\nli $v0, 1\nsyscall\nli $v0, 4\nla $a0, _ret\nsyscall\nmove $v0, $0\njr $ra\n";

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
    int next_use; // 寄存器中变量的下一次使用位置, -1表示未计算
} RegDesc;

typedef struct VarDesc {
    int reg_idx; // 变量所在寄存器, 寄存器free时不会清除该项, 只有在被其他变量占用时才会置-1.
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
const char* func_name;

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
    vars[var_map_size].reg_idx = -1;
    vars[var_map_size].slot = -1;
    return var_map_size++;
}

int make_local_slot(){
    return local_var_cnt++;
}

const char* get_reg_name(int reg_idx){
    switch (reg_idx) {
        case 0: return "$t0";
        case 1: return "$t1";
        case 2: return "$t2";
        case 3: return "$t3";
        case 4: return "$t4";
        case 5: return "$t5";
        case 6: return "$t6";
        case 7: return "$t7";
        case 8: return "$t8";
        case 9: return "$t9";
        case 10: return "$s0";
        case 11: return "$s1";
        case 12: return "$s2";
        case 13: return "$s3";
        case 14: return "$s4";
        case 15: return "$s5";
        case 16: return "$s6";
        case 17: return "$s7";
        case 18: return "$v1"; // v0寄存器用于函数返回值
        default: assert(0); return NULL;
    }
}

// register allocation
void init_allocation(){
    for(int i = 0; i < REG_NUM; i++){
        regs[i].is_free = 1;
        regs[i].var_idx = -1;
        regs[i].next_use = -1;
    }
}

int allocate(const char* var_name){
    int var_idx = get_var_idx(var_name);
    if(vars[var_idx].reg_idx != -1){
        return vars[var_idx].reg_idx;
    }
    for(int i = 0; i < REG_NUM; i++){
        if(regs[i].is_free){
            if(regs[i].var_idx != -1){
                vars[regs[i].var_idx].reg_idx = -1;
            }
            regs[i].is_free = 0;
            regs[i].var_idx = var_idx;
            vars[var_idx].reg_idx = i;
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

    int vic_var_idx = regs[victim].var_idx;
    if(vars[vic_var_idx].slot == -1){
        vars[vic_var_idx].slot = make_local_slot(); // 分配局部变量槽
    }
    vars[vic_var_idx].reg_idx = -1;
    fprintf(output_file, "sw %s, %d($fp)\n", get_reg_name(victim), OFFSET(vars[vic_var_idx].slot));

    regs[victim].var_idx = var_idx;
    regs[victim].is_free = 0;
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
    fprintf(output_file, "lw %s, %d($fp)\n", get_reg_name(reg_idx), OFFSET(vars[var_idx].slot));
    return reg_idx;
}

void free_if_unused(int cur_ir_idx, int block_end, const char* var_name){
    int var_idx = get_var_idx(var_name);
    int reg_idx = vars[var_idx].reg_idx;
    if(reg_idx == -1) return;
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
        if(vars[var_idx].slot == -1){
            vars[var_idx].slot = make_local_slot();
        }
        fprintf(output_file, "sw %s, %d($fp)\n", get_reg_name(reg_idx), OFFSET(vars[var_idx].slot));

        regs[reg_idx].is_free = 1;
        regs[reg_idx].var_idx = -1;
        regs[reg_idx].next_use = -1;
        vars[var_idx].reg_idx = -1;
    }
}

/*

high
+-----------------------+
| caller frame          |
+-----------------------+
| ...                   |
| arg6                  |
| arg5                  |
+-----------------------+ <- $fp
| saved $ra             |
+-----------------------+
| old $fp               |
+-----------------------+
| slot 0                | ($fp - 12)
| slot 1                |
| ...                   |
+-----------------------+
| dynamic (args)        |
+-----------------------+ <- $sp
low
*/

void transform_ir(IRInst* ir);
void gencode_func(int begin, int end);
void gencode_block(int begin, int end);

void generate_code(IRInst* ir, FILE* output) {
    output_file = output;
    fprintf(output_file, "%s\n", begin_asm);
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
        // NOTE: 根据中间代码生成的特点, DEC指令后必定是一个ADDRESS指令, 
        // 并且ADDRESS指令也只在这里出现, 所以直接将这两条指令合并, DEC指令直接返回地址.
        if(p->opcode == IR_OP_DEC){
            ir_count--;
            IRInst* next = p->next;
            assert(next);
            assert(next->opcode == IR_OP_ADDRESS);
            ir_table[i].opcode = IR_OP_DEC;
            ir_table[i].result = next->result;
            ir_table[i].arg1 = p->arg1;
            ir_table[i].arg2 = NULL;
            ir_table[i].relop = 0;
            i++;
            p = next;
            continue;
        }
        ir_table[i].opcode = p->opcode;
        ir_table[i].result = p->result;
        ir_table[i].arg1 = p->arg1;
        ir_table[i].arg2 = p->arg2;
        ir_table[i].relop = p->relop;
        i++;
    }
}

void gencode_func(int begin, int end) {
    int start = begin;
    assert(ir_table[start].opcode == IR_OP_FUNCTION);
    var_map_size = 0;
    local_var_cnt = 0;
    func_name = ir_table[start].result;
    if(strcmp(func_name, "main") == 0) fprintf(output_file, "main:\n");
    else fprintf(output_file, "f_%s:\n", func_name);
    fprintf(output_file, "addi $sp, $sp, -8\n");
    fprintf(output_file, "sw $ra, 4($sp)\n");
    fprintf(output_file, "sw $fp, 0($sp)\n");
    fprintf(output_file, "addi $fp, $sp, 8\n");
    long int pos = ftell(output_file);
    fprintf(output_file, "addi $sp, $sp,                     \n"); // 预留空间, 稍后回填
    int cnt = 0;
    start++;
    while(start < end && ir_table[start].opcode == IR_OP_PARAM){
        cnt++;
        int var_idx = get_var_idx(ir_table[start].arg1);
        assert(vars[var_idx].slot == -1);
        vars[var_idx].slot = make_local_slot();
        if(cnt <= 4){
            fprintf(output_file, "sw $a%d, %d($fp)\n", cnt - 1, OFFSET(vars[var_idx].slot));
        } else{
            fprintf(output_file, "lw $t0, %d($fp)\n", (cnt - 5) * 4);
            fprintf(output_file, "sw $t0, %d($fp)\n", OFFSET(vars[var_idx].slot));
        }
        start++;
    }

    int l = start;
    int r = -1;
    for(int i = start; i < end; i++) {
        if(ir_table[i].opcode == IR_OP_LABEL){
            r = i;
            gencode_block(l, r);
            l = r;
        }else if(ir_table[i].opcode == IR_OP_GOTO || ir_table[i].opcode == IR_OP_IF_GOTO || ir_table[i].opcode == IR_OP_RETURN){
            r = i + 1;
            gencode_block(l, r);
            l = r;
        }else if(ir_table[i].opcode == IR_OP_ARG){
            r = i;
            gencode_block(l, r);
            l = r;
            while(i < end && ir_table[i].opcode != IR_OP_CALL) {
                assert(ir_table[i].opcode == IR_OP_ARG);
                i++;
            }
            assert(i < end && ir_table[i].opcode == IR_OP_CALL);
            r = i + 1;
            gencode_block(l, r);
            l = r;
        }else if(ir_table[i].opcode == IR_OP_CALL){
            r = i;
            gencode_block(l, r);
            gencode_block(r, r + 1);
            l = r + 1;
        }
    }
    if(l < end) gencode_block(l, end);
    fprintf(output_file, "ret_%s:\n", func_name);
    fprintf(output_file, "lw $ra, -4($fp)\n");
    fprintf(output_file, "lw $fp, -8($fp)\n");
    int frame_size = (local_var_cnt + 2) * 4;
    fprintf(output_file, "addi $sp, $sp, %d\n", frame_size);
    fprintf(output_file, "jr $ra\n");

    // 回填
    fseek(output_file, pos + 15, SEEK_SET);
    fprintf(output_file, "%d", -(frame_size - 8));
    fseek(output_file, 0, SEEK_END);
}

void spill_all(){
    for(int i = 0; i < REG_NUM; i++){
        if(!regs[i].is_free){
            int var_idx = regs[i].var_idx;
            if(vars[var_idx].slot == -1){
                vars[var_idx].slot = make_local_slot();
            }
            fprintf(output_file, "sw %s, %d($fp)\n", get_reg_name(i), OFFSET(vars[var_idx].slot));
        }
    }
}

void gencode_block(int begin, int end) {
    if(begin >= end) return;
    if(ir_table[end - 1].opcode == IR_OP_CALL){
        int cnt = end - 1 - begin;
        if(cnt <= 4){
            for(int i = cnt - 1; i >= 0; i--){
                assert(ir_table[begin + i].opcode == IR_OP_ARG);
                int var_idx = get_var_idx(ir_table[begin + i].arg1);
                if(vars[var_idx].reg_idx != -1){
                    int reg_idx = vars[var_idx].reg_idx;
                    fprintf(output_file, "move $a%d, %s\n", cnt - 1 - i, get_reg_name(reg_idx));
                } else{
                    assert(vars[var_idx].slot != -1);
                    fprintf(output_file, "lw $a%d, %d($fp)\n", cnt - 1 - i, OFFSET(vars[var_idx].slot));
                }
            }
            if(strcmp(ir_table[end - 1].arg1, "main") == 0) fprintf(output_file, "jal main\n");
            else fprintf(output_file, "jal f_%s\n", ir_table[end - 1].arg1);
        } else{
            for(int i = 3; i >= 0; i--){
                assert(ir_table[begin + i].opcode == IR_OP_ARG);
                int var_idx = get_var_idx(ir_table[begin + i].arg1);
                if(vars[var_idx].reg_idx != -1){
                    int reg_idx = vars[var_idx].reg_idx;
                    fprintf(output_file, "move $a%d, %s\n", 3 - i, get_reg_name(reg_idx));
                } else{
                    assert(vars[var_idx].slot != -1);
                    fprintf(output_file, "lw $a%d, %d($fp)\n", 3 - i, OFFSET(vars[var_idx].slot));
                }
            }
            fprintf(output_file, "addi $sp, $sp, -%d\n", (cnt - 4) * 4);
            for(int i = 4; i < cnt; i++){
                assert(ir_table[begin + i].opcode == IR_OP_ARG);
                int var_idx = get_var_idx(ir_table[begin + i].arg1);
                if(vars[var_idx].reg_idx != -1){
                    int reg_idx = vars[var_idx].reg_idx;
                    fprintf(output_file, "sw %s, %d($sp)\n", get_reg_name(reg_idx), (i - 4) * 4);
                } else{
                    assert(vars[var_idx].slot != -1);
                    if(regs[0].var_idx != -1) {
                        vars[regs[0].var_idx].reg_idx = -1;
                        regs[0].var_idx = -1;
                    }
                    fprintf(output_file, "lw %s, %d($fp)\n", get_reg_name(0), OFFSET(vars[var_idx].slot));
                    fprintf(output_file, "sw %s, %d($sp)\n", get_reg_name(0), (i - 4) * 4);
                }
            }
            if(strcmp(ir_table[end - 1].arg1, "main") == 0) fprintf(output_file, "jal main\n");
            else fprintf(output_file, "jal f_%s\n", ir_table[end - 1].arg1);
            fprintf(output_file, "addi $sp, $sp, %d\n", (cnt - 4) * 4);
        }
        int ret = get_var_idx(ir_table[end - 1].result);
        if(vars[ret].slot == -1){
            vars[ret].slot = make_local_slot();
        }
        fprintf(output_file, "sw $v0, %d($fp)\n", OFFSET(vars[ret].slot));
        return;
    }
    init_allocation();
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
            case IR_OP_MUL: {
                if(is_imm(entry->arg1) && is_imm(entry->arg2)){
                    int res = get_imm(entry->arg1) * get_imm(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(dst), res);
                    free_if_unused(i, end, entry->result);
                } else if(is_imm(entry->arg1)){
                    int src = ensure(entry->arg2);
                    int val = get_imm(entry->arg1);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(dst), val);
                    fprintf(output_file, "mul %s, %s, %s\n", get_reg_name(dst), get_reg_name(dst), get_reg_name(src));
                    free_if_unused(i, end, entry->arg2);
                    free_if_unused(i, end, entry->result);
                } else if(is_imm(entry->arg2)){
                    int src = ensure(entry->arg1);
                    int val = get_imm(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(dst), val);
                    fprintf(output_file, "mul %s, %s, %s\n", get_reg_name(dst), get_reg_name(src), get_reg_name(dst));
                    free_if_unused(i, end, entry->arg1);
                    free_if_unused(i, end, entry->result);
                } else{
                    int src1 = ensure(entry->arg1);
                    int src2 = ensure(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "mul %s, %s, %s\n", get_reg_name(dst), get_reg_name(src1), get_reg_name(src2));
                    free_if_unused(i, end, entry->arg1);
                    free_if_unused(i, end, entry->arg2);
                    free_if_unused(i, end, entry->result);
                }
                break;
            }  
            case IR_OP_DIV: {
                if(is_imm(entry->arg1) && is_imm(entry->arg2)){
                    int res = get_imm(entry->arg1) / get_imm(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(dst), res);
                    free_if_unused(i, end, entry->result);
                } else if(is_imm(entry->arg1)){
                    int src = ensure(entry->arg2);
                    int val = get_imm(entry->arg1);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(dst), val);
                    fprintf(output_file, "div %s, %s\n", get_reg_name(dst), get_reg_name(src));
                    fprintf(output_file, "mflo %s\n", get_reg_name(dst));
                    free_if_unused(i, end, entry->arg2);
                    free_if_unused(i, end, entry->result);
                } else if(is_imm(entry->arg2)){
                    int src = ensure(entry->arg1);
                    int val = get_imm(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(dst), val);
                    fprintf(output_file, "div %s, %s\n", get_reg_name(src), get_reg_name(dst));
                    fprintf(output_file, "mflo %s\n", get_reg_name(dst));
                    free_if_unused(i, end, entry->arg1);
                    free_if_unused(i, end, entry->result);
                } else{
                    int src1 = ensure(entry->arg1);
                    int src2 = ensure(entry->arg2);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "div %s, %s\n", get_reg_name(src1), get_reg_name(src2));
                    fprintf(output_file, "mflo %s\n", get_reg_name(dst));
                    free_if_unused(i, end, entry->arg1);
                    free_if_unused(i, end, entry->arg2);
                    free_if_unused(i, end, entry->result);
                }
                break;
            }
            case IR_OP_ASSIGN: {
                if(is_imm(entry->arg1)){
                    int val = get_imm(entry->arg1);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(dst), val);
                    free_if_unused(i, end, entry->result);
                } else{
                    int src = ensure(entry->arg1);
                    int dst = allocate(entry->result);
                    fprintf(output_file, "move %s, %s\n", get_reg_name(dst), get_reg_name(src));
                    free_if_unused(i, end, entry->arg1);
                    free_if_unused(i, end, entry->result);
                }
                break;
            }
            case IR_OP_LABEL: {
                fprintf(output_file, "%s:\n", entry->result);
                break;
            }
            case IR_OP_LOAD: {
                int dst = allocate(entry->result);
                int src = ensure(entry->arg1);
                fprintf(output_file, "lw %s, 0(%s)\n", get_reg_name(dst), get_reg_name(src));
                free_if_unused(i, end, entry->arg1);
                free_if_unused(i, end, entry->result);
                break;
            }
            case IR_OP_STORE: {
                // store指令是用来修改数组元素的, 寄存器不会存储数组元素, 所以不会出现内存的值比寄存器的值更新的情况
                int src = ensure(entry->arg1);
                int dst = ensure(entry->result);
                fprintf(output_file, "sw %s, 0(%s)\n", get_reg_name(src), get_reg_name(dst));
                free_if_unused(i, end, entry->arg1);
                free_if_unused(i, end, entry->result);
                break;
            }
            case IR_OP_DEC: {
                int dst = allocate(entry->result);
                int size = atoi(entry->arg1);
                local_var_cnt += size / 4;
                int slot = local_var_cnt - 1;
                fprintf(output_file, "addi %s, $fp, %d\n", get_reg_name(dst), OFFSET(slot));
                free_if_unused(i, end, entry->result);
                break;
            }
            case IR_OP_ADDRESS: assert(0); break; 
            case IR_OP_GOTO: {
                assert(i == end - 1);
                spill_all();
                fprintf(output_file, "j %s\n", entry->result);
                return;
            }
            case IR_OP_IF_GOTO: {
                assert(i == end - 1);
                spill_all();
                if(regs[0].var_idx != -1) {
                    vars[regs[0].var_idx].reg_idx = -1;
                    regs[0].var_idx = -1;
                }
                if(regs[1].var_idx != -1) {
                    vars[regs[1].var_idx].reg_idx = -1;
                    regs[1].var_idx = -1;
                }
                int var1 = get_var_idx(entry->arg1);
                if(vars[var1].slot == -1) vars[var1].slot = make_local_slot();
                fprintf(output_file, "lw %s, %d($fp)\n", get_reg_name(0), OFFSET(vars[var1].slot));
                if(is_imm(entry->arg2)){
                    int val = get_imm(entry->arg2);
                    fprintf(output_file, "li %s, %d\n", get_reg_name(1), val);
                } else{
                    int var2 = get_var_idx(entry->arg2);
                    if(vars[var2].slot == -1) vars[var2].slot = make_local_slot();
                    fprintf(output_file, "lw %s, %d($fp)\n", get_reg_name(1), OFFSET(vars[var2].slot));
                }
                const char* op;
                switch (entry->relop) {
                    case RELOP_EQ: op = "beq"; break;
                    case RELOP_NEQ: op = "bne"; break;
                    case RELOP_LT: op = "blt"; break;
                    case RELOP_LE: op = "ble"; break;
                    case RELOP_GT: op = "bgt"; break;
                    case RELOP_GE: op = "bge"; break;
                    default: assert(0); return;
                }
                fprintf(output_file, "%s %s, %s, %s\n", op, get_reg_name(0), get_reg_name(1), entry->result);
                return;
            }
            case IR_OP_RETURN: {
                assert(i == end - 1);
                spill_all();
                if(entry->result){
                    int val_var = get_var_idx(entry->result);
                    if(vars[val_var].slot == -1) vars[val_var].slot = make_local_slot();
                    fprintf(output_file, "lw $v0, %d($fp)\n", OFFSET(vars[val_var].slot));
                }
                fprintf(output_file, "j ret_%s\n", func_name);
                return;
            }
            case IR_OP_READ: {
                int dst = allocate(entry->result);
                fprintf(output_file, "jal read\n");
                fprintf(output_file, "move %s, $v0\n", get_reg_name(dst));
                free_if_unused(i, end, entry->result);
                break;
            }
            case IR_OP_WRITE: {
                int src = ensure(entry->arg1);
                fprintf(output_file, "move $a0, %s\n", get_reg_name(src));
                fprintf(output_file, "jal write\n");
                free_if_unused(i, end, entry->arg1);
                break;
            }
            default: assert(0); break;
        }
    }
    spill_all();
}
