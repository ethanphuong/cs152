all:
	flex mini_l.lex
	gcc lex.yy.c -lfl
