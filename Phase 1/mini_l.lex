digiit	[0-9]

%%
function	{printf("FUNCTION", yytext);}
%%

main()
{
	printf("Give me your input:");
	yylex();
}
