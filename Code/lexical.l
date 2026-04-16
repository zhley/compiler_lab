%option     yylineno

%{
    #include "tree.h"
    #include "syntax.tab.h"  

    extern int ok;

    char* str_save(const char* src);  
%}

BLANK       [ \t\n\r]+
INT         (0[xX][0-9a-fA-F]+)|(0[0-7]+)|([1-9][0-9]*)|0
FLOAT       (([1-9][0-9]*)|0)\.([0-9]+)
ID          [a-zA-Z_][a-zA-Z_0-9]*
SEMI        ;
COMMA       ,
ASSIGNOP    =
RELOP       >|<|>=|<=|==|!=
PLUS        \+
MINUS       -
STAR        \*
DIV         \/
AND         &&
OR          \|\|
DOT         \.
NOT         !
TYPE        int|float
LP          \(
RP          \)
LB          \[
RB          \]
LC          \{
RC          \}
STRUCT      struct
RETURN      return
IF          if
ELSE        else
WHILE       while
%%
{BLANK}             { ; }
{TYPE}              { yylval = create_node(SU_TYPE, 0); yylval->line = yylineno; yylval->val.t_int = (yytext[0] == 'i'); return TYPE; }
{STRUCT}            { yylval = create_node(SU_STRUCT, 0); yylval->line = yylineno; return STRUCT; }
{RETURN}            { yylval = create_node(SU_RETURN, 0); yylval->line = yylineno; return RETURN; }
{IF}                { yylval = create_node(SU_IF, 0); yylval->line = yylineno; return IF; }
{ELSE}              { yylval = create_node(SU_ELSE, 0); yylval->line = yylineno; return ELSE; }
{WHILE}             { yylval = create_node(SU_WHILE, 0); yylval->line = yylineno; return WHILE; }
{INT}               { yylval = create_node(SU_INT, 0); yylval->line = yylineno; yylval->val.t_int = strtol(yytext, NULL, 0); return INT; }
{FLOAT}             { yylval = create_node(SU_FLOAT, 0); yylval->line = yylineno; yylval->val.t_float = atof(yytext); return FLOAT; }
{ID}                { yylval = create_node(SU_ID, 0); yylval->line = yylineno; yylval->val.t_str = str_save(yytext); return ID; }
{SEMI}              { yylval = create_node(SU_SEMI, 0); yylval->line = yylineno; return SEMI; }
{COMMA}             { yylval = create_node(SU_COMMA, 0); yylval->line = yylineno; return COMMA; }
{ASSIGNOP}          { yylval = create_node(SU_ASSIGNOP, 0); yylval->line = yylineno; return ASSIGNOP; }
{RELOP}             { yylval = create_node(SU_RELOP, 0); yylval->line = yylineno; return RELOP; }
{PLUS}              { yylval = create_node(SU_PLUS, 0); yylval->line = yylineno; return PLUS; }
{MINUS}             { yylval = create_node(SU_MINUS, 0); yylval->line = yylineno; return MINUS; }
{STAR}              { yylval = create_node(SU_STAR, 0); yylval->line = yylineno; return STAR; }
{DIV}               { yylval = create_node(SU_DIV, 0); yylval->line = yylineno; return DIV; }
{AND}               { yylval = create_node(SU_AND, 0); yylval->line = yylineno; return AND; }
{OR}                { yylval = create_node(SU_OR, 0); yylval->line = yylineno; return OR; }
{DOT}               { yylval = create_node(SU_DOT, 0); yylval->line = yylineno; return DOT; }
{NOT}               { yylval = create_node(SU_NOT, 0); yylval->line = yylineno; return NOT; }
{LP}                { yylval = create_node(SU_LP, 0); yylval->line = yylineno; return LP; }
{RP}                { yylval = create_node(SU_RP, 0); yylval->line = yylineno; return RP; }
{LB}                { yylval = create_node(SU_LB, 0); yylval->line = yylineno; return LB; }
{RB}                { yylval = create_node(SU_RB, 0); yylval->line = yylineno; return RB; }
{LC}                { yylval = create_node(SU_LC, 0); yylval->line = yylineno; return LC; }
{RC}                { yylval = create_node(SU_RC, 0); yylval->line = yylineno; return RC; }
.                   { ok = 0; printf("Error type A at Line %d: Misterious character \"%s\".\n", yylineno, yytext); }
%%

char* str_save(const char* src){
    if(!src) return NULL;
    size_t len = strlen(src) + 1;
    char* str = (char*)malloc(len);
    memcpy(str, src, len);
    return str;
}
