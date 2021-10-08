DIGIT [0-9] 

%{
int number_count = 0; int operator_count = 0; int parentheses_count = 0; int equals_count = 0;
%}

%%
"+" {printf("PLUS\n"); number_count++;}
"-" {printf("MINUS\n"); operator_count++;}
"*" {printf("MULT\n"); operator_count++;}
"/" {printf("DIV\n");operator_count++;}
"(" {printf("L_PAREN\n"); parentheses_count++;}
")" {printf("R_PAREN\n"); parentheses_count++;}
"=" {printf("EQUAL\n"); equals_count++;}
{DIGIT}+ {printf("NUM %s\n", yytext); number_count++;}

. printf("Error\n");
%%

main() {
	printf("Expression:\n");
	yylex();
	printf("Numbers: %d\nOperators: %d\nParentheses: %d\nEquals: %d\n", number_count, operator_count, parentheses_count, equals_count);
}
