#include "ir.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

IRInst* link_ir(IRInst* head, IRInst* tail){
    if(!head) return tail;
    IRInst* p = head;
    while(p->next) p = p->next;
    p->next = tail;
    return head;
}

IRInst* new_ir(IROp opcode, const char* result, const char* arg1, const char* arg2, Relop relop){
    IRInst* inst = (IRInst*)malloc(sizeof(IRInst));
    inst->opcode = opcode;
    inst->result = result;
    inst->arg1 = arg1;
    inst->arg2 = arg2;
    inst->relop = relop;
    inst->next = NULL;
    return inst;
}

const char* new_temp(){
    static int temp_count = 0;
    char* temp_name = (char*)malloc(20);
    sprintf(temp_name, "t%d", temp_count++);
    return temp_name;
}

const char* new_label(){
    static int label_count = 0;
    char* label_name = (char*)malloc(20);
    sprintf(label_name, "label%d", label_count++);
    return label_name;
}

const char* new_var(const char* var_name){
    char* new_name = (char*)malloc(strlen(var_name) + 2);
    sprintf(new_name, "v%s", var_name);
    return new_name;
}

const char* to_str(int num){
    char* str = (char*)malloc(20);
    sprintf(str, "%d", num);
    return str;
}

const char* new_imm(int value){
    char* str = (char*)malloc(20);
    sprintf(str, "#%d", value);
    return str;
}

const char* new_imm_f(float value){
    char* str = (char*)malloc(20);
    sprintf(str, "#%f", value);
    return str;
}

void print_ir(IRInst* ir, FILE* output){
    IRInst* p = ir;
    while(p){
        switch(p->opcode){
            case IR_OP_LABEL:
                fprintf(output, "LABEL %s :\n", p->result);
                break;
            case IR_OP_FUNCTION:
                fprintf(output, "FUNCTION %s :\n", p->result);
                break;
            case IR_OP_ASSIGN:
                fprintf(output, "%s := %s\n", p->result, p->arg1);
                break;
            case IR_OP_ADD:
                fprintf(output, "%s := %s + %s\n", p->result, p->arg1, p->arg2);
                break;
            case IR_OP_SUB:
                fprintf(output, "%s := %s - %s\n", p->result, p->arg1, p->arg2);
                break;
            case IR_OP_MUL:
                fprintf(output, "%s := %s * %s\n", p->result, p->arg1, p->arg2);
                break;
            case IR_OP_DIV:
                fprintf(output, "%s := %s / %s\n", p->result, p->arg1, p->arg2);
                break;
            case IR_OP_ADDRESS:
                fprintf(output, "%s := &%s\n", p->result, p->arg1);
                break;
            case IR_OP_LOAD:
                fprintf(output, "%s := *%s\n", p->result, p->arg1);
                break;
            case IR_OP_STORE:
                fprintf(output, "*%s := %s\n", p->result, p->arg1);
                break;
            case IR_OP_GOTO:
                fprintf(output, "GOTO %s\n", p->result);
                break;
            case IR_OP_IF_GOTO:
                switch(p->relop){
                    case RELOP_EQ:  fprintf(output, "IF %s == %s GOTO %s\n", p->arg1, p->arg2, p->result); break;
                    case RELOP_NEQ: fprintf(output, "IF %s != %s GOTO %s\n", p->arg1, p->arg2, p->result); break;
                    case RELOP_LT:  fprintf(output, "IF %s < %s GOTO %s\n",  p->arg1, p->arg2, p->result); break;
                    case RELOP_LE:  fprintf(output, "IF %s <= %s GOTO %s\n", p->arg1, p->arg2, p->result); break;
                    case RELOP_GT:  fprintf(output, "IF %s > %s GOTO %s\n",  p->arg1, p->arg2, p->result); break;
                    case RELOP_GE:  fprintf(output, "IF %s >= %s GOTO %s\n", p->arg1, p->arg2, p->result); break;
                    default: break;
                }
                break;
            case IR_OP_RETURN:
                fprintf(output, "RETURN %s\n", p->result);
                break;
            case IR_OP_DEC:
                fprintf(output, "DEC %s %s\n", p->result, p->arg1);
                break;
            case IR_OP_ARG:
                fprintf(output, "ARG %s\n", p->arg1);
                break;
            case IR_OP_CALL:
                fprintf(output, "%s := CALL %s\n", p->result, p->arg1);
                break;
            case IR_OP_PARAM:
                fprintf(output, "PARAM %s\n", p->arg1);
                break;
            case IR_OP_READ:
                fprintf(output, "READ %s\n", p->result);
                break;
            case IR_OP_WRITE:
                fprintf(output, "WRITE %s\n", p->arg1);
                break;
        }
        p = p->next;
    }
}
