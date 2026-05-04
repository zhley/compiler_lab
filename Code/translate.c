#include "translate.h"

#include "ir.h"
#include "symbol_table.h"
#include <string.h>

static int ok = 1;

static IRInst* translate_func(TreeNode* node);
static IRInst* translate_compst(TreeNode* node);
static IRInst* translate_stmt(TreeNode* node);
static IRInst* translate_exp(TreeNode* node, const char* res);
static IRInst* translate_cond(TreeNode* node, const char* label_true, const char* label_false);
static IRInst* translate_array_struct(TreeNode* node, const char* res, Type** type);

IRInst* translate(TreeNode* root) {
    if(!root) return NULL;
    IRInst* ir = NULL;
    if(root->type == SU_Program){
        for(TreeNode* ext_def_list = root->child[0]; ext_def_list; ext_def_list = ext_def_list->child[1]){
            if(ext_def_list->child[0]->prod_id == 3){
                ir = link_ir(ir, translate_func(ext_def_list->child[0]));
            }
        }
    }
    if(!ok) return NULL;
    return ir;
}

static IRInst* translate_func(TreeNode* node){
    TreeNode* func_name = node->child[1]->child[0];
    IRInst* ir = new_ir(IR_OP_FUNCTION, func_name->val.t_str, NULL, NULL, 0);
    SymbolEntry* sym = find_symbol(func_name->val.t_str);
    for(FuncParam* param = sym->func_info.params; param; param = param->next){
        if(param->type->kind == ARRAY){
            ok = 0;
            printf("Cannot translate: Code contains variables of multi-dimensional array type or parameters of array type.\n");
            return NULL;
        }
        ir = link_ir(ir, new_ir(IR_OP_PARAM, NULL, new_var(param->name), NULL, 0));
    }
    ir = link_ir(ir, translate_compst(node->child[2]));
    return ir;
}

static IRInst* translate_compst(TreeNode* node){
    IRInst* ir = NULL;
    TreeNode* comp_st = node;
    for(TreeNode* def_list = comp_st->child[1]; def_list; def_list = def_list->child[1]){
        for(TreeNode* dec_list = def_list->child[0]->child[1]; dec_list; dec_list = dec_list->prod_id == 1 ? NULL : dec_list->child[2]){
            TreeNode* dec = dec_list->child[0];
            TreeNode* var_dec = dec->child[0];
            while(var_dec->prod_id == 2) var_dec = var_dec->child[0];
            const char* var_name = var_dec->child[0]->val.t_str;
            SymbolEntry* sym = find_symbol(var_name);
            if(sym->var_type->kind == ARRAY){
                const char* t = new_temp();
                ir = link_ir(ir, new_ir(IR_OP_DEC, t, to_str(get_size(sym->var_type)), NULL, 0));
                ir = link_ir(ir, new_ir(IR_OP_ADDRESS, new_var(var_name), t, NULL, 0));
            }else if(sym->var_type->kind == STRUCT){
                const char* t = new_temp();
                ir = link_ir(ir, new_ir(IR_OP_DEC, t, to_str(get_size(sym->var_type)), NULL, 0));
                ir = link_ir(ir, new_ir(IR_OP_ADDRESS, new_var(var_name), t, NULL, 0));
            }
            if(dec->prod_id == 2){
                const char* temp = new_temp();
                ir = link_ir(ir, translate_exp(dec->child[2], temp));
                ir = link_ir(ir, new_ir(IR_OP_ASSIGN, new_var(var_name), temp, NULL, 0));
            }
        }
    }
    for(TreeNode* stmt_list = comp_st->child[2]; stmt_list; stmt_list = stmt_list->child[1]){
        ir = link_ir(ir, translate_stmt(stmt_list->child[0]));
    }
    return ir;
}

