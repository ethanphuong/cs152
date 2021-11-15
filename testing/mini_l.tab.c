/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 2 "mini_l.y" /* yacc.c:339  */

    #include <iostream>
    #include <string>
    using namespace std;
    int yyerror(string s);
    int yyerror(char *s);
    int yylex(void);
    extern FILE* yyin;

#line 76 "mini_l.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "mini_l.tab.h".  */
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
#line 33 "mini_l.y" /* yacc.c:355  */

    int num;
    char* id;

#line 174 "mini_l.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_MINI_L_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 191 "mini_l.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  7
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   147

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  53
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  23
/* YYNRULES -- Number of rules.  */
#define YYNRULES  61
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  136

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   307

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,    40,    40,    41,    42,    43,    44,    45,    46,    47,
      48,    49,    50,    51,    52,    53,    54,    55,    56,    57,
      58,    59,    60,    61,    62,    63,    64,    65,    66,    67,
      68,    69,    70,    71,    72,    73,    74,    75,    76,    77,
      78,    79,    80,    81,    82,    83,    84,    85,    86,    87,
      88,    89,    90,    91,    92,    93,    94,    95,    96,    97,
      98,    99
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "FUNCTION", "SEMICOLON", "COLON",
  "COMMA", "IDENT", "NUMBER", "BEGIN_PARAMS", "END_PARAMS", "BEGIN_LOCALS",
  "END_LOCALS", "BEGIN_BODY", "INTEGER", "ARRAY", "L_SQUARE_BRACKET",
  "R_SQUARE_BRACKET", "IF", "THEN", "ENDIF", "ELSE", "WHILE", "OF",
  "BEGINLOOP", "ENDLOOP", "READ", "WRITE", "CONTINUE", "RETURN", "OR",
  "AND", "GT", "LT", "NEQ", "LTE", "GTE", "L_PAREN", "R_PAREN", "TRUE",
  "FALSE", "FOR", "DO", "EQ", "END_BODY", "NOT", "ADD", "SUB", "DIV",
  "MULT", "MOD", "NEG", "ASSIGN", "$accept", "prog_start", "functions",
  "function", "declaration", "declarations", "statement", "statements",
  "bool_exp", "relation_and_exp", "relation_exp", "nots", "comp",
  "expression", "multiplicative_expression", "term", "term_num", "vars",
  "var", "identifiers", "identifier", "number", "expressions", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307
};
# endif

#define YYPACT_NINF -56

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-56)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      10,    13,    27,   -56,    10,   -56,    43,   -56,   -56,    40,
      13,    49,    21,    66,    67,    13,    12,    23,    13,   -56,
      13,   -56,    79,   -56,    85,    95,    91,   -56,    88,    57,
      84,    18,    18,    13,    13,   -56,    17,    13,    86,   104,
      65,    59,    96,    99,    18,   -56,   -56,   -56,    98,    89,
      83,    17,    94,   -56,   109,   -56,    17,    22,   -56,    14,
      32,   -56,   -56,   -11,   -56,    68,    57,    57,   -56,    17,
      17,   -56,    87,    57,    18,    18,     9,    57,    13,    92,
     -56,    17,    17,    17,    17,    17,    17,    95,    97,   -56,
     -56,   106,   -56,    71,   -56,   -56,   -56,   -56,   -56,   -56,
     -56,   -56,    17,   101,   -56,   -56,   -56,   -56,   -56,   -56,
     -56,   115,    93,   120,   105,   -56,   -56,    57,   -56,   -56,
      17,   -56,    18,    18,   113,   -56,   125,   -56,   -56,    13,
      82,    17,   111,    57,   112,   -56
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       4,     0,     0,     2,     4,    57,     0,     1,     3,     0,
       9,     0,     0,     0,    56,     9,     0,     0,     0,     8,
       9,     6,     0,    55,     0,     0,     0,    58,     0,    21,
       0,    31,    31,     0,     0,    18,     0,     0,     0,     0,
       0,     0,    54,     0,    31,    27,    28,    30,     0,    23,
      25,     0,     0,    16,    51,    17,     0,     0,    19,    38,
      41,    46,    48,    54,    49,     0,    21,    21,     5,     0,
       0,     7,     0,    21,    31,    31,     0,    21,     0,     0,
      45,     0,     0,     0,     0,     0,    61,     0,     0,    20,
      10,     0,    29,     0,    22,    24,    35,    34,    33,    36,
      37,    32,     0,     0,    52,    50,    39,    40,    43,    42,
      44,    60,     0,     0,     0,    53,    11,    21,    26,    13,
      61,    47,    31,    31,     0,    59,     0,    14,    12,     0,
       0,     0,     0,    21,     0,    15
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -56,   -56,   132,   -56,   -56,    54,   -56,   -55,   -29,    64,
      69,   -56,   -56,   -35,    19,     4,    90,   -30,   -27,   121,
      -1,   -17,    20
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     3,     4,    11,    12,    39,    40,    48,    49,
      50,    51,   102,   111,    59,    60,    61,    53,    62,    13,
      63,    64,   112
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
       6,    58,    41,    52,    55,    70,    54,    54,    28,    14,
      65,    88,    89,     1,    14,    72,    76,    14,    93,    14,
       5,    79,   103,    20,     5,    27,    86,     7,    42,     5,
      27,    16,    42,    42,    90,    91,    42,    21,    22,    41,
      41,    96,    97,    98,    99,   100,    41,     9,   104,    10,
      41,    54,   101,    15,    56,    44,    42,    45,    46,    56,
      81,    82,   124,    47,     5,    42,    42,   118,    57,    19,
     113,    17,    42,    18,    24,    31,    42,    42,   134,    32,
      83,    84,    85,    33,    34,    35,    36,   108,   109,   110,
      41,   116,   117,   126,   127,    25,   132,    26,    37,    38,
     106,   107,   130,    27,    29,    30,    41,    43,    67,    68,
      66,    69,    70,    71,    75,    78,    42,    73,    77,    74,
      87,   120,   114,   115,   122,    92,   119,   123,    42,   129,
     105,   121,    42,   128,   131,   133,     8,   135,    94,    23,
     125,     0,     0,     0,    95,     0,     0,    80
};

