%{
#include "mini_l.h"

stringstream *mil_code;
FILE *instream;

int yyerror(const char* s);
int yylex(void);
int temp1 = 0;
int temp2 = 0;
string print_code(string *res, string op, string *val1, string *val2);
string int_string(int s);
string * new_string();
string * new_label();
string go_to(string *s);
string declaration_label(string *s);
string declaration_string(string *s);
void code(secondStruct &first, secondStruct second, secondStruct third, string op);
void push(string name, Var var);
void checks(string name);
bool check(string name);
;

map<string,Var> var_map;
stack<Loop> loop_stack;

%}

%union
{
    int number;
    char buf[4096];

    struct 
    {
        stringstream *code;
    } firstStruct;

    struct secondStruct secondStruct;
}

%error-verbose

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE RETURN SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE SEMICOLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN COLON NUMBER IDENT

%type <number> NUMBER
%type <buf> IDENT

%type <firstStruct> prog_start
%type <secondStruct> declarations statements function functions functions_1 declaration declarations_1 declarations_2 statement assi_expr read_vars write_vars bool_expr  
bool_expr_continue rel_expr rel_expr_continute rel_exprs rel_exprs_continue comp expression expressions  mult_expr mult_exprs term terms termss termsss termssss var vars         enter_loop

%%

prog_start:    function prog_start {
                $$.code = $1.code;
                *($$.code) << $2.code->str();
                mil_code = $$.code;
              } 
            | {
                $$.code = new stringstream();
              };

function:   FUNCTION functions SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statement SEMICOLON functions_1 {         
                $$.code = new stringstream(); 
                string temp = *$2.place;

                *($$.code)  << "func " << temp << "\n" << $5.code->str() << $8.code->str();
                for(int i = 0; i < $5.vars->size(); ++i)
                {
                    if((*$5.vars)[i].type == INT_ARR)
                    {
                        yyerror("Error: cannot pass arrays to function.");
                    }
                    else if((*$5.vars)[i].type == INT)
                    {
                        *($$.code) << "= " << *((*$5.vars)[i].place) << ", " << "$"<< int_string(i) << "\n";
                    }else
                    {
                        yyerror("Error: invalid type");
                    }
                }
                 *($$.code) << $11.code->str() << $13.code->str();
            };
functions: IDENT {
            string temp = $1;
            Var func = Var();
            func.type = FUNC;
            if(!check(temp))
            {
                push(temp, func); 
            }
            $$.place = new string();
            *$$.place = temp;
        };

functions_1: statement SEMICOLON functions_1 {
                $$.code = $1.code;
                *($$.code) << $3.code->str();
              } 
            | END_BODY 
            {
                $$.code = new stringstream();
                *($$.code) << "endfunc\n";
              };
              
declarations:  declaration SEMICOLON declarations {
                $$.code = $1.code;
                $$.vars = $1.vars;
                for( int i = 0; i < $3.vars->size(); ++i){
                    $$.vars->push_back((*$3.vars)[i]);
                }
                *($$.code) << $3.code->str();
                } 
            | {
                $$.code = new stringstream();
                $$.vars = new vector<Var>();
              }
            ;

statements:  statement SEMICOLON statements {
                $$.code = $1.code;
                *($$.code) << $3.code->str();
              } 
            | {
                $$.code = new stringstream();
              }
            ;

declaration:    IDENT declarations_1 {
                    $$.code = $2.code;
                    $$.type = $2.type;
                    $$.length = $2.length;

                    $$.vars = $2.vars;
                    Var var = Var();
                    var.type = $2.type;
                    var.length = $2.length;
                    var.place = new string();
                    *var.place = $1;
                    $$.vars->push_back(var);
                    
                    if($2.type == INT_ARR)
                    {
                        if($2.length <= 0)
                        {
                            yyerror("Error: invalid array size 0 or less");
                        }
                        *($$.code) << ".[] " << $1 << ", " << $2.length << "\n";
                        string s = $1;
                        if(!check(s)){
                            push(s,var);
                        }
                        else{
                            string temp = "Error: Symbol \"" + s + "\" is multiply-defined";
                            yyerror(temp.c_str());
                        }
                    }

                    else if($2.type == INT)
                    {
                        *($$.code) << ". " << $1 << "\n";
                        string s = $1;
                        if(!check(s))
                        {
                            push(s,var);
                        }
                        else
                        {
                            string temp = "Error: Symbol \"" + s + "\" is multiply-defined";
                            yyerror(temp.c_str());
                        }
                    }
                    else
                    {
                            yyerror("Error: invalid type");
                    }
                };

