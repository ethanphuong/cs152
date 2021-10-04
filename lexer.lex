digit	[0-9]
alpha	[a-fA-F]
hextail	({digit}|{alpha}){1,8}
hex	0[xX]{hextail}

%%
{hex}	printf("This is a hexadecimal number [%s].\n", yytext);
.	printf("");
%%

main()
{
	printf("Give me your input:\n");
	yylex();
}
