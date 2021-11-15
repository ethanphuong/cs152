%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern int currPos;
extern int currLine;
extern FILE* yyin;

void yyerror(const char* s) {
	printf("Error at line %d, column %d: identifier \"%s\".", currPos, currLine, s);
}
%}

%union {
   int number;
   char* identifier;
}

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE RETURN SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE SEMICOLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN COLON

%type <number> NUMBER <identifier> IDENT

%start prog_start

%%

prog_start: functions {printf("prog_start -> functions\n");}
    | {printf("prog_start -> epsilon\n");} 

functions: function functions {printf("functions -> function functions\n");}
    | {printf("functions -> epsilon\n");}

%%

int main() {
  yyparse();
  return 0;
}

