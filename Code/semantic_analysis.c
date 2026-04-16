#include "semantic_analysis.h"
#include "symbol_table.h"
#include "tree.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

static void handle_ext_def(TreeNode* node);
static Type* handle_specifier(TreeNode* node);
static void handle_var_dec(Type* type, TreeNode* node);
static void handle_fun_dec(Type* ret_type, TreeNode* node);
static void handle_comp_st(Type* ret_type, TreeNode* node);
static void handle_def(TreeNode* node);
static void handle_stmt(Type* ret_type, TreeNode* node);
static Type* handle_exp(TreeNode* node);

void analyze_semantics(TreeNode* root){
    if(!root) return;
    if(root->type == SU_Program){
        for(TreeNode* ext_def_list = root->child[0]; ext_def_list; ext_def_list = ext_def_list->child[1]){
            handle_ext_def(ext_def_list->child[0]);
        }
    }
}
// 未定义的错误将在程序中使用 Undefined Error 标注
// Error info
static void print_error(int type, int line, const char* attachment){
    switch (type) {
        case 1:  printf("Error type 1 at Line %d: Undefined variable \"%s\".\n", line, attachment); break;
        case 2:  printf("Error type 2 at Line %d: Undefined function \"%s\".\n", line, attachment); break;
        case 3:  printf("Error type 3 at Line %d: Redefined variable \"%s\".\n", line, attachment); break;
        case 4:  printf("Error type 4 at Line %d: Redefined function \"%s\".\n", line, attachment); break;
        case 5:  printf("Error type 5 at Line %d: Type mismatched for assignment.\n", line); break;
        case 6:  printf("Error type 6 at Line %d: The left-hand side of an assignment must be an lvalue.\n", line); break;
        case 7:  printf("Error type 7 at Line %d: Type mismatched for operands.\n", line); break;
        case 8:  printf("Error type 8 at Line %d: Type mismatched for return.\n", line); break;
        case 9:  printf("Error type 9 at Line %d: Function \"%s\" is not applicable for arguments.\n", line, attachment); break;
        case 10: printf("Error type 10 at Line %d: \"[]\" can only be applied to an array.\n", line); break;
        case 11: printf("Error type 11 at Line %d: \"%s\" is not a function.\n", line, attachment); break;
        case 12: printf("Error type 12 at Line %d: Array index must be an integer.\n", line); break;
        case 13: printf("Error type 13 at Line %d: \".\" can only be applied to a structure.\n", line); break;
        case 14: printf("Error type 14 at Line %d: Non-existent field \"%s\".\n", line, attachment); break;
        case 15: printf("Error type 15 at Line %d: Redefined field or initialized field \"%s\".\n", line, attachment); break;
        case 16: printf("Error type 16 at Line %d: Redefined struct \"%s\".\n", line, attachment); break;
        case 17: printf("Error type 17 at Line %d: Undefined struct \"%s\".\n", line, attachment); break;
        default: break;
    }
}

static void handle_ext_def(TreeNode* node){
    Type* type = handle_specifier(node->child[0]);
    switch (node->prod_id) {
        case 1: // ExtDef -> Specifier ExtDecList SEMI
            for(TreeNode* ext_dec_list = node->child[1]; ext_dec_list; ext_dec_list = ext_dec_list->prod_id == 1 ? NULL : ext_dec_list->child[2]){
                handle_var_dec(type, ext_dec_list->child[0]);
            }
            break;
        case 2: // ExtDef -> Specifier SEMI
            break;
        case 3: // ExtDef -> Specifier FunDec CompSt
            handle_fun_dec(type, node->child[1]);
            handle_comp_st(type, node->child[2]);
            break;
        default: assert(0); break;
    }
}

static void handle_var_dec(Type* type, TreeNode* node){
    if(node->prod_id == 1){ // VarDec -> ID       
        SymbolEntry* entry = (SymbolEntry*)malloc(sizeof(SymbolEntry));
        entry->name = node->child[0]->val.t_str;
        entry->kind = SYM_VAR;
        entry->var_type = type;
        int ok = insert_symbol(entry);
        if(!ok){
            print_error(3, node->line, entry->name);
        }
    } else if (node->prod_id == 2){ // VarDec -> VarDec LB INT RB
        TreeNode* p = node;
        Type* cur_type = type;
        while(p->prod_id == 2){
            Type* new_type = (Type*)malloc(sizeof(Type));
            new_type->kind = ARRAY;
            new_type->array.size = p->child[2]->val.t_int;
            new_type->array.elem = cur_type;
            cur_type = new_type;
            p = p->child[0];
        }
        SymbolEntry* entry = (SymbolEntry*)malloc(sizeof(SymbolEntry));
        entry->name = p->val.t_str;
        entry->kind = SYM_VAR;
        entry->var_type = cur_type;
        int ok = insert_symbol(entry);
        if(!ok){
            print_error(3, node->line, entry->name);
        }
    }
}