static const yytype_int16 yycheck[] =
{
       1,    36,    29,    32,    34,    16,    33,    34,    25,    10,
      37,    66,    67,     3,    15,    44,    51,    18,    73,    20,
       7,    56,    77,    11,     7,     8,    37,     0,    29,     7,
       8,    10,    33,    34,    69,    70,    37,    14,    15,    66,
      67,    32,    33,    34,    35,    36,    73,     4,    78,     9,
      77,    78,    43,     4,    37,    37,    57,    39,    40,    37,
      46,    47,   117,    45,     7,    66,    67,   102,    51,    15,
      87,     5,    73,     6,    20,    18,    77,    78,   133,    22,
      48,    49,    50,    26,    27,    28,    29,    83,    84,    85,
     117,    20,    21,   122,   123,    16,   131,    12,    41,    42,
      81,    82,   129,     8,    13,    17,   133,    23,     4,    44,
      24,    52,    16,    14,    31,     6,   117,    19,    24,    30,
      52,     6,    25,    17,     4,    38,    25,    22,   129,     4,
      38,    38,   133,    20,    52,    24,     4,    25,    74,    18,
     120,    -1,    -1,    -1,    75,    -1,    -1,    57
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    54,    55,    56,     7,    73,     0,    55,     4,
       9,    57,    58,    72,    73,     4,    10,     5,     6,    58,
      11,    14,    15,    72,    58,    16,    12,     8,    74,    13,
      17,    18,    22,    26,    27,    28,    29,    41,    42,    59,
      60,    71,    73,    23,    37,    39,    40,    45,    61,    62,
      63,    64,    61,    70,    71,    70,    37,    51,    66,    67,
      68,    69,    71,    73,    74,    71,    24,     4,    44,    52,
      16,    14,    61,    19,    30,    31,    66,    24,     6,    66,
      69,    46,    47,    48,    49,    50,    37,    52,    60,    60,
      66,    66,    38,    60,    62,    63,    32,    33,    34,    35,
      36,    43,    65,    60,    70,    38,    67,    67,    68,    68,
      68,    66,    75,    74,    25,    17,    20,    21,    66,    25,
       6,    38,     4,    22,    60,    75,    61,    61,    20,     4,
      71,    52,    66,    24,    60,    25
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    53,    54,    55,    55,    56,    57,    57,    58,    58,
      59,    59,    59,    59,    59,    59,    59,    59,    59,    59,
      60,    60,    61,    61,    62,    62,    63,    63,    63,    63,
      64,    64,    65,    65,    65,    65,    65,    65,    66,    66,
      66,    67,    67,    67,    67,    68,    68,    68,    69,    69,
      69,    70,    70,    71,    71,    72,    72,    73,    74,    75,
      75,    75
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     0,    12,     3,     8,     3,     0,
       3,     5,     7,     5,     6,    13,     2,     2,     1,     2,
       3,     0,     3,     1,     3,     1,     4,     1,     1,     3,
       1,     0,     1,     1,     1,     1,     1,     1,     1,     3,
       3,     1,     3,     3,     3,     2,     1,     4,     1,     1,
       3,     1,     3,     4,     1,     3,     1,     1,     1,     3,
       1,     0
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 40 "mini_l.y" /* yacc.c:1646  */
    {cout << "prog_start -> functions" << endl;}
#line 1365 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 41 "mini_l.y" /* yacc.c:1646  */
    {cout << "functions -> function functions" << endl;}
#line 1371 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 42 "mini_l.y" /* yacc.c:1646  */
    {cout << "functions -> epsilon" << endl;}
#line 1377 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 43 "mini_l.y" /* yacc.c:1646  */
    {cout << "function -> FUNCTION identifier SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY" << endl;}
#line 1383 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 44 "mini_l.y" /* yacc.c:1646  */
    {cout << "declaration -> identifiers COLON INTEGER" << endl;}
#line 1389 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 45 "mini_l.y" /* yacc.c:1646  */
    {cout << "declaration -> identifiers COLON ARRAY L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER" << endl;}
#line 1395 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 46 "mini_l.y" /* yacc.c:1646  */
    {cout << "declarations -> declaration SEMICOLON declarations" << endl;}
#line 1401 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 47 "mini_l.y" /* yacc.c:1646  */
    {cout << "declarations -> epsilon" << endl;}
#line 1407 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 48 "mini_l.y" /* yacc.c:1646  */
    {cout << "statement -> var ASSIGN expression" << endl;}
#line 1413 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 49 "mini_l.y" /* yacc.c:1646  */
    {cout << "statement -> IF bool_exp THEN statements ENDIF" << endl;}
#line 1419 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 50 "mini_l.y" /* yacc.c:1646  */
    {cout << "statement -> IF bool_exp THEN statements ELSE statements ENDIF" << endl;}
#line 1425 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 51 "mini_l.y" /* yacc.c:1646  */
    {cout << "statement -> WHILE bool_exp BEGINLOOP statements ENDLOOP" << endl;}
#line 1431 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 52 "mini_l.y" /* yacc.c:1646  */
    {cout << "statement -> DO BEGINLOOP statements ENDLOOP WHILE bool_exp" << endl;}
#line 1437 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 53 "mini_l.y" /* yacc.c:1646  */
    {cout << "statement -> FOR var ASSIGN number SEMICOLON bool_exp SEMICOLON var ASSIGN expression BEGINLOOP statements ENDLOOP" << endl;}
#line 1443 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 54 "mini_l.y" /* yacc.c:1646  */
    {cout << "statement -> READ vars" << endl;}
#line 1449 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 55 "mini_l.y" /* yacc.c:1646  */
    {cout << "statement -> WRITE vars" << endl;}
#line 1455 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 56 "mini_l.y" /* yacc.c:1646  */
    {cout << "statement -> CONTINUE" << endl;}
#line 1461 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 57 "mini_l.y" /* yacc.c:1646  */
    {cout << "statement -> RETURN expression" << endl;}
#line 1467 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 58 "mini_l.y" /* yacc.c:1646  */
    {cout << "statements -> statement SEMICOLON statements" << endl;}
#line 1473 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 59 "mini_l.y" /* yacc.c:1646  */
    {cout << "statements -> epsilon" << endl;}
#line 1479 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 60 "mini_l.y" /* yacc.c:1646  */
    {cout << "bool_exp -> relation_and_exp OR relation_and_exp" << endl;}
#line 1485 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 61 "mini_l.y" /* yacc.c:1646  */
    {cout << "bool_exp -> relation_and_exp" << endl;}
#line 1491 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 62 "mini_l.y" /* yacc.c:1646  */
    {cout << "relation_and_exp -> relation_exp AND relation_exp" << endl;}
#line 1497 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 63 "mini_l.y" /* yacc.c:1646  */
    {cout << "relation_and_exp -> relation_exp" << endl;}
#line 1503 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 64 "mini_l.y" /* yacc.c:1646  */
    {cout << "relation_exp -> nots expression comp expression" << endl;}
#line 1509 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 65 "mini_l.y" /* yacc.c:1646  */
    {cout << "relation_exp -> TRUE" << endl;}
#line 1515 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 66 "mini_l.y" /* yacc.c:1646  */
    {cout << "relation_exp -> FALSE" << endl;}
#line 1521 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 67 "mini_l.y" /* yacc.c:1646  */
    {cout << "relation_exp -> L_PAREN bool_exp R_PAREN" << endl;}
#line 1527 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 68 "mini_l.y" /* yacc.c:1646  */
    {cout << "nots -> NOT" << endl;}
#line 1533 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 69 "mini_l.y" /* yacc.c:1646  */
    {cout << "nots -> epsilon" << endl;}
#line 1539 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 70 "mini_l.y" /* yacc.c:1646  */
    {cout << "comp -> EQ" << endl;}
#line 1545 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 71 "mini_l.y" /* yacc.c:1646  */
    {cout << "comp -> NEQ" << endl;}
#line 1551 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 72 "mini_l.y" /* yacc.c:1646  */
    {cout << "comp -> LT" << endl;}
#line 1557 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 73 "mini_l.y" /* yacc.c:1646  */
    {cout << "comp -> GT" << endl;}
#line 1563 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 74 "mini_l.y" /* yacc.c:1646  */
    {cout << "comp -> LTE" << endl;}
#line 1569 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 75 "mini_l.y" /* yacc.c:1646  */
    {cout << "comp -> GTE" << endl;}
#line 1575 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 76 "mini_l.y" /* yacc.c:1646  */
    {cout << "expression -> multiplicative_expression" << endl;}
#line 1581 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 77 "mini_l.y" /* yacc.c:1646  */
    {cout << "expression -> multiplicative_expression ADD multiplicative_expression" << endl;}
#line 1587 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 78 "mini_l.y" /* yacc.c:1646  */
    {cout << "expression -> multiplicative_expression SUB multiplicative_expression" << endl;}
#line 1593 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 79 "mini_l.y" /* yacc.c:1646  */
    {cout << "multiplicative_expression -> term" << endl;}
#line 1599 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 80 "mini_l.y" /* yacc.c:1646  */
    {cout << "multiplicative_expression -> term MULT term" << endl;}
#line 1605 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 81 "mini_l.y" /* yacc.c:1646  */
    {cout << "multiplicative_expression -> term DIV term" << endl;}
#line 1611 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 82 "mini_l.y" /* yacc.c:1646  */
    {cout << "multiplicative_expression -> term MOD term" << endl;}
#line 1617 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 83 "mini_l.y" /* yacc.c:1646  */
    {cout << "term -> NEG term_num" << endl;}
#line 1623 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 84 "mini_l.y" /* yacc.c:1646  */
    {cout << "term -> term_num" << endl;}
#line 1629 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 85 "mini_l.y" /* yacc.c:1646  */
    {cout << "term -> identifier L_PAREN expressions R_PAREN" << endl;}
#line 1635 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 86 "mini_l.y" /* yacc.c:1646  */
    {cout << "term_num -> var" << endl;}
#line 1641 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 87 "mini_l.y" /* yacc.c:1646  */
    {cout << "term_num -> number" << endl;}
#line 1647 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 88 "mini_l.y" /* yacc.c:1646  */
    {cout << "term_num -> L_PAREN expression R_PAREN" << endl;}
#line 1653 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 89 "mini_l.y" /* yacc.c:1646  */
    {cout << "vars -> var" << endl;}
#line 1659 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 90 "mini_l.y" /* yacc.c:1646  */
    {cout << "vars -> var COMMA vars" << endl;}
#line 1665 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 91 "mini_l.y" /* yacc.c:1646  */
    {cout << "var -> identifier L_SQUARE_BRACKET expression R_SQUARE_BRACKET" << endl;}
#line 1671 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 92 "mini_l.y" /* yacc.c:1646  */
    {cout << "var -> identifier" << endl;}
#line 1677 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 93 "mini_l.y" /* yacc.c:1646  */
    {cout << "identifiers -> identifier COMMA identifiers" << endl;}
#line 1683 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 94 "mini_l.y" /* yacc.c:1646  */
    {cout << "identifiers -> identifier " << endl;}
#line 1689 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 95 "mini_l.y" /* yacc.c:1646  */
    {cout << "identifier -> IDENT " << (yyvsp[0].id) << endl;}
#line 1695 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 96 "mini_l.y" /* yacc.c:1646  */
    {cout << "number -> NUMBER " << (yyvsp[0].num) << endl;}
#line 1701 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 97 "mini_l.y" /* yacc.c:1646  */
    {cout << "expressions -> expression COMMA expressions" << endl;}
#line 1707 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 98 "mini_l.y" /* yacc.c:1646  */
    {cout << "expressions -> expression" << endl;}
#line 1713 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 99 "mini_l.y" /* yacc.c:1646  */
    {cout << "expressions -> epsilon" << endl;}
#line 1719 "mini_l.tab.c" /* yacc.c:1646  */
    break;


#line 1723 "mini_l.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 101 "mini_l.y" /* yacc.c:1906  */


int yyerror (string s) {
    extern int currLine, currPos;
    extern char *yytext;
    cout << s << ": parsing error at line: " << currLine << ", column: " << currPos << endl
            << "Unexpected symbol `" << yytext << "` encountered." << endl;
    exit(1);
}

int yyerror (char* s) {
    return yyerror(string(s));
}

/*int main(int argc, char ** argv)
{
   if(argc >= 2)
   {
      yyin = fopen(argv[1], "r");
      if(yyin == NULL)
      {
         yyin = stdin;
      }
   }
   else
   {
      yyin = stdin;
   }

   yyparse();
}*/
