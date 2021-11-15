DIGIT [0-9] 
IDENT_VAR	    {a-zA-Z0-9_}({a-zA-Z0-9_}|{DIGIT}|[_])*(({a-zA-Z0-9_}|{DIGIT})+)*
IDENT_DIG	    {DIGIT}+
IDENT_ERR_START ({DIGIT}|[_])({a-zA-Z0-9_}|{DIGIT}|[_])*(({a-zA-Z0-9_}|{DIGIT})+)*
IDENT_ERR_END	{a-zA-Z0-9_}({a-zA-Z0-9_}|{DIGIT}|[_])*([_])+

%{
#include "y.tab.h"
#include "mini_l.h"
#include <string.h>

int currPos = 1;
int currLine = 1;

%}

%%
"function" {currPos += yyleng; return FUNCTION;}
"beginparams" {currPos += yyleng; return BEGIN_PARAMS;}
"endparams" {currPos += yyleng; return END_PARAMS;}
"beginlocals" {currPos += yyleng; return BEGIN_LOCALS;}
"endlocals" {currPos += yyleng; return END_LOCALS;}
"beginbody" {currPos += yyleng; return BEGIN_BODY;}
"endbody" {currPos += yyleng; return END_BODY;}
"integer" {currPos += yyleng; return INTEGER;}
"array" {currPos += yyleng; return ARRAY;}
"of" {currPos += yyleng; return OF;}
"if" {currPos += yyleng; return IF;}
"then" {currPos += yyleng; return THEN;}
"endif" {currPos += yyleng; return ENDIF;}
"else" {currPos += yyleng; return ELSE;}
"while" {currPos += yyleng; return WHILE;}
"do" {currPos += yyleng; return DO;}
"beginloop" {currPos += yyleng; return BEGINLOOP;}
"endloop" {currPos += yyleng; return ENDLOOP;}
"continue" {currPos += yyleng; return CONTINUE;}
"read" {currPos += yyleng; return READ;}
"write" {currPos += yyleng; return WRITE;}
"and" {currPos += yyleng; return AND;}
"or" {currPos += yyleng; return OR;}
"not" {currPos += yyleng; return NOT;}
"true" {currPos += yyleng; return TRUE;}
"false" {currPos += yyleng; return FALSE;}
"return" {currPos += yyleng; return RETURN;}

"-" {currPos += yyleng; return SUB;}
"+" {currPos += yyleng; return ADD;}
"*" {currPos += yyleng; return MULT;}
"/" {currPos += yyleng; return DIV;}
"%" {currPos += yyleng; return MOD;}
"==" {currPos += yyleng; return EQ;}
"<>" {currPos += yyleng; return NEQ;}
"<" {currPos += yyleng; return LT;}
">" {currPos += yyleng; return GT;}
"<=" {currPos += yyleng; return LTE;}
">=" {currPos += yyleng; return GTE;}
";" {currPos += yyleng; return SEMICOLON;}
"," {currPos += yyleng; return COMMA;}
"(" {currPos += yyleng; return L_PAREN;}
")" {currPos += yyleng; return R_PAREN;}
"[" {currPos += yyleng; return L_SQUARE_BRACKET;}
"]" {currPos += yyleng; return R_SQUARE_BRACKET;}
":=" {currPos += yyleng; return ASSIGN;}
":" {currPos += yyleng; return COLON;}

[ ]+ {currPos += yyleng;}
[\t]+ {currPos += yyleng;}
"\n"+ {currLine++; currPos = 1;}
(##).* {currLine++; currPos = 1;}

{DIGIT}+ {currPos += yyleng; return NUMBER;}
{IDENT_DIG}	        /*printf("NUMBER -> %s\n",yytext)*/;yylval.int_val = atoi(yytext); return(NUMBER); cursor_pos += yyleng; 
{IDENT_ERR_START}   printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n",line_cnt,cursor_pos,yytext);exit(0);
{IDENT_ERR_END}	    printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n",line_cnt,cursor_pos,yytext);exit(0);
{IDENT_VAR}	        /*printf("IDENT -> %s\n",yytext)*/;strcpy(yylval.str_val,yytext);return(IDENT);cursor_pos += yyleng;  
.		            printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n",line_cnt,cursor_pos,yytext);exit(0);

("_"[a-zA-Z0-9_]*)|({DIGIT}[a-zA-Z0-9_]*) {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", currPos, currLine, yytext); exit(0);}
([a-zA-Z0-9_]*"_") {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", currPos, currLine, yytext); exit(0);}

[a-zA-Z0-9_]*[a-zA-Z0-9]* {currPos += yyleng; return IDENT;}

%%
/*
int main(int argc, char **argv) {
    if ((argc > 1) && ((yyin = fopen(argv[1],"r")) == NULL))
    {
        printf("syntax: %s filename\n", argv[0]);
        return 1;
    }
    yyparse();
    return 0;
}*/
