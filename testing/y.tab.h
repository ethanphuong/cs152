/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     FUNCTION = 258,
     IDENT = 259,
     SEMICOLON = 260,
     BEGIN_PARAMS = 261,
     END_PARAMS = 262,
     BEGIN_LOCALS = 263,
     END_LOCALS = 264,
     BEGIN_BODY = 265,
     COLON = 266,
     INTEGER = 267,
     ARRAY = 268,
     L_SQUARE_BRACKET = 269,
     R_SQUARE_BRACKET = 270,
     NUMBER = 271,
     OF = 272,
     ASSIGN = 273,
     IF = 274,
     THEN = 275,
     ENDIF = 276,
     ELSE = 277,
     BEGINLOOP = 278,
     ENDLOOP = 279,
     WHILE = 280,
     READ = 281,
     WRITE = 282,
     CONTINUE = 283,
     RETURN = 284,
     OR = 285,
     AND = 286,
     L_PAREN = 287,
     R_PAREN = 288,
     TRUE = 289,
     FALSE = 290,
     LT = 291,
     GT = 292,
     NEQ = 293,
     LTE = 294,
     GTE = 295,
     ADD = 296,
     SUB = 297,
     DIV = 298,
     MULT = 299,
     MOD = 300,
     NEG = 301,
     COMMA = 302,
     EQ = 303,
     FOR = 304,
     DO = 305
   };
#endif
/* Tokens.  */
#define FUNCTION 258
#define IDENT 259
#define SEMICOLON 260
#define BEGIN_PARAMS 261
#define END_PARAMS 262
#define BEGIN_LOCALS 263
#define END_LOCALS 264
#define BEGIN_BODY 265
#define COLON 266
#define INTEGER 267
#define ARRAY 268
#define L_SQUARE_BRACKET 269
#define R_SQUARE_BRACKET 270
#define NUMBER 271
#define OF 272
#define ASSIGN 273
#define IF 274
#define THEN 275
#define ENDIF 276
#define ELSE 277
#define BEGINLOOP 278
#define ENDLOOP 279
#define WHILE 280
#define READ 281
#define WRITE 282
#define CONTINUE 283
#define RETURN 284
#define OR 285
#define AND 286
#define L_PAREN 287
#define R_PAREN 288
#define TRUE 289
#define FALSE 290
#define LT 291
#define GT 292
#define NEQ 293
#define LTE 294
#define GTE 295
#define ADD 296
#define SUB 297
#define DIV 298
#define MULT 299
#define MOD 300
#define NEG 301
#define COMMA 302
#define EQ 303
#define FOR 304
#define DO 305




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