declarations_1:  COMMA IDENT declarations_1 {
                    $$.code = $3.code;
                    $$.type = $3.type;
                    $$.length = $3.length;
                    $$.vars = $3.vars;
                    Var var = Var();
                    var.type = $3.type;
                    var.length = $3.length;
                    var.place = new string();
                    *var.place = $2;
                    $$.vars->push_back(var);
                    if($3.type == INT_ARR)
                    {
                        *($$.code) << ".[] " << $2 << ", " << $3.length << "\n";
                        string s = $2;
                        if(!check(s))
                        {
                            push(s,var);
                        }
                        else
                        {
                            string temp = "Error: Symbol \"" + s + "\" is multiply-defined";
                            yyerror(temp.c_str());
                        }
                    }
                    else if($3.type == INT)
                    {
                        *($$.code) << ". " << $2 << "\n";
                        string s = $2;
                        if(!check(s))
                        {
                            push(s,var);
                        }
                        else{
                            string temp = "Error: Symbol \"" + s + "\" is multiply-defined";
                            yyerror(temp.c_str());
                        }
                    }
                }
                | COLON declarations_2 INTEGER 
                {
                    $$.code = $2.code;
                    $$.type = $2.type;
                    $$.length = $2.length;
                    $$.vars = $2.vars;
                };

declarations_2:  ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF {
                    $$.code = new stringstream();
                    $$.vars = new vector<Var>();
                    $$.type = INT_ARR;
                    $$.length = $3;
                }
                | {
                    $$.code = new stringstream();
                    $$.vars = new vector<Var>();
                    $$.type = INT;
                    $$.length = 0;
                  }
                ;

