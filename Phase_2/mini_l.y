%{
#include <stdio.h>

extern int currPos;
extern int currLine;

extern FILE* yyin;

void yyerror(const char* s) {
    printf("Error at line %d, column %d: identifier \"%s\".", currPos, currLine, s);
}
%}

%define parse.error verbose
%define parse.lac full

%union {
   int number;
   char* identifier;
}

%start prog_start

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE RETURN SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE SEMICOLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN COLON

%token <number> NUMBER 
%token <identifier> IDENT

%%

prog_start:	functions {printf("prog_start -> functions\n");}
;

functions:	function functions {printf("functions -> function functions\n");}
		| {printf("functions -> EPSILON\n");}
;

function:	FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY {printf("function -> FUNCTION IDENT SEMICOLON BEGIN_PARAMS delcarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statement END_BODY\n");}
;

declarations:	declaration SEMICOLON declarations {printf("declarations -> declaration SEMICOLON declarations\n");}
		| {printf("declaratiions -> EPSILON\n");}
;

declaration:	identifiers COLON INTEGER {printf("declaration -> identifiers COLON INTEGER\n");}
		| identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {printf("declaration -> identifiers ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
;

identifiers:	IDENT {printf("identifiers -> IDENT\n");}
		| IDENT COMMA identifiers {printf("identifiers -> IDENT COMMA identifiers\n");}
;

statement:	var ASSIGN expression {printf("statement -> var ASSIGN expression\n");}
		| IF bool_expr THEN statements ENDIF {printf("statement -> IF bool_expr THEN statements ENDIF\n");}
		| IF bool_expr THEN statements ELSE statements ENDIF {printf("statement -> IF bool_expr THEN statements ELSE statements ENDIF\n");}
		| WHILE bool_expr BEGINLOOP statements ENDLOOP {printf("statement -> WHILE bool_expr BEGINLOOP statements ENDLOOP\n");}
		| DO BEGINLOOP statements ENDLOOP WHILE bool_expr {printf("Statement -> DO BEGINLOOP statements ENDLOOP WHILE bool_expr\n");}
		| READ vars {printf("statement -> READ vars\n");}
		| WRITE vars {printf("statement -> WRITE vars\n");}
		| CONTINUE {printf("statement -> CONTINUE\n");}
		| RETURN expression {printf("statement -> RETURN expression\n");}
;

statements:	statement SEMICOLON statements {printf("Statements -> statement SEMICOLON statements\n");}
		| statement SEMICOLON {printf("statements -> statement SEMICOLON\n");}
;

vars:		var COMMA vars {printf("vars -> vr COMMA vars\n");}
		| var {printf("vars -> var\n");}
;

bool_expr:	rel_exprs {printf("bool_expr -> rel_and_expr\n");}
		| bool_expr OR rel_exprs {printf("bool_expr -> rel_expr OR rel_exprs\n");}
;

rel_exprs:	rel_expr {printf("rel_and_expr -> rel_expr\n");}
		| rel_exprs AND rel_expr {printf("rel_and_expr -> rel_exprs AND rel_expr\n");}
;

rel_expr:	NOT expression comp expression {printf("rel_expr -> NOT expression comp expression\n");}
		| expression comp expression {printf("rel_exprs -> expression comp expression\n");}
		| TRUE {printf("rel_exprs -> TRUE\n");}
		| FALSE {printf("rel_exprs -> FALSE\n");}
		| L_PAREN bool_expr R_PAREN {printf("rel_exprs -> L_PAREN bool_expr R_PAREN\n");}
;

comp:		EQ {printf("comp -> EQ\n");}
		| NEQ {printf("comp -> NEQ\n");}
		| LT {printf("comp -> LT\n");}
		| GT {printf("comp -> GT\n");}
		| LTE {printf("comp -> LTE\n");}
		| GTE {printf("comp -> GTE\n");}
;

expression:	mult_expr mult_expr_op {printf("expression -> mult_expr mult_expr_op\n");}
;

mult_expr_op:	ADD expression {printf("mult_expr_op -> ADD expression\n");}
		| SUB expression {printf("mult_expr_op -> SUB expression\n");}
		| {printf("mult_expr_op -> EPSILON\n");}
;

mult_expr:	term MULT mult_expr {printf("mult_expr -> term MULT mult_expr\n");}
		| term DIV mult_expr {printf("mult_expr -> term DIV mult_expr\n");}
		| term MOD mult_expr {printf("mult_expr -> term MOD mult_expr\n");}
		| term {printf("mult_expr -> term\n");}
;

term:		SUB var {printf("term -> SUB var\n");}
		| var {printf("term -> var\n");}
		| SUB NUMBER {printf("term -> SUB NUMBER\n");}
		| NUMBER {printf("term -> NUMBER\n");}
		| L_PAREN expression R_PAREN {printf("term -> L_PAREN expression R_PAREN\n");}
		| IDENT L_PAREN expression expressions R_PAREN {printf("term -> IDENT L_PAREN expression expressions R_PAREN\n");}
;

expressions:	COMMA expression expressions {printf("expressions -> COMMA expression expressions\n");}
		| {printf("expressions -> EPSILON\n");}
;

var:		IDENT {printf("var -> IDENT\n");}
		| IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET {printf("var --> IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}
;


%%

int main(int argc, char **argv) {
  if ((argc > 1) && ((yyin = fopen(argv[1], "r")) == NULL)) {
    printf("syntax: %s filename \n", argv[0]);
    return 1;
  }
  yyparse();
  return 0;
}
