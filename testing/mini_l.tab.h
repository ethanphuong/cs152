/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_MINI_L_TAB_H_INCLUDED
# define YY_YY_MINI_L_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    FUNCTION = 258,
    SEMICOLON = 259,
    COLON = 260,
    COMMA = 261,
    IDENT = 262,
    NUMBER = 263,
    BEGIN_PARAMS = 264,
    END_PARAMS = 265,
    BEGIN_LOCALS = 266,
    END_LOCALS = 267,
    BEGIN_BODY = 268,
    INTEGER = 269,
    ARRAY = 270,
    L_SQUARE_BRACKET = 271,
    R_SQUARE_BRACKET = 272,
    IF = 273,
    THEN = 274,
    ENDIF = 275,
    ELSE = 276,
    WHILE = 277,
    OF = 278,
    BEGINLOOP = 279,
    ENDLOOP = 280,
    READ = 281,
    WRITE = 282,
    CONTINUE = 283,
    RETURN = 284,
    OR = 285,
    AND = 286,
    GT = 287,
    LT = 288,
    NEQ = 289,
    LTE = 290,
    GTE = 291,
    L_PAREN = 292,
    R_PAREN = 293,
    TRUE = 294,
    FALSE = 295,
    FOR = 296,
    DO = 297,
    EQ = 298,
    END_BODY = 299,
    NOT = 300,
    ADD = 301,
    SUB = 302,
    DIV = 303,
    MULT = 304,
    MOD = 305,
    NEG = 306,
    ASSIGN = 307
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 33 "mini_l.y" /* yacc.c:1909  */

    int num;
    char* id;

#line 112 "mini_l.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_MINI_L_TAB_H_INCLUDED  */
