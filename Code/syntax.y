%{
    #define YYSTYPE TreeNode*

    #include <stdio.h>    
    #include "lex.yy.c"
    #include "tree.h"

    #define ADD_NODE1(name, aa, a1) aa = create_node(SU_##name); add_node(aa, a1);
    #define ADD_NODE2(name, aa, a1, a2) ADD_NODE1(name, aa, a1) add_node(aa, a2);
    #define ADD_NODE3(name, aa, a1, a2, a3) ADD_NODE2(name, aa, a1, a2) add_node(aa, a3);
    #define ADD_NODE4(name, aa, a1, a2, a3, a4) ADD_NODE3(name, aa, a1, a2, a3) add_node(aa, a4);
    #define ADD_NODE5(name, aa, a1, a2, a3, a4, a5) ADD_NODE4(name, aa, a1, a2, a3, a4) add_node(aa, a5);
    #define ADD_NODE6(name, aa, a1, a2, a3, a4, a5, a6) ADD_NODE5(name, aa, a1, a2, a3, a4, a5) add_node(aa, a6);
    #define ADD_NODE7(name, aa, a1, a2, a3, a4, a5, a6, a7) ADD_NODE6(name, aa, a1, a2, a3, a4, a5, a6) add_node(aa, a7);

    int yylex(void);
    int yyerror(const char*);

    extern TreeNode* root; 
    extern int ok;
%}

%token INT
%token FLOAT
%token ID
%token TYPE
%token STRUCT RETURN IF ELSE WHILE SEMI COMMA ASSIGNOP RELOP PLUS MINUS STAR DIV AND OR DOT NOT LP RP LB RB LC RC

%right ASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left STAR DIV
%right NOT MINUS_S
%left LP RP LB RB DOT

%right ELSE

%%
/* High-level definition */
Program : ExtDefList { ADD_NODE1(Program, $$, $1) root = $$; }
    ;
ExtDefList : ExtDef ExtDefList { ADD_NODE2(ExtDefList, $$, $1, $2) }
    | { $$ = NULL; }
    ;
ExtDef : Specifier ExtDecList SEMI { ADD_NODE3(ExtDef, $$, $1, $2, $3) }
    | Specifier SEMI { ADD_NODE2(ExtDef, $$, $1, $2) }
    | Specifier FunDec CompSt { ADD_NODE3(ExtDef, $$, $1, $2, $3) }
    | error SEMI
    ;
ExtDecList : VarDec { ADD_NODE1(ExtDecList, $$, $1) }
    | VarDec COMMA ExtDecList { ADD_NODE3(ExtDecList, $$, $1, $2, $3) }
    ;

/* Specifier */
Specifier : TYPE { ADD_NODE1(Specifier, $$, $1) }
    | StructSpecifier { ADD_NODE1(Specifier, $$, $1) }
    ;
StructSpecifier : STRUCT OptTag LC DefList RC { ADD_NODE5(StructSpecifier, $$, $1, $2, $3, $4, $5) }
    | STRUCT Tag { ADD_NODE2(StructSpecifier, $$, $1, $2) }
    | STRUCT error RC
    ;
OptTag : ID { ADD_NODE1(OptTag, $$, $1) }
    | { $$ = NULL; }
    ;
Tag : ID { ADD_NODE1(Tag, $$, $1) }
    ;

/* Declarator */
VarDec : ID { ADD_NODE1(VarDec, $$, $1) }
    | VarDec LB INT RB { ADD_NODE4(VarDec, $$, $1, $2, $3, $4) }
    | VarDec LB error RB
    ;
FunDec : ID LP VarList RP  { ADD_NODE4(FunDec, $$, $1, $2, $3, $4) }
    | ID LP RP { ADD_NODE3(FunDec, $$, $1, $2, $3) }
    | ID LP error RP
    ;
VarList : ParamDec COMMA VarList { ADD_NODE3(VarList, $$, $1, $2, $3) }
    | ParamDec { ADD_NODE1(VarList, $$, $1) }
    ;
ParamDec : Specifier VarDec { ADD_NODE2(ParamDec, $$, $1, $2) }
    ;

/* Statement */
CompSt : LC DefList StmtList RC { ADD_NODE4(CompSt, $$, $1, $2, $3, $4) }
    | error RC
    ;
StmtList : Stmt StmtList { ADD_NODE2(StmtList, $$, $1, $2) }
    | { $$ = NULL; }
    ;
Stmt : Exp SEMI { ADD_NODE2(Stmt, $$, $1, $2) }
    | CompSt { ADD_NODE1(Stmt, $$, $1) }
    | RETURN Exp SEMI { ADD_NODE3(Stmt, $$, $1, $2, $3) }
    | IF LP Exp RP Stmt %prec ELSE { ADD_NODE5(Stmt, $$, $1, $2, $3, $4, $5) }
    | IF LP Exp RP Stmt ELSE Stmt { ADD_NODE7(Stmt, $$, $1, $2, $3, $4, $5, $6, $7) }
    | WHILE LP Exp RP Stmt { ADD_NODE5(Stmt, $$, $1, $2, $3, $4, $5) }
    | error SEMI 
    ;

/* Local definition */
DefList : Def DefList { ADD_NODE2(DefList, $$, $1, $2) }
    | { $$ = NULL; }
    ;
Def : Specifier DecList SEMI { ADD_NODE3(Def, $$, $1, $2, $3) }
    | Specifier error SEMI
    ;
DecList : Dec { ADD_NODE1(DecList, $$, $1) }
    | Dec COMMA DecList { ADD_NODE3(DecList, $$, $1, $2, $3) }
    ;
Dec : VarDec { ADD_NODE1(Dec, $$, $1) }
    | VarDec ASSIGNOP Exp { ADD_NODE3(Dec, $$, $1, $2, $3) }
    ;

/* Expression */
Exp : Exp ASSIGNOP Exp { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | Exp AND Exp { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | Exp OR Exp { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | Exp RELOP Exp { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | Exp PLUS Exp { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | Exp MINUS Exp { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | Exp STAR Exp { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | Exp DIV Exp { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | LP Exp RP { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | MINUS Exp %prec MINUS_S { ADD_NODE2(Exp, $$, $1, $2) }
    | NOT Exp { ADD_NODE2(Exp, $$, $1, $2) }
    | ID LP Args RP { ADD_NODE4(Exp, $$, $1, $2, $3, $4) }
    | ID LP RP { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | Exp LB Exp RB { ADD_NODE4(Exp, $$, $1, $2, $3, $4) }
    | Exp DOT ID { ADD_NODE3(Exp, $$, $1, $2, $3) }
    | ID { ADD_NODE1(Exp, $$, $1) }
    | INT { ADD_NODE1(Exp, $$, $1) }
    | FLOAT { ADD_NODE1(Exp, $$, $1) }
    | LP error RP
    | Exp LB error RB
    ;
Args : Exp COMMA Args { ADD_NODE3(Args, $$, $1, $2, $3) }
    | Exp { ADD_NODE1(Args, $$, $1) }
    ;

%%

int yyerror(const char* msg){
    ok = 0;
    printf("Error type B at Line %d: %s.\n", yylineno, msg); 
}
