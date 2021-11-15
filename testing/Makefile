#makefile for linux
CC = g++
CFLAGS = -g -Wall -ansi -pedantic -std=c++11

parser: mini_l.l mini_l.y
	flex mini_l.l
	bison -v -d mini_l.y
	$(CC) $(CFLAGS) -o parser mini_l.tab.c lex.yy.c -lfl
	rm -f lex.yy.c

test: parser
		cat fibonacci.min | ./parser

clean:
	rm -f *.o parser mini_l.tab.* mini_l.output *~ lex.yy.c tok.h a.out