statement:          var ASSIGN expression {
                    $$.code = $1.code;
                    *($$.code) << $3.code->str();
                    if($1.type == INT && $3.type == INT)
                    {
                       *($$.code) << "= " << *$1.place << ", " << *$3.place << "\n";
                    }
                    else if($1.type == INT && $3.type == INT_ARR)
                    {
                        *($$.code) << print_code($1.place, "=[]", $3.place, $3.index);
                    }
                    else if($1.type == INT_ARR && $3.type == INT && $1.value != NULL)
                    {
                        *($$.code) << print_code($1.value, "[]=", $1.index, $3.place);
                    }
                    else if($1.type == INT_ARR && $3.type == INT_ARR)
                    {
                        string *temp = new_string();
                        *($$.code) << declaration_string(temp) << print_code(temp, "=[]", $3.place, $3.index);
                        *($$.code) << print_code($1.value, "[]=", $1.index, temp);
                    }
                    else
                    {
                        yyerror("Error: expression is null.");
                    }
                }
                | IF bool_expr THEN statements assi_expr ENDIF
                {
                    $$.code = new stringstream();
                    $$.begin = new_label();
                    $$.end = new_label();
                    *($$.code) << $2.code->str() << "?:= " << *$$.begin << ", " <<  *$2.place << "\n";
                    if($5.begin != NULL)
                    {                       
                        *($$.code) << go_to($5.begin); 
                        *($$.code) << declaration_label($$.begin)  << $4.code->str() << go_to($$.end);
                        *($$.code) << declaration_label($5.begin) << $5.code->str();
                    }
                    else
                    {
                        *($$.code) << go_to($$.end)<< declaration_label($$.begin)  << $4.code->str();
                    }
                    *($$.code) << declaration_label($$.end);
                }
                | WHILE bool_expr enter_loop BEGINLOOP statements ENDLOOP
                {
                    $$.code = new stringstream();
                    $$.begin = $3.begin;
                    $$.parent = $3.parent;
                    $$.end = $3.end;
                    *($$.code) << declaration_label($$.parent) << $2.code->str() << "?:= " << *$$.begin << ", " << *$2.place << "\n" 
                    << go_to($$.end) << declaration_label($$.begin) << $5.code->str() << go_to($$.parent) << declaration_label($$.end);
                    loop_stack.pop();

                }
                | DO enter_loop BEGINLOOP statements ENDLOOP WHILE bool_expr
                {
                    $$.code = new stringstream();
                    $$.begin = $2.begin;
                    $$.parent = $2.parent;
                    $$.end = $2.end;
                    *($$.code) << declaration_label($$.begin) << $4.code->str() << declaration_label($$.parent) << $7.code->str() << "?:= " << *$$.begin << ", " << *$7.place << "\n" << declaration_label($$.end);
                    loop_stack.pop();
                }
                | READ var read_vars
                {
                    $$.code = $2.code;
                    if($2.type == INT)
                    {
                       *($$.code) << ".< " << *$2.place << "\n"; 
                    }
                    else
                    {
                       *($$.code) << ".[]< " << *$2.place << ", " << $2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                }
                | WRITE var write_vars 
                {
                    $$.code = $2.code;
                    if($2.type == INT)
                    {
                       *($$.code) << ".> " << *$2.place << "\n"; 
                    }
                    else
                    {
                       *($$.code) << ".[]> " << *$2.value << ", " << *$2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                  }
                | CONTINUE
                {
                    $$.code = new stringstream();
                    if(loop_stack.size() <= 0)
                    {
                        yyerror("Error: continue statement not within a loop");
                    }
                    else
                    {
                        Loop loop = loop_stack.top();
                        *($$.code) << ":= " << *loop.parent << "\n";
                    }
                }
                | RETURN expression
                {
                    $$.code = $2.code;
                    $$.place = $2.place;
                    *($$.code) << "ret " << *$$.place << "\n";
                }
                
assi_expr:      {
                    $$.code = new stringstream();
                    $$.begin = NULL;
                }
                | ELSE statements
                {
                    $$.code = $2.code;
                    $$.begin = new_label();
                }
                ;

enter_loop:         {
                    $$.code = new stringstream();
                    $$.begin = new_label();
                    $$.parent = new_label();
                    $$.end = new_label();
                    Loop loop = Loop();
                    loop.parent = $$.parent;
                    loop.begin = $$.begin;
                    loop.end = $$.end;
                    loop_stack.push(loop);
                };

read_vars:   COMMA var read_vars {
                    $$.code = $2.code;
                    if($2.type == INT)
                    {
                       *($$.code) << ".< " << *$2.place << "\n"; 
                    }
                    else
                    {
                       *($$.code) << ".[]< " << *$2.place << ", " << $2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                }
                | {
                    $$.code = new stringstream();
                  };

write_vars:   COMMA var write_vars {
                    $$.code = $2.code;
                    if($2.type == INT)
                    {
                       *($$.code) << ".> " << *$2.place << "\n"; 
                    }
                    else
                    {
                       *($$.code) << ".[]> " << *$2.value << ", " << *$2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                  }
                |{
                    $$.code = new stringstream();
                 };

bool_expr:       rel_expr bool_expr_continue {
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    if($2.op != NULL && $2.place != NULL)
                    {                        
                        $$.place = new_string();
                       *($$.code) << declaration_string($$.place) << print_code($$.place, *$2.op, $1.place, $2.place);
                    }
                    else
                    {
                        $$.place = $1.place;
                        $$.op = $1.op;
                    }
                };

bool_expr_continue:      OR rel_expr bool_expr_continue {
                    code ($$,$2,$3,"||");
                }
                |{
                    $$.code = new stringstream();
                    $$.op = NULL;
                 };

rel_expr:    rel_exprs rel_expr_continute {
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    if($2.op != NULL && $2.place != NULL)
                    {                        
                        $$.place = new_string();
                       *($$.code) << declaration_string($$.place) << print_code($$.place, *$2.op, $1.place, $2.place);
                    }
                    else
                    {
                        $$.place = $1.place;
                        $$.op = $1.op;
                    }
                };

rel_expr_continute:   AND rel_exprs rel_expr_continute {
                    code($$,$2,$3,"&&");

                }
                |
                {
                    $$.code = new stringstream();
                    $$.op = NULL;
                 };

rel_exprs:   rel_exprs_continue {
                    $$.code = $1.code;
                    $$.place = $1.place; 
                }
                | NOT rel_exprs_continue
                {
                    $$.code = $2.code;
                    $$.place = new_string();
                    *($$.code) << declaration_string($$.place) << print_code($$.place, "!", $2.place, NULL);
                };

rel_exprs_continue: expression comp expression {
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    *($$.code) << $3.code->str();
                    $$.place = new_string();
                    *($$.code)<< declaration_string($$.place) << print_code($$.place, *$2.op, $1.place, $3.place);
                }
                | TRUE
                {                    
                    $$.code = new stringstream();
                    $$.place = new string();
                    *$$.place = "1";
                }
                | FALSE
                {
                    $$.code = new stringstream();
                    $$.place = new string();
                    *$$.place = "0";
                }
                | L_PAREN bool_expr R_PAREN
                {
                    $$.code = $2.code;
                    $$.place = $2.place;
                };

comp:           EQ{
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "==";
                }
                | NEQ
                {
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "!=";
                }
                | LT
                {
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "<";
                }
                | GT
                {
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = ">";
                }
                | LTE
                {
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "<=";
                }
                | GTE
                {
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = ">=";
                };

expression:     mult_expr expressions {
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    if($2.op != NULL && $2.place != NULL)
                    {                        
                        $$.place = new_string();
                       *($$.code)<< declaration_string($$.place) << print_code($$.place, *$2.op, $1.place, $2.place);
                    }
                    else
                    {
                        $$.place = $1.place;
                        $$.op = $1.op;
                    }
                    $$.type = INT;
                    };

expressions:   ADD mult_expr expressions {
                    code($$,$2,$3,"+");
                  }
                | SUB mult_expr expressions
                {
                    code($$,$2,$3,"-");
                }
                | {
                    $$.code = new stringstream();
                    $$.op = NULL;
                };

mult_expr:      term mult_exprs {
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    if($2.op != NULL && $2.place != NULL)
                    {                        
                        $$.place = new_string();
                       *($$.code)<< declaration_string($$.place)<< print_code($$.place, *$2.op, $1.place, $2.place);
                    }
                    else
                    {
                        $$.place = $1.place;
                        $$.op = $1.op;
                    }
                  };

mult_exprs:    MULT term mult_exprs {
                    code($$,$2,$3,"*");

                }
                | DIV term mult_exprs
                {
                    code($$,$2,$3,"/");
                }
                | MOD term mult_exprs
                {          
                    code($$,$2,$3,"%");
                }
                |
                {
                    $$.code = new stringstream();
                    $$.op = NULL;
                };

term:           SUB terms {
                    $$.code = $2.code;
                    $$.place = new_string();
                    string temp = "-1";
                    *($$.code)<< declaration_string($$.place) << print_code($$.place, "*",$2.place, &temp );
                }
                | terms
                {
                    $$.code = $1.code;
                    $$.place = $1.place;
                }
                | termss
                {
                    $$.code = $1.code;
                    $$.place = $1.place;
                };

terms:         var {
                    $$.code = $1.code;
                    $$.place= $1.place;
                    $$.index = $1.index;
                }
                | NUMBER
                {
                    $$.code = new stringstream();
                    $$.place = new string();
                    *$$.place = int_string($1);
                }
                | L_PAREN expression R_PAREN
                {
                    $$.code = $2.code;
                    $$.place = $2.place;
                }

termss:         IDENT L_PAREN termsss R_PAREN {
                    $$.code = $3.code;
                    $$.place = new_string();
                    *($$.code) << declaration_string($$.place)<< "call " << $1 << ", " << *$$.place << "\n";
                    string temp = $1;
                    checks(temp);
                };

termsss:        expression termssss {
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    *($$.code) << "param " << *$1.place << "\n";
                } 
                | 
                {
                    $$.code = new stringstream(); 
                };

termssss:        COMMA termsss {
                    $$.code = $2.code;
                } 
                | 
                {
                    $$.code = new stringstream();
                 };

var:            IDENT vars {
                    $$.code = $2.code;
                    $$.type = $2.type;
                    string temp = $1;
                    checks(temp);
                    if(check(temp) && var_map[temp].type != $2.type){
                        if($2.type == INT_ARR)
                        {
                            string output ="Error: used variable \"" + temp + "\" is not an array.";
                            yyerror(output.c_str());
                        }
                        else if($2.type == INT)
                        {
                            string output ="Error: used array variable \"" + temp + "\" is missing a specified index.";
                            yyerror(output.c_str());
                        }
                    }

                    if($2.index == NULL)
                    {
                        $$.place = new string();
                        *$$.place = $1;
                    }
                    else
                    {
                        $$.index = $2.index;
                        $$.place = new_string();
                        string* temp = new string();
                        *temp = $1;
                        *($$.code) << declaration_string($$.place) << print_code($$.place, "=[]", temp,$2.index);
                        $$.value = new string();
                        *$$.value = $1;
                    }
                };

vars:          L_SQUARE_BRACKET expression R_SQUARE_BRACKET {
                    $$.code = $2.code;
                    $$.place = NULL;
                    $$.index = $2.place;
                    $$.type = INT_ARR;
                }
                |
                {
                    $$.code = new stringstream();
                    $$.index = NULL;
                    $$.place = NULL;
                    $$.type = INT;
                };  
%%

string print_code(string *res, string op, string *val1, string *val2) {
    if(op == "!")
    {
        return op + " " + *res + ", " + *val1 + "\n";
    }
    else
    {
        return op + " " + *res + ", " + *val1 + ", "+ *val2 +"\n";
    }
}

string char_string(char* s) {
    ostringstream c;
    c << s;
    return c.str();
}

string int_string(int s) {
    ostringstream c;
    c << s;
    return c.str();
}
string go_to(string *s) {
    return ":= "+ *s + "\n"; 
}
string declaration_label(string *s) {
    return ": " +*s + "\n"; 
}
string declaration_string(string *s) {
    return ". " +*s + "\n"; 
}
string * new_string() {
    string * t = new string();
    ostringstream conv;
    conv << temp1;
    *t = "__temp__"+ conv.str();
    temp1++;
    return t;
}
string * new_label() {
    string * t = new string();
    ostringstream conv;
    conv << temp2;
    *t = "__label__"+ conv.str();
    temp2++;
    return t;
}
                   
void code(secondStruct &first, secondStruct second, secondStruct third, string op) {
    first.code = second.code;
    *(first.code) << third.code->str();
    if(third.op == NULL)
    {
        first.place = second.place;
        first.op = new string();
        *first.op = op;
    }
    else
    {
        first.place = new_string();
        first.op = new string();
        *first.op = op;

        *(first.code) << declaration_string(first.place)<< print_code(first.place , *third.op, second.place, third.place);
    } 
}

void push(string name, Var v) {
    if(var_map.find(name) == var_map.end()){
        var_map[name] = v;
    }
    else
    {
        string temp = "Error: " + name + " already exists";
        yyerror(temp.c_str());
    }
}
bool check(string name) {
    if(var_map.find(name) == var_map.end()){
        return false;
    }
    return true;
}
void checks(string name) {
    if(!check(name)){
        string temp = "Error: \"" + name + "\" does not exist";
        yyerror(temp.c_str());
    }
}

int yyerror(const char *s) {
    extern int currLine;
    extern int currPos;
    printf(">>> Line %d, position %d: %s\n",currLine,currPos,s);
    return -1;
}


int main(int argc, char **argv) {

    if (argc > 1) {
        instream = fopen(argv[1], "r");
        if (instream == NULL) {
            printf("Syntax: %s filename\n", argv[0]);
        }
    }
    
    yyparse();
    ofstream file;
    file.open("output.mil");
    file << mil_code->str();
    file.close();
    
    return 0;
}
