#include "semantic_analysis.h"
#include "symbol_table.h"
#include "tree.h"
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
        case 15: printf("Error type 15 at Line %d: Redefined field \"%s\".\n", line, attachment); break;
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
            for(TreeNode* child = node->children.head; child != NULL; child = child->next){
                process(child);
            }
            break;
    }
}

static void handle_def(TreeNode* node){
    Type* type = handle_specifier(node->children.head);
    switch (node->prod_id) {
        case 1: // ExtDef -> Specifier ExtDecList SEMI
            handle_var_dec(type, node->children.head->next);
            break;
        case 2: // ExtDef -> Specifier SEMI
            break;
        case 3: // ExtDef -> Specifier FunDec CompSt
            handle_func_dec(node);
            break;
        default:
            break;
    }
}

// static void handle_array_dec(Type* type, TreeNode* node){
//     if(node->prod_id == 2){ // VarDec -> VarDec LB INT RB
//         Type* new_type = (Type*)malloc(sizeof(Type));
//         new_type->kind = ARRAY;
//         new_type->array.elem = type;
//         new_type->array.size = node->children.head->next->next->val.t_int;
//         handle_array_arr(new_type, node->children.head);
//     } else if(node->prod_id == 1){ // VarDec -> ID
//         SymbolEntry* entry = (SymbolEntry*)malloc(sizeof(SymbolEntry));
//         entry->name = node->children.head->val.t_str;
//         entry->kind = SYM_VAR;
//         entry->var_type = type;
//         int ok = insert_symbol(entry);
//         if(!ok){
//             print_error(3, node->line, entry->name);
//             free(entry);
//         }
//     }
// }

static void handle_var_dec(Type* type, TreeNode* node){
    switch (node->type) {
        case SU_ExtDecList:
            if(node->prod_id == 1){ // ExtDecList -> VarDec
                handle_var_dec(type, node->children.head);
            } else if(node->prod_id == 2){ // ExtDecList -> VarDec COMMA ExtDecList
                handle_var_dec(type, node->children.head);
                handle_var_dec(type, node->children.head->next->next);
            }
            break;
        case SU_VarDec:
            if(node->prod_id == 1){ // VarDec -> ID       
                SymbolEntry* entry = (SymbolEntry*)malloc(sizeof(SymbolEntry));
                entry->name = node->children.head->val.t_str;
                entry->kind = SYM_VAR;
                entry->var_type = type;
                int ok = insert_symbol(entry);
                if(!ok){
                    print_error(3, node->line, entry->name);
                    free(entry);
                }
            } else if (node->prod_id == 2){ // VarDec -> VarDec LB INT RB
                Type* type;
                TreeNode* p = node;
                Type* cur_type;
                while(p->prod_id == 2){
                    cur_type->array.size = p->children.head->next->next;
                    p = p->children.head;
                }
            }
            break;
    }
}
