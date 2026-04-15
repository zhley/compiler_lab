#include "tree.h"

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

TreeNode* create_node(SyntaxUnit type){
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->type = type;
    node->children.head = NULL;
    node->children.end = NULL;
    node->line = -1;
    node->prod_id = 0;
    node->next = NULL;
    return node;
}

void add_node(TreeNode* node, TreeNode* child){
    if(!node || !child) return;
    if(child->line < node->line) node->line = child->line;
    TreeNode* p = node->children.end;
    if(!p){
        node->children.head = child;
        node->children.end = child;
        return;
    }
    node->children.end->next = child;
    node->children.end = child;
}

void free_tree(TreeNode* node){
    TreeNode* p = node->children.head;
    if(!p) {
        if(node->type == SU_ID){
            free(node->val.t_str);
        }
        free(node);
        return;
    }
    while(p){
        TreeNode* t = p;
        p = p->next;
        free_tree(t);
    }
    free(node);
    return;
}

void _print(TreeNode* node, int level){
    for(int i = 0; i < level; ++i){
        printf("  ");
    }
    printf("%s", su_names[node->type]);
    if(node->children.head){
        printf(" (%d)\n", node->line);
        for(TreeNode* p = node->children.head; p != NULL; p = p->next){
            _print(p, level + 1);
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