static Type* handle_struct_specifier(TreeNode* node){
    switch (node->prod_id) {
        case 1: { // StructSpecifier -> STRUCT OptTag LC DefList RC
            const char* tag_name = NULL;
            if(node->child[1]) tag_name = node->child[1]->child[0]->val.t_str;
            Type* type = (Type*)malloc(sizeof(Type));
            type->kind = STRUCT;
            type->structure = NULL;
            if(!node->child[3]){
                // Undefined Error: 空结构体
                return type;
            }
            int ok = 1;
            FieldList* field_p = NULL;
            for(TreeNode* def_list = node->child[3]; def_list; def_list = def_list->child[1]){
                TreeNode* def = def_list->child[0];
                Type* field_t = handle_specifier(def->child[0]);
                for(TreeNode* dec_list = def->child[1]; dec_list; dec_list = dec_list->prod_id == 1 ? NULL : dec_list->child[2]){
                    TreeNode* dec = dec_list->child[0];
                    TreeNode* var_dec = dec->child[0];
                    FieldList* field = (FieldList*)malloc(sizeof(FieldList));
                    field->next = NULL;
                    if(var_dec->prod_id == 1){ // VarDec -> ID
                        field->name = var_dec->child[0]->val.t_str;
                        field->type = field_t;
                        if(find_field(type, field->name)){
                            // redefined field
                            print_error(15, var_dec->line, field->name);
                            ok = 0;
                        }
                    } else if(var_dec->prod_id == 2){ // VarDec -> VarDec LB INT RB
                        TreeNode* p = var_dec;
                        Type* cur_type = field_t;
                        while(p->prod_id == 2){
                            Type* new_type = (Type*)malloc(sizeof(Type));
                            new_type->kind = ARRAY;
                            new_type->array.size = p->child[2]->val.t_int;
                            new_type->array.elem = cur_type;
                            cur_type = new_type;
                            p = p->child[0];
                        }
                        field->name = p->child[0]->val.t_str;
                        field->type = cur_type;
                    }
                    if(dec->prod_id == 2){
                        // initialized field
                        print_error(15, dec->line, field->name);
                        ok = 0;
                    }
                    if(field_p){
                        field_p->next = field;
                        field_p = field;
                    } else {
                        type->structure = field;
                        field_p = field;
                    }
                }
            }
            if(!ok){
                return NULL;
            }
            return type;
        }
        case 2: { // StructSpecifier -> STRUCT Tag
            const char* tag_name = node->child[1]->child[0]->val.t_str;
            SymbolEntry* sym = find_symbol(tag_name);
            if(!sym){
                print_error(17, node->child[1]->line, tag_name);
                return NULL;
            }else{
                if(sym->kind != SYM_STRUCT_TAG){
                    print_error(13, node->child[1]->line, tag_name);
                    return NULL;
                }else{
                    return sym->struct_type;
                }
            }
        }
        default: assert(0); break;
    }
    return NULL;
}

static Type* handle_specifier(TreeNode* node){
    switch (node->prod_id) {
        case 1: {// Specifier -> TYPE
            Type* type = (Type*)malloc(sizeof(Type));
            type->kind = BASIC;
            type->basic = node->child[0]->val.t_int;
            return type;
        }
        case 2: {// Specifier -> StructSpecifier
            return handle_struct_specifier(node->child[0]);
            break;
        }
        default: assert(0); break;
    }
    return NULL;
}

static void handle_fun_dec(Type* ret_type, TreeNode* node){
    SymbolEntry* entry = (SymbolEntry*)malloc(sizeof(SymbolEntry));
    entry->name = node->child[0]->val.t_str;
    entry->kind = SYM_FUNC;
    entry->func_info.ret_type = ret_type;
    entry->func_info.params = NULL;
    if(node->prod_id == 1){ // FunDec -> ID LP VarList RP
        FuncParam* param_p = NULL;
        for(TreeNode* varlist = node->child[2]; varlist; varlist = varlist->prod_id == 1 ? varlist->child[2] : NULL){
            TreeNode* param_dec = varlist->child[0];
            FuncParam* param = (FuncParam*)malloc(sizeof(FuncParam));
            param->type = handle_specifier(param_dec->child[0]);
            handle_var_dec(param->type, param_dec->child[1]);
            if(param_p){
                param_p->next = param;
                param_p = param;
            }else{
                entry->func_info.params = param;
                param_p = param;
            }
        }
    }
    int ok = insert_symbol(entry);
    if(!ok){
        print_error(4, node->line, entry->name);
    }
}

