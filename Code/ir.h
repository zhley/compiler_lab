#ifndef __IR_H__
#define __IR_H__

#include "tree.h"
#include <stdio.h>

typedef enum IROp {
    IR_OP_LABEL,
    IR_OP_FUNCTION,
    IR_OP_ASSIGN,
    IR_OP_ADD,
    IR_OP_SUB,
    IR_OP_MUL,
    IR_OP_DIV,
    IR_OP_ADDRESS, // x := &y
    IR_OP_LOAD,    // x := *y
    IR_OP_STORE,   // *x := y
    IR_OP_GOTO,
    IR_OP_IF_GOTO, // if x relop y goto label
    IR_OP_RETURN,
    IR_OP_DEC,    // DEC x size
    IR_OP_ARG,
    IR_OP_CALL,   // x := CALL f
    IR_OP_PARAM,
    IR_OP_READ,
    IR_OP_WRITE
} IROp;

typedef struct IRInst {
    IROp opcode;
    const char* result;
    const char* arg1;
    const char* arg2;
    Relop relop; // for IR_OP_IF_GOTO
    struct IRInst* next;
} IRInst;

IRInst* link_ir(IRInst* head, IRInst* tail);
IRInst* new_ir(IROp opcode, const char* result, const char* arg1, const char* arg2, Relop relop);

const char* new_temp();
const char* new_label();

const char* to_str(int num);
const char* new_imm(int value);
const char* new_imm_f(float value);

void print_ir(IRInst* ir, FILE* output);

#endif