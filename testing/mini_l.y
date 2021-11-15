/* MINI-L Parser for CS152 Part 2*/
/*%code requires{
    #include <string>
    using namespace std;
    struct nonTerm {
        string code;
        string ret_name;
    }
}*/

%{
    #define YY_NO_UNPUT
    #include <iostream>
    #include <stdio.h>
    #include <string>
    #include <sstream>
    #include <cstring>
    #include <stdlib.h>
    #include <unordered_set>
    #include <vector>
    //#include "y.tab.h"
    using namespace std;
    int yyerror(string s);
    int yyerror(char *s);
    int yylex(void);
    extern FILE* yyin;
    unordered_set<string> predefFuncs;
%}

%union {
    int num;
    char* id;
    struct {
        char* code;
        char* ret_name;
        char* var_name;
        char* paramIDs;
    } nterm;
}

%start prog_start

%token FUNCTION
%token SEMICOLON COLON COMMA
%token<id> IDENT
%token<num> NUMBER
%token BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY
%token INTEGER ARRAY
%token L_SQUARE_BRACKET R_SQUARE_BRACKET
%token IF THEN ENDIF ELSE WHILE OF
%token BEGINLOOP ENDLOOP
%token READ WRITE CONTINUE RETURN
%token OR AND
%token GT LT NEQ LTE GTE
%token L_PAREN R_PAREN
%token TRUE FALSE
%token FOR DO EQ
%token END_BODY NOT
%left ADD SUB DIV MULT MOD NEG ASSIGN

//attach nonTerm type to all nonterminals like below
%type<nterm> prog_start
%type<nterm> functions
%type<nterm> function
%type<nterm> declaration
%type<nterm> declarations
%type<nterm> statement
%type<nterm> statements
%type<nterm> bool_exp
%type<nterm> relation_and_exp
%type<nterm> relation_exp
%type<nterm> nots
%type<nterm> comp
%type<nterm> expression
%type<nterm> multiplicative_expression
%type<nterm> term
%type<nterm> term_num
%type<nterm> vars
%type<nterm> var
%type<nterm> identifiers
%type<nterm> identifier
%type<nterm> number
%type<nterm> expressions

%%
  //Actual output done in prog_start
prog_start:         functions {
                        cout << $1.code;
                    };
functions:          function functions {
			        stringstream ss;
                        ss << $1.code << $2.code;
                        std::string temp = ss.str(); 
                        $$.code = strdup(temp.c_str());
                        $$.ret_name = "";
                    }
                    | /*epsilon*/ {
			            $$.code = "";
                        $$.ret_name = "";
                    };
function:           FUNCTION identifier SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY{
                        stringstream ss;
                        ss << "func ";
                        if(predefFuncs.find($2.ret_name) == predefFuncs.end()) {
                            predefFuncs.insert($2.ret_name);
                            ss << $2.ret_name << "\n";
                        }
                        else {
                            ss << "\nError: function identifier already in use\n";
                        }
                        ss << $5.code;
			int count = 0;
			string id;
			if($5.paramIDs != NULL) {
				string stringIDs = $5.paramIDs;
				stringstream ids(stringIDs);
				while(ids >> id) {
					ss << "= " << id << ", $" << count << "\n";
					++count;
				}
			}
			ss << "endfunc" << "\n";
                        string temp = ss.str();
                        $$.code = strdup(temp.c_str());
                        $$.ret_name = "";
                        };
declaration:        identifiers COLON INTEGER { //done
                        stringstream ss;
                        string id;
                        string stringIDs = $1.ret_name;
                        stringstream ids(stringIDs);
                        while(ids >> id) {
                            ss << ". " << id << "\n";   
                        }
                        string temp = ss.str();
                        $$.code = strdup(temp.c_str());
			$$.paramIDs = $1.ret_name;
                        $$.ret_name = "";
                    }
                    | identifiers COLON ARRAY L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER { //done
                        // stringstream ss;
                        // string hold;
                        // string temp = $1.code;
                        // stringstream ids(temp);
                        // while(ids >> hold) {
                        //     ss << ".[] " << hold << ", " << $5.ret_name << "\n";
                        // }
                        // $$.code = ss.str();
                        // $$.ret_name = "";
                    };
declarations:       declaration SEMICOLON declarations {
                        stringstream ss;
                        ss << $1.code << $3.code;
			string temp = ss.str();
                        $$.code = strdup(temp.c_str());
                        $$.ret_name = "";
                    }
                    | /*epsilon*/ {
                        $$.code = "";
                        $$.ret_name = "";
                    };
statement:          var ASSIGN expression {
                        // stringstream ss;
                        // ss << $1.code;
                        // ss << $3.code;
                        // ss << "= " << $1.ret_name << ", " << $3.ret_name << "\n";
                    }
                    | IF bool_exp THEN statements ENDIF {
                        // string label0 = make_label();
                        // string label1 = make_label();
                        // stringstream ss;
                        // ss << $2.code;
                        // ss << "?:= " << label0 << $2.ret_name << "\n";
                        // ss << ":= " << label1;
                        // ss << ": " << label0;
                        // ss << $4.code;
                        // ss << ": " << label1;
                        // $$.code = ss.str();
                        // $$.ret_name = "";
                    }
                    | IF bool_exp THEN statements ELSE statements ENDIF {
                        // string label0 = make_label();
                        // string label1 = make_label();
                        // string label2 = make_label();
                        // stringstream ss;
                        // ss << $2.code;
                        // ss << "?:= " << label0 << ", " << $2.ret_name << "\n";
                        // ss << ":= " << label1;
                        // ss << ": " << label0;
                        // ss << $4.code;
                        // ss << ":= " << label2;
                        // ss << ": " << label1;
                        // ss << $6.code;
                        // ss << ": " << label2;
                        // $$.code = ss.str();
                    }
                    | WHILE bool_exp BEGINLOOP statements ENDLOOP {}
                    | DO BEGINLOOP statements ENDLOOP WHILE bool_exp {}
                    | FOR var ASSIGN number SEMICOLON bool_exp SEMICOLON var ASSIGN expression BEGINLOOP statements ENDLOOP {}
                    | READ vars {}
                    | WRITE vars {}
                    | CONTINUE {}
                    | RETURN expression {};
statements:         statement SEMICOLON statements {}
                    | /*epsilon*/ {};
bool_exp:           relation_and_exp OR relation_and_exp {}
                    | relation_and_exp {};
relation_and_exp:   relation_exp AND relation_exp {}
                    | relation_exp {
                        // $$.code = $1.code;
                        // $$.ret_name = "";
                    };
relation_exp:       nots expression comp expression {
                        // stringstream ss;
                        // ss << $2.code;
                        // ss << $4.code;
                        // ss << $3.ret_name << ", " << $2.ret_name << ", " << $4.ret_name << "\n";
                        // $$.code = ss.str();
                        // $$.ret_name = "";
                    }
                    | nots TRUE {
                        // $$.code = "";
                        // $$.ret_name = "1";
                    }
                    | nots FALSE {
                        // $$.code = "";
                        // $$.ret_name = "0";
                    }
                    | nots L_PAREN bool_exp R_PAREN {

                   }
		    | expression comp expression{

                    }
                    | TRUE {

                    }
                    | FALSE {

                    }
                    | L_PAREN bool_exp R_PAREN{

                    };
nots:               NOT {
                        // string temp_var = make_temp();
                        // stringstream ss;
                        // ss << "! " << temp_var << ", ";
                        // $$.code = ss;
                        // $$.ret_name = "! ";
                    };
comp:               EQ {
                        // $$.ret_name = "== ";
                        // $$.code = "";
                    }
                    | NEQ {
                        // $$.ret_name = "!= ";
                        // $$.code = "";
                    }
                    | LT {
                        // $$.ret_name = "< ";
                        // $$.code = "";
                    }
                    | GT {
                        // $$.ret_name = "> ";
                        // $$.code = "";
                    }
                    | LTE {
                        // $$.ret_name = "<= ";
                        // $$.code = "";
                    }
                    | GTE {
                        // $$.ret_name = ">= ";
                        // $$.code = "";
                    };
expression:         multiplicative_expression {
                        // $$.code = $1.code;
                        // $$.ret_name = $1.ret_name;
                    }
                    | multiplicative_expression ADD expression {
                        // string temp_var = make_temp();
                        // stringstream ss;
                        // ss << $1.code << $3.code;
                        // ss << ". " << temp_var << "\n"; //declare destination
                        // ss << "+ " << temp_var << ", " << $1.ret_name << ", " << $3.ret_name << "\n";
                        // $$.code = ss.str();
                        // $$.ret_name = temp_var;
                    }
                    | multiplicative_expression SUB expression {
                        // string temp_var = make_temp();
                        // stringstream ss;
                        // ss << $1.code << $3.code;
                        // ss << ". " << temp_var << "\n";
                        // ss << "- " << temp_var << ", " << "$1.ret_name" << ", " << $3.ret_name << "\n";
                        // $$.code = ss.str();
                        // $$.ret_name = temp_var;
                    };
multiplicative_expression: term {
                        // $$.code = $1.code;
                        // $$.ret_name = $1.ret_name;
                    }
                    | term MULT term {
                        // string temp_var = make_temp();
                        // stringstream ss;
                        // ss << $1.code << $3.code;
                        // ss << ". " << tempvar << "\n";
                        // ss << "* " << tempvar << "," << $1.ret_name << "," << $3.ret_name << "\n";
                        // $$.code = ss.str();
                        // $$.ret_name = temp_var;
                    }
                    | term DIV term {
                        // string temp_var = make_temp();
                        // stringstream ss;
                        // ss << $1.code << $3.code;
                        // ss << ". " << tempvar << "\n";
                        // ss << "/ " << tempvar << "," << $1.ret_name << "," << $3.ret_name << "\n";
                        // $$.code = ss.str();
                        // $$.ret_name = temp_var;
                    }
                    | term MOD term {
                        // string temp_var = make_temp();
                        // stringstream ss;
                        // ss << $1.code << $3.code;
                        // ss << ". " << tempvar << "\n";
                        // ss << "% " << tempvar << "," << $1.ret_name << "," << $3.ret_name << "\n";
                        // $$.code = ss.str();
                        // $$.ret_name = temp_var;
                    };
term:               NEG term_num {}
                    | term_num {}
                    | identifier L_PAREN expressions R_PAREN { //possible check for undeclared
                        // string temp_var = make_temp();
                        // stringstream ss;
                        // ss << $3.code;
                        // ss << ". " << tempvar << "\n";

                    }
		    | identifier L_PAREN R_PAREN {
		    
		    };
term_num:           var {}
                    | number {
                        // stringstream ss;
                        // ss << $1.ret_name;
                        // $$.ret_name = ss;
                        // $$.code = "";
                    }
                    | L_PAREN expression R_PAREN {
                        // $$.code = $2.code;
                        // $$.ret_name = $2.ret_name;
                    };
vars:               var {}
                    | var COMMA vars {};
var:                identifier L_SQUARE_BRACKET expression R_SQUARE_BRACKET {
                        // stringstream ss;
                        // ss << $3.code;
                        // ss << $1.ret_name;
                    }
                    | identifier {
                        // $$.code = "";
                        // $$.ret_name = $1.ret_name;
                    };
identifiers:        identifier COMMA identifiers { //done
                        stringstream ss;
                        ss << $1.ret_name << " " << $3.code;
                        string temp = ss.str();
			$$.ret_name = strdup(temp.c_str());
			$$.code = "";
                    }
                    | identifier { //done
                        $$.code = "";
                        $$.ret_name = $1.ret_name;
                    };
identifier:         IDENT { //done
                        $$.code = "";
                        $$.ret_name = $1;
                    };
number:             NUMBER {
                        // $$.ret_name = to_string($1);
                        // $$.code = "";
                    };
expressions:        expression COMMA expressions {
                        // stringstream ss;
                        // ss << $1.code << "param " << $1.ret_name << "\n";
                        // ss << "$3.code";
                        // $$.code = ss.str();
                        // $$.ret_name = "";
                    }
                    | expression {
                        // stringstream ss;
                        // ss << $1.code << "param " << $1.ret_name << "\n";
                        // $$.code = ss.str();
                        // $$.ret_name = "";
                    };

%%

string make_temp() {
    static int num = 0;
    string temp = "__temp" + to_string(num++) + "__";
    return temp;
}

string make_label() {
    static int num = 0;
    string label = "__label" + to_string(num++) + "__";
    return label;
}

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