static void handle_comp_st(Type* ret_type, TreeNode* node){
    for(TreeNode* def_list = node->child[1]; def_list; def_list = def_list->child[1]){
        handle_def(def_list->child[0]);
    }
    for(TreeNode* stmt_list = node->child[2]; stmt_list; stmt_list = stmt_list->child[1]){
        handle_stmt(ret_type, stmt_list->child[0]);
    }
}

static void handle_def(TreeNode* node){
    Type* type = handle_specifier(node->child[0]);
    for(TreeNode* dec_list = node->child[1]; dec_list; dec_list = dec_list->prod_id == 1 ? NULL : dec_list->child[2]){
        TreeNode* dec = dec_list->child[0];
        handle_var_dec(type, dec);
        if(dec->prod_id == 2){
            Type* exp_type = handle_exp(dec->child[2]);
            if(!type_equal(type, exp_type)){
                print_error(5, dec->line, NULL);
            }
        }
    }
}

static void handle_stmt(Type* ret_type, TreeNode* node){
    switch(node->prod_id){
        case 1: { // Stmt : Exp SEMI
            handle_exp(node->child[0]);
            break;
        } 
        case 2: { // Stmt : CompSt
            handle_comp_st(ret_type, node->child[0]);
            break;
        }
        case 3: { // Stmt : RETURN Exp SEMI
            Type* exp_type = handle_exp(node->child[1]);
            if(!type_equal(ret_type, exp_type)){
                print_error(8, node->line, NULL);
            }
            break;
        }
        case 4: { // Stmt : IF LP Exp RP Stmt
            Type* exp_type = handle_exp(node->child[2]);
            if(!IS_INT(exp_type)){
                // Undefined Error: if condition is not an integer
                print_error(7, node->child[2]->line, NULL);
            }
            handle_stmt(ret_type, node->child[4]);
            break;
        }
        case 5: { // Stmt : IF LP Exp RP Stmt ELSE Stmt
            Type* exp_type = handle_exp(node->child[2]);
            if(!IS_INT(exp_type)){
                // Undefined Error: if condition is not an integer
                print_error(7, node->child[2]->line, NULL);
            }
            handle_stmt(ret_type, node->child[4]);
            handle_stmt(ret_type, node->child[6]);
            break;
        }
        case 6: { // Stmt : WHILE LP Exp RP Stmt
            Type* exp_type = handle_exp(node->child[2]);
            if(!IS_INT(exp_type)){
                // Undefined Error: while condition is not an integer
                print_error(7, node->child[2]->line, NULL);
            }
            handle_stmt(ret_type, node->child[4]);
            break;
        }
        default: assert(0); break;
    }
}

static int is_lvalue(TreeNode* node){
    if(!node) return 0;
    if(node->prod_id == 16){ // Exp : ID
        return 1;
    } else if(node->prod_id == 14){ // Exp : Exp LB Exp RB
        return 1;
    } else if(node->prod_id == 15){ // Exp : Exp DOT ID
        return 1;
    } else if(node->prod_id == 9){ // Exp : LP Exp RP
        return is_lvalue(node->child[1]);
    }
    return 0;
}