static IRInst* translate_stmt(TreeNode* node){
    switch(node->prod_id){
        case 1: { // Stmt : Exp SEMI
            return translate_exp(node->child[0], new_temp());
        } 
        case 2: { // Stmt : CompSt
            return translate_compst(node->child[0]);
        }
        case 3: { // Stmt : RETURN Exp SEMI
            const char* temp = new_temp();
            IRInst* ir = translate_exp(node->child[1], temp);
            ir = link_ir(ir, new_ir(IR_OP_RETURN, temp, NULL, NULL, 0));
            return ir;
        }
        case 4: { // Stmt : IF LP Exp RP Stmt
            const char* label_true = new_label();
            const char* label_false = new_label();
            IRInst* ir = translate_cond(node->child[2], label_true, label_false);
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_true, NULL, NULL, 0));
            ir = link_ir(ir, translate_stmt(node->child[4]));
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_false, NULL, NULL, 0));
            return ir;
        }
        case 5: { // Stmt : IF LP Exp RP Stmt ELSE Stmt
            const char* label_true = new_label();
            const char* label_false = new_label();
            const char* label_end = new_label();
            IRInst* ir = translate_cond(node->child[2], label_true, label_false);
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_true, NULL, NULL, 0));
            ir = link_ir(ir, translate_stmt(node->child[4]));
            ir = link_ir(ir, new_ir(IR_OP_GOTO, label_end, NULL, NULL, 0));
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_false, NULL, NULL, 0));
            ir = link_ir(ir, translate_stmt(node->child[6]));
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_end, NULL, NULL, 0));
            return ir;
        }
        case 6: { // Stmt : WHILE LP Exp RP Stmt
            const char* label_begin = new_label();
            const char* label_true = new_label();
            const char* label_end = new_label();
            IRInst* ir = new_ir(IR_OP_LABEL, label_begin, NULL, NULL, 0);
            ir = link_ir(ir, translate_cond(node->child[2], label_true, label_end));
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_true, NULL, NULL, 0));
            ir = link_ir(ir, translate_stmt(node->child[4]));
            ir = link_ir(ir, new_ir(IR_OP_GOTO, label_begin, NULL, NULL, 0));
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_end, NULL, NULL, 0));
            return ir;
        }
    }
}

