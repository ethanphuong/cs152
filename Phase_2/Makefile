all: mini_l.lex
	bison -v -d --file-prefix=y mini_l.y
	flex mini_l.lex
	gcc -o parser y.tab.c lex.yy.c -lfl
clean:
	rm y.tab.c y.tab.h y.output lex.yy.c parser