// TODO: 大量空指针没判定
static Type* handle_exp(TreeNode* node){
    switch (node->prod_id) {
        case 1: { // Exp : Exp ASSIGNOP Exp
            Type* left_type = handle_exp(node->child[0]);
            Type* right_type = handle_exp(node->child[2]);
            if(!is_lvalue(node->child[0])){
                print_error(6, node->line, NULL);
            }
            if(!type_equal(left_type, right_type)){
                print_error(5, node->line, NULL);
            }
            return left_type;
        }
        case 2: { // Exp : Exp AND Exp
            Type* left_type = handle_exp(node->child[0]);
            Type* right_type = handle_exp(node->child[2]);
            if(!IS_INT(left_type) || !IS_INT(right_type)){
                print_error(7, node->line, NULL);
            }
            return &INT;
        }
        case 3: { // Exp : Exp OR Exp
            Type* left_type = handle_exp(node->child[0]);
            Type* right_type = handle_exp(node->child[2]);
            if(!IS_INT(left_type) || !IS_INT(right_type)){
                print_error(7, node->line, NULL);
            }
            return &INT;
        }
        case 4: { // Exp : Exp RELOP Exp
            Type* left_type = handle_exp(node->child[0]);
            Type* right_type = handle_exp(node->child[2]);
            if(left_type->kind != BASIC || right_type->kind != BASIC || !type_equal(left_type, right_type)){
                print_error(7, node->line, NULL);
            }
            return &INT;
        }
        case 5: { // Exp : Exp PLUS Exp
            Type* left_type = handle_exp(node->child[0]);
            Type* right_type = handle_exp(node->child[2]);
            if(left_type->kind != BASIC || right_type->kind != BASIC || !type_equal(left_type, right_type)){
                print_error(7, node->line, NULL);
            }
            return left_type;
        }
        case 6: { // Exp : Exp MINUS Exp
            Type* left_type = handle_exp(node->child[0]);
            Type* right_type = handle_exp(node->child[2]);
            if(left_type->kind != BASIC || right_type->kind != BASIC || !type_equal(left_type, right_type)){
                print_error(7, node->line, NULL);
            }
            return left_type;
        }
        case 7: { // Exp : Exp STAR Exp
            Type* left_type = handle_exp(node->child[0]);
            Type* right_type = handle_exp(node->child[2]);
            if(left_type->kind != BASIC || right_type->kind != BASIC || !type_equal(left_type, right_type)){
                print_error(7, node->line, NULL);
            }
            return left_type;
        }
        case 8: { // Exp : Exp DIV Exp
            Type* left_type = handle_exp(node->child[0]);
            Type* right_type = handle_exp(node->child[2]);
            if(left_type->kind != BASIC || right_type->kind != BASIC || !type_equal(left_type, right_type)){
                print_error(7, node->line, NULL);
            }
            return left_type;
        }
        case 9: { // Exp : LP Exp RP
            return handle_exp(node->child[1]);
        }
        case 10: { // Exp : MINUS Exp
            Type* exp_type = handle_exp(node->child[1]);
            if(exp_type->kind != BASIC){
                print_error(7, node->line, NULL);
            }
            return exp_type;
        }
        case 11: { // Exp : NOT Exp
            Type* exp_type = handle_exp(node->child[1]);
            if(!IS_INT(exp_type)){
                print_error(7, node->line, NULL);
            }
            return &INT;
        }
        case 12: { // Exp : ID LP Args RP
            const char* func_name = node->child[0]->val.t_str;
            SymbolEntry* sym = find_symbol(func_name);
            if(!sym){
                print_error(2, node->line, func_name);
                return NULL;
            } else {
                if(sym->kind != SYM_FUNC){
                    print_error(11, node->line, func_name);
                    return NULL;
                } else {
                    FuncParam* param_p = sym->func_info.params;
                    for(TreeNode* arg_list = node->child[2]; arg_list; arg_list = arg_list->prod_id == 2 ? NULL : arg_list->child[2]){
                        TreeNode* exp = arg_list->child[0];
                        Type* exp_type = handle_exp(exp);
                        if(!param_p || !type_equal(exp_type, param_p->type)){
                            print_error(9, node->line, func_name);
                            return sym->func_info.ret_type;
                        }
                        param_p = param_p->next;
                    }
                    if(param_p){
                        print_error(9, node->line, func_name);
                    }
                    return sym->func_info.ret_type;
                }
            }
        }
        case 13: { // Exp : ID LP RP
            const char* func_name = node->child[0]->val.t_str;
            SymbolEntry* sym = find_symbol(func_name);
            if(!sym){
                print_error(2, node->line, func_name);
                return NULL;
            } else {
                if(sym->kind != SYM_FUNC){
                    print_error(11, node->line, func_name);
                    return NULL;
                } else {
                    return sym->func_info.ret_type;
                }
            }
        }
        case 14: { // Exp : Exp LB Exp RB
            Type* array_type = handle_exp(node->child[0]);
            Type* index_type = handle_exp(node->child[2]);
            if(array_type->kind != ARRAY){
                print_error(10, node->line, NULL);
                return NULL;
            }
            if(!IS_INT(index_type)){
                print_error(12, node->line, NULL);
                return NULL;
            }
            return array_type->array.elem;
        }
        case 15: { // Exp : Exp DOT ID
            Type* struct_type = handle_exp(node->child[0]);
            if(struct_type->kind != STRUCT){
                print_error(13, node->line, NULL);
                return NULL;
            }
            FieldList* field = find_field(struct_type, node->child[2]->val.t_str);
            if(!field){
                print_error(14, node->line, node->child[2]->val.t_str);
                return NULL;
            }
            return field->type;
        }
        case 16: { // Exp : ID
            const char* var_name = node->child[0]->val.t_str;
            SymbolEntry* sym = find_symbol(var_name);
            if(!sym){
                print_error(1, node->line, var_name);
                return NULL;
            } else {
                if(sym->kind != SYM_VAR){
                    print_error(1, node->line, var_name);
                    return NULL;
                } else {
                    return sym->var_type;
                }
            }
        }
        case 17: { // Exp : INT
            return &INT;
        }
        case 18: { // Exp : FLOAT
            return &FLOAT;
        }
        default: assert(0); break;
    }
}
