#include "tree.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

const char* su_names[SU_NUM_SYNTAX_UNITS] = {
    "INT",
    "FLOAT",
    "ID",
    "TYPE",
    "STRUCT",
    "RETURN",
    "IF",
    "ELSE",
    "WHILE",
    "SEMI",
    "COMMA",
    "ASSIGNOP",
    "RELOP",
    "PLUS",
    "MINUS",
    "STAR",
    "DIV",
    "AND",
    "OR",
    "DOT",
    "NOT",
    "LP",
    "RP",
    "LB",
    "RB",
    "LC",
    "RC",
    "Program",
    "ExtDefList",
    "ExtDef",
    "ExtDecList",
    "Specifier",
    "StructSpecifier",
    "OptTag",
    "Tag",
    "VarDec",
    "FunDec",
    "VarList",
    "ParamDec",
    "CompSt",
    "StmtList",
    "Stmt",
    "DefList",
    "Def",
    "DecList",
    "Dec",
    "Exp",
    "Args"
};

TreeNode* create_node(SyntaxUnit type, unsigned int child_size){
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->type = type;
    node->line = -1;
    node->prod_id = 0;
    node->child_size = child_size;
    node->child = (TreeNode**)malloc(child_size * sizeof(TreeNode*));
    for(unsigned int i = 0; i < child_size; ++i){
        node->child[i] = NULL;
    }
    return node;
}

void add_node(TreeNode* node, unsigned int child_idx, TreeNode* child){
    if(!node || !child) return;
    if(child->line < node->line) node->line = child->line;
    assert(child_idx < node->child_size);
    node->child[child_idx] = child;
}

// do not free
void free_tree(TreeNode* node){
    if(!node) return;
    for(unsigned int i = 0; i < node->child_size; ++i){
        free_tree(node->child[i]);
    }
    free(node->child);
    free(node);
}

void _print(TreeNode* node, int level){
    for(int i = 0; i < level; ++i){
        printf("  ");
    }
    printf("%s", su_names[node->type]);
    if(node->child_size > 0){
        printf(" (%d)\n", node->line);
        for(unsigned int i = 0; i < node->child_size; ++i){
            if(node->child[i]){
                _print(node->child[i], level + 1);
            }
        }
    }else{
        switch (node->type){
        case SU_TYPE: printf(": %s", node->val.t_int ? "int" : "float"); break;
        case SU_ID: printf(": %s", node->val.t_str); break;
        case SU_INT: printf(": %d", node->val.t_int); break;
        case SU_FLOAT: printf(": %f", node->val.t_float); break;
        default: break;
        }
        printf("\n");
    }
}

void print_tree(TreeNode* root){
    _print(root, 0);
}