static IRInst* translate_exp(TreeNode* node, const char* res){
    switch(node->prod_id) {
        case 1: { // Exp : Exp ASSIGNOP Exp
            if(node->child[0]->prod_id == 16){ // ID
                const char* var_name = node->child[0]->child[0]->val.t_str;
                IRInst* ir = translate_exp(node->child[2], res);
                ir = link_ir(ir, new_ir(IR_OP_ASSIGN, new_var(var_name), res, NULL, 0));
                return ir;
            } else if(node->child[0]->prod_id == 14 || node->child[0]->prod_id == 15){ // array or struct
                const char* addr = new_temp();
                Type* type;
                IRInst* ir = translate_array_struct(node->child[0], addr, &type);
                ir = link_ir(ir, translate_exp(node->child[2], res));
                ir = link_ir(ir, new_ir(IR_OP_STORE, addr, res, NULL, 0));
                return ir;
            }
        }
        case 2:
        case 3:
        case 4:
        case 11: { // Exp : Exp AND/OR/RELOP Exp | NOT Exp
            const char* label_true = new_label();
            const char* label_false = new_label();
            IRInst* ir = new_ir(IR_OP_ASSIGN, res, new_imm(0), NULL, 0);
            ir = link_ir(ir, translate_cond(node, label_true, label_false));
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_true, NULL, NULL, 0));
            ir = link_ir(ir, new_ir(IR_OP_ASSIGN, res, new_imm(1), NULL, 0));
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_false, NULL, NULL, 0));
            return ir;
        }
        case 5: { // Exp : Exp PLUS Exp
            const char* temp1 = new_temp();
            const char* temp2 = new_temp();
            IRInst* ir = translate_exp(node->child[0], temp1);
            ir = link_ir(ir, translate_exp(node->child[2], temp2));
            ir = link_ir(ir, new_ir(IR_OP_ADD, res, temp1, temp2, 0));
            return ir;
        }
        case 6: { // Exp : Exp MINUS Exp
            const char* temp1 = new_temp();
            const char* temp2 = new_temp();
            IRInst* ir = translate_exp(node->child[0], temp1);
            ir = link_ir(ir, translate_exp(node->child[2], temp2));
            ir = link_ir(ir, new_ir(IR_OP_SUB, res, temp1, temp2, 0));
            return ir;
        }
        case 7: { // Exp : Exp STAR Exp
            const char* temp1 = new_temp();
            const char* temp2 = new_temp();
            IRInst* ir = translate_exp(node->child[0], temp1);
            ir = link_ir(ir, translate_exp(node->child[2], temp2));
            ir = link_ir(ir, new_ir(IR_OP_MUL, res, temp1, temp2, 0));
            return ir;
        }
        case 8: { // Exp : Exp DIV Exp
            const char* temp1 = new_temp();
            const char* temp2 = new_temp();
            IRInst* ir = translate_exp(node->child[0], temp1);
            ir = link_ir(ir, translate_exp(node->child[2], temp2));
            ir = link_ir(ir, new_ir(IR_OP_DIV, res, temp1, temp2, 0));
            return ir;
        }
        case 9: { // Exp : LP Exp RP
            return translate_exp(node->child[1], res);
        }
        case 10: { // Exp : MINUS Exp %prec MINUS_S
            const char* temp = new_temp();
            IRInst* ir = translate_exp(node->child[1], temp);
            ir = link_ir(ir, new_ir(IR_OP_SUB, res, new_imm(0), temp, 0));
            return ir;
        }
        case 12: { // Exp : ID LP Args RP
            const char* func_name = node->child[0]->val.t_str;
            IRInst* ir = NULL;
            if(strcmp(func_name, "write") == 0){
                const char* arg = new_temp();
                ir = link_ir(ir, translate_exp(node->child[2]->child[0], arg));
                ir = link_ir(ir, new_ir(IR_OP_WRITE, NULL, arg, NULL, 0));
                return ir;
            }
            IRInst* arg_ir = NULL;
            for(TreeNode* args = node->child[2]; args; args = args->prod_id == 2 ? NULL : args->child[2]){
                const char* arg = new_temp();
                IRInst* new_arg_ir = translate_exp(args->child[0], arg);
                new_arg_ir = link_ir(new_arg_ir, new_ir(IR_OP_ARG, NULL, arg, NULL, 0));
                arg_ir = link_ir(new_arg_ir, arg_ir);
            }
            ir = link_ir(ir, arg_ir);
            ir = link_ir(ir, new_ir(IR_OP_CALL, res, func_name, NULL, 0));
            return ir;
        }
        case 13: { // Exp : ID LP RP
            const char* func_name = node->child[0]->val.t_str;
            if(strcmp(func_name, "read") == 0){
                IRInst* ir = new_ir(IR_OP_READ, res, NULL, NULL, 0);
                return ir;
            }
            IRInst* ir = new_ir(IR_OP_CALL, res, func_name, NULL, 0);
            return ir;
        }
        case 14: { // Exp : Exp LB Exp RB
            const char* addr = new_temp();
            Type* type;
            IRInst* ir = translate_array_struct(node, addr, &type);
            if(type->kind == BASIC){
                ir = link_ir(ir, new_ir(IR_OP_LOAD, res, addr, NULL, 0));
            } else{
                ir = link_ir(ir, new_ir(IR_OP_ASSIGN, res, addr, NULL, 0));
            }
            return ir;
        }
        case 15: { // Exp : Exp DOT ID
            const char* addr = new_temp();
            Type* type;
            IRInst* ir = translate_array_struct(node, addr, &type);
            if(type->kind == BASIC){
                ir = link_ir(ir, new_ir(IR_OP_LOAD, res, addr, NULL, 0));
            } else{
                ir = link_ir(ir, new_ir(IR_OP_ASSIGN, res, addr, NULL, 0));
            }
            return ir;
        }
        case 16: { // Exp : ID
            const char* var_name = node->child[0]->val.t_str;
            IRInst* ir = new_ir(IR_OP_ASSIGN, res, new_var(var_name), NULL, 0);
            return ir;
        }
        case 17: { // Exp : INT
            int value = node->child[0]->val.t_int;
            IRInst* ir = new_ir(IR_OP_ASSIGN, res, new_imm(value), NULL, 0);
            return ir;
        }
        case 18: { // Exp : FLOAT // 浮点常数不会出现
            float value = node->child[0]->val.t_float;
            IRInst* ir = new_ir(IR_OP_ASSIGN, res, new_imm_f(value), NULL, 0);
            return ir;
        }
    }
}

