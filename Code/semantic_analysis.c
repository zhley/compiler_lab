#include "semantic_analysis.h"
#include "symbol_table.h"
#include "tree.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

static void process(TreeNode* node);
static void handle_def(TreeNode* node);
static Type* handle_specifier(TreeNode* node);
static void handle_var_dec(Type* type, TreeNode* node);

void analyze_semantics(TreeNode* root){
    if(!root) return;
    if(root->type == SU_Program){
        process(root);
    }
}

// Error info
static void print_error(int type, int line, const char* attachment){
    switch (type) {
        case 1:  printf("Error type 1 at Line %d: Undefined variable \"%s\".\n", line, attachment); break;
        case 2:  printf("Error type 2 at Line %d: Undefined function \"%s\".\n", line, attachment); break;
        case 3:  printf("Error type 3 at Line %d: Redefined variable \"%s\".\n", line, attachment); break;
        case 4:  printf("Error type 4 at Line %d: Redefined function \"%s\".\n", line, attachment); break;
        case 5:  printf("Error type 5 at Line %d: Type mismatched for assignment.\n", line); break;
        case 6:  printf("Error type 6 at Line %d: The left-hand side of an assignment must be a variable.\n", line); break;
        case 7:  printf("Error type 7 at Line %d: Type mismatched for operands.\n", line); break;
        case 8:  printf("Error type 8 at Line %d: Type mismatched for return.\n", line); break;
        case 9:  printf("Error type 9 at Line %d: Function \"%s\" is not applicable for arguments.\n", line, attachment); break;
        case 10: printf("Error type 10 at Line %d: \"%s\" is not an array.\n", line, attachment); break;
        case 11: printf("Error type 11 at Line %d: \"%s\" is not a function.\n", line, attachment); break;
        case 12: printf("Error type 12 at Line %d: \"%s\" is not an integer.\n", line, attachment); break;
        case 13: printf("Error type 13 at Line %d: \"%s\" is not a struct.\n", line, attachment); break;
        case 14: printf("Error type 14 at Line %d: Non-existent field \"%s\".\n", line, attachment); break;
        case 15: printf("Error type 15 at Line %d: Redefined field or initialized field \"%s\".\n", line, attachment); break;
        case 16: printf("Error type 16 at Line %d: Redefined struct \"%s\".\n", line, attachment); break;
        case 17: printf("Error type 17 at Line %d: Undefined struct \"%s\".\n", line, attachment); break;
        default: break;
    }
}

static void process(TreeNode* node){
    if(!node) return;
    switch (node->type) {
        case SU_ExtDef: handle_def(node); break;
        default:
            for(int i = 0; i < node->child_size; ++i){
                process(node->child[i]);
            }
            break;
    }
}

static void handle_def(TreeNode* node){
    Type* type = handle_specifier(node->child[0]);
    switch (node->prod_id) {
        case 1: // ExtDef -> Specifier ExtDecList SEMI
            handle_var_dec(type, node->child[1]);
            break;
        case 2: // ExtDef -> Specifier SEMI
            break;
        case 3: // ExtDef -> Specifier FunDec CompSt
            // TODO
            break;
        default:
            break;
    }
}

static void handle_var_dec(Type* type, TreeNode* node){
    if(!node) return;
    switch (node->type) {
        case SU_ExtDecList:
            if(node->prod_id == 1){ // ExtDecList -> VarDec
                handle_var_dec(type, node->child[0]);
            } else if(node->prod_id == 2){ // ExtDecList -> VarDec COMMA ExtDecList
                handle_var_dec(type, node->child[0]);
                handle_var_dec(type, node->child[2]);
            }
            break;
        case SU_VarDec:
            if(node->prod_id == 1){ // VarDec -> ID       
                SymbolEntry* entry = (SymbolEntry*)malloc(sizeof(SymbolEntry));
                entry->name = node->child[0]->val.t_str;
                entry->kind = SYM_VAR;
                entry->var_type = type;
                int ok = insert_symbol(entry);
                if(!ok){
                    print_error(3, node->line, entry->name);
                    free(entry);
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
                    free(entry);
                }
            }
            break;
    }
}

static Type* handle_struct_specifier(TreeNode* node){
    switch (node->prod_id) {
        case 1: { // StructSpecifier -> STRUCT OptTag LC DefList RC
            const char* tag_name = NULL;
            if(node->child[1]) tag_name = node->child[1]->child[0]->val.t_str;
            Type* type = (Type*)malloc(sizeof(Type));
            type->kind = STRUCT;
            if(!node->child[3]){
                // TODO: 空结构体
                type->structure = NULL;
                return type;
            }
            int ok = 1;
            type->structure = (FieldList*)malloc(sizeof(FieldList));
            FieldList* field = type->structure;
            for(TreeNode* def_list = node->child[3]; def_list; def_list = def_list->child[1]){
                TreeNode* def = def_list->child[0];
                Type* field_t = handle_specifier(def->child[0]);
                for(TreeNode* dec_list = def->child[1]; dec_list; dec_list = dec_list->prod_id == 1 ? NULL : dec_list->child[2]){
                    TreeNode* dec = dec_list->child[0];
                    TreeNode* var_dec = dec->child[0];
                    if(var_dec->prod_id == 1){ // VarDec -> ID
                        field->name = var_dec->child[0]->val.t_str;
                        field->type = field_t;
                        if(find_field(type, field->name)){
                            print_error(15, var_dec->line, field->name);
                            ok = 0;
                        }
                        field->next = (FieldList*)malloc(sizeof(FieldList));
                        field = field->next;
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
                        field->next = (FieldList*)malloc(sizeof(FieldList));
                        field = field->next;
                    }
                    if(dec->prod_id == 2){
                        print_error(15, dec->line, field->name);
                        ok = 0;
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