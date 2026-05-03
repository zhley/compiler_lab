#include "ir.h"
#include <stdio.h>
#include <stdlib.h>

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
