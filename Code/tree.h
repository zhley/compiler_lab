#ifndef __TREE_H__
#define __TREE_H__

typedef enum {
    SU_INT,
    SU_FLOAT,
    SU_ID,
    SU_TYPE,
    SU_STRUCT,
    SU_RETURN,
    SU_IF,
    SU_ELSE,
    SU_WHILE,
    SU_SEMI,
    SU_COMMA,
    SU_ASSIGNOP,
    SU_RELOP,
    SU_PLUS,
    SU_MINUS,
    SU_STAR,
    SU_DIV,
    SU_AND,
    SU_OR,
    SU_DOT,
    SU_NOT,
    SU_LP,
    SU_RP,
    SU_LB,
    SU_RB,
    SU_LC,
    SU_RC,
    SU_Program,
    SU_ExtDefList,
    SU_ExtDef,
    SU_ExtDecList,
    SU_Specifier,
    SU_StructSpecifier,
    SU_OptTag,
    SU_Tag,
    SU_VarDec,
    SU_FunDec,
    SU_VarList,
    SU_ParamDec,
    SU_CompSt,
    SU_StmtList,
    SU_Stmt,
    SU_DefList,
    SU_Def,
    SU_DecList,
    SU_Dec,
    SU_Exp,
    SU_Args,
    SU_NUM_SYNTAX_UNITS
} SyntaxUnit;

typedef struct TreeNode{
    SyntaxUnit type;
    union val {
        int t_int;
        float t_float;
        char* t_str;
    } val;
    unsigned int line;
    unsigned int prod_id; // production id

    struct TreeNode** child;
    unsigned int child_size;
} TreeNode;

extern const char* su_names[SU_NUM_SYNTAX_UNITS];

TreeNode* create_node(SyntaxUnit type, unsigned int child_size);
void add_node(TreeNode* node, unsigned int child_idx, TreeNode* child);
void free_tree(TreeNode* node);
void print_tree(TreeNode* root);

#endif
