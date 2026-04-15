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
{TYPE}              { yylval = create_node(SU_TYPE); yylval->line = yylineno; yylval->val.t_int = (yytext[0] == 'i'); return TYPE; }
{STRUCT}            { yylval = create_node(SU_STRUCT); yylval->line = yylineno; return STRUCT; }
{RETURN}            { yylval = create_node(SU_RETURN); yylval->line = yylineno; return RETURN; }
{IF}                { yylval = create_node(SU_IF); yylval->line = yylineno; return IF; }
{ELSE}              { yylval = create_node(SU_ELSE); yylval->line = yylineno; return ELSE; }
{WHILE}             { yylval = create_node(SU_WHILE); yylval->line = yylineno; return WHILE; }
{INT}               { yylval = create_node(SU_INT); yylval->line = yylineno; yylval->val.t_int = strtol(yytext, NULL, 0); return INT; }
{FLOAT}             { yylval = create_node(SU_FLOAT); yylval->line = yylineno; yylval->val.t_float = atof(yytext); return FLOAT; }
{ID}                { yylval = create_node(SU_ID); yylval->line = yylineno; yylval->val.t_str = str_save(yytext); return ID; }
{SEMI}              { yylval = create_node(SU_SEMI); yylval->line = yylineno; return SEMI; }
{COMMA}             { yylval = create_node(SU_COMMA); yylval->line = yylineno; return COMMA; }
{ASSIGNOP}          { yylval = create_node(SU_ASSIGNOP); yylval->line = yylineno; return ASSIGNOP; }
{RELOP}             { yylval = create_node(SU_RELOP); yylval->line = yylineno; return RELOP; }
{PLUS}              { yylval = create_node(SU_PLUS); yylval->line = yylineno; return PLUS; }
{MINUS}             { yylval = create_node(SU_MINUS); yylval->line = yylineno; return MINUS; }
{STAR}              { yylval = create_node(SU_STAR); yylval->line = yylineno; return STAR; }
{DIV}               { yylval = create_node(SU_DIV); yylval->line = yylineno; return DIV; }
{AND}               { yylval = create_node(SU_AND); yylval->line = yylineno; return AND; }
{OR}                { yylval = create_node(SU_OR); yylval->line = yylineno; return OR; }
{DOT}               { yylval = create_node(SU_DOT); yylval->line = yylineno; return DOT; }
{NOT}               { yylval = create_node(SU_NOT); yylval->line = yylineno; return NOT; }
{LP}                { yylval = create_node(SU_LP); yylval->line = yylineno; return LP; }
{RP}                { yylval = create_node(SU_RP); yylval->line = yylineno; return RP; }
{LB}                { yylval = create_node(SU_LB); yylval->line = yylineno; return LB; }
{RB}                { yylval = create_node(SU_RB); yylval->line = yylineno; return RB; }
{LC}                { yylval = create_node(SU_LC); yylval->line = yylineno; return LC; }
{RC}                { yylval = create_node(SU_RC); yylval->line = yylineno; return RC; }
.                   { ok = 0; printf("Error type A at Line %d: Misterious character \"%s\".\n", yylineno, yytext); }
%%

char* str_save(const char* src){
    if(!src) return NULL;
    size_t len = strlen(src) + 1;
    char* str = (char*)malloc(len);
    memcpy(str, src, len);
    return str;
}