static IRInst* translate_cond(TreeNode* node, const char* label_true, const char* label_false){
    switch (node->prod_id) {
        case 2: { // Exp : Exp AND Exp
            const char* label_mid = new_label();
            IRInst* ir = translate_cond(node->child[0], label_mid, label_false);
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_mid, NULL, NULL, 0));
            ir = link_ir(ir, translate_cond(node->child[2], label_true, label_false));
            return ir;
        }
        case 3: { // Exp : Exp OR Exp
            const char* label_mid = new_label();
            IRInst* ir = translate_cond(node->child[0], label_true, label_mid);
            ir = link_ir(ir, new_ir(IR_OP_LABEL, label_mid, NULL, NULL, 0));
            ir = link_ir(ir, translate_cond(node->child[2], label_true, label_false));
            return ir;
        }
        case 4: { // Exp : Exp RELOP Exp
            const char* temp1 = new_temp();
            const char* temp2 = new_temp();
            IRInst* ir = translate_exp(node->child[0], temp1);
            ir = link_ir(ir, translate_exp(node->child[2], temp2));
            ir = link_ir(ir, new_ir(IR_OP_IF_GOTO, label_true, temp1, temp2, node->child[1]->val.t_relop));
            ir = link_ir(ir, new_ir(IR_OP_GOTO, label_false, NULL, NULL, 0));
            return ir;
        }
        case 11: { // Exp : NOT Exp
            return translate_cond(node->child[1], label_false, label_true);
        }
        default: { // other cases (!=)
            const char* temp = new_temp();
            IRInst* ir = translate_exp(node, temp);
            ir = link_ir(ir, new_ir(IR_OP_IF_GOTO, label_true, temp, new_imm(0), RELOP_NEQ));
            ir = link_ir(ir, new_ir(IR_OP_GOTO, label_false, NULL, NULL, 0));
            return ir;
        }
    }
}

static IRInst* translate_array_struct(TreeNode* node, const char* addr, Type** type){
    switch (node->prod_id) {
        case 16: { // Exp : ID
            const char* var_name = node->child[0]->val.t_str;
            SymbolEntry* sym = find_symbol(var_name);
            *type = sym->var_type;
            return new_ir(IR_OP_ASSIGN, addr, new_var(var_name), NULL, 0);
        }
        case 14: { // Exp : Exp LB Exp RB
            Type* array_type;
            IRInst* ir = translate_array_struct(node->child[0], addr, &array_type);
            if(array_type->kind == ARRAY && array_type->array.elem->kind == ARRAY){
                ok = 0;
                printf("Cannot translate: Code contains variables of multi-dimensional array type or parameters of array type.\n");
                return NULL;
            }
            const char* idx = new_temp();
            const char* t = new_temp();
            ir = link_ir(ir, translate_exp(node->child[2], idx));
            ir = link_ir(ir, new_ir(IR_OP_MUL, t, idx, new_imm(get_size(array_type->array.elem)), 0));
            ir = link_ir(ir, new_ir(IR_OP_ADD, addr, addr, t, 0));
            *type = array_type->array.elem;
            return ir;
        }
        case 15: { // Exp : Exp DOT ID
            Type* struct_type;
            IRInst* ir = translate_array_struct(node->child[0], addr, &struct_type);
            const char* field_name = node->child[2]->val.t_str;
            int offset = 0;
            FieldList* field_p = struct_type->structure;
            while(field_p){
                if(strcmp(field_p->name, field_name) == 0){
                    break;
                }
                offset += get_size(field_p->type);
                field_p = field_p->next;
            }
            ir = link_ir(ir, new_ir(IR_OP_ADD, addr, addr, new_imm(offset), 0));
            *type = field_p->type;
            return ir;
        }
        case 9: { // Exp : LP Exp RP
            return translate_array_struct(node->child[1], addr, type);
        }
    }
}

