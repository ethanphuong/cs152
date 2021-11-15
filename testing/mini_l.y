/* Mini Calculator */
/* calc.y */

%{
#include "mini_l.h"

int yyerror(const char* s);
int yylex(void);
stringstream *all_code;
FILE * myin;
void print_test(string output);
void print_test(stringstream o);
string gen_code(string *res, string op, string *val1, string *val2);
string to_string(char* s);
string to_string(int s);
int tempi = 0;
int templ = 0;
string * new_temp();
string * new_label();
string go_to(string *s);
string dec_label(string *s);
string dec_temp(string *s);
void expression_code( Terminal &DD,  Terminal D2, Terminal D3,string op);
bool success = true;
bool no_main = false;
void push_map(string name, Var v);
bool check_map(string name);
void check_map_dec(string name);

map<string,Var> var_map;
stack<Loop> loop_stack;

%}

%union{
    int       int_val;
    char str_val[256];

    struct {
        stringstream *code;
    }NonTerminal;

    struct Terminal Terminal;
}

%error-verbose

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
%token INTEGER ARRAY OF 
%token IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE 
%token READ WRITE RETURN
%token AND OR NOT TRUE FALSE 
%token SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE 
%token SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN
%token NUMBER IDENT

%type <int_val> NUMBER
%type <str_val> IDENT

%%

prog_start:    function prog_start {
                $$.code = $1.code;
                *($$.code) << $2.code->str();
                if(!no_main){
                    yyerror("ERROR: main function not defined.");
                }

                all_code = $$.code;
              } 
            | {
                $$.code = new stringstream();
              }
            ;

function:   FUNCTION functions SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statement SEMICOLON functions_1 {         
                $$.code = new stringstream(); 
                string tmp = *$2.place;
                if( tmp.compare("main") == 0){
                    no_main = true;
                }
                *($$.code)  << "func " << tmp << "\n" << $5.code->str() << $8.code->str();
                for(int i = 0; i < $5.vars->size(); ++i){
                    if((*$5.vars)[i].type == INT_ARR){
                        yyerror("Error: cannot pass arrays to function.");
                    }
                    else if((*$5.vars)[i].type == INT){
                        *($$.code) << "= " << *((*$5.vars)[i].place) << ", " << "$"<< to_string(i) << "\n";
                    }else{
                        yyerror("Error: invalid type");
                    }
                }
                 *($$.code) << $11.code->str() << $13.code->str();
            }
            ;
functions: IDENT {
            string tmp = $1;
            Var myf = Var();
            myf.type = FUNC;
            if(!check_map(tmp)){
                push_map(tmp,myf); 
            }
            $$.place = new string();
            *$$.place = tmp;
        };

functions_1: statement SEMICOLON functions_1 {
                $$.code = $1.code;
                *($$.code) << $3.code->str();
              } 
            | END_BODY {
                $$.code = new stringstream();
                *($$.code) << "endfunc\n";
              }
            ;

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
                    Var v = Var();
                    v.type = $2.type;
                    v.length = $2.length;
                    v.place = new string();
                    *v.place = $1;
                    $$.vars->push_back(v);
                    if($2.type == INT_ARR){
                        if($2.length <= 0){
                            yyerror("ERROR: invalid array size <= 0");
                        }
                        *($$.code) << ".[] " << $1 << ", " << $2.length << "\n";
                        string s = $1;
                        if(!check_map(s)){
                            push_map(s,v);
                        }
                        else{
                            string tmp = "Error: Symbol \"" + s + "\" is multiply-defined";
                            yyerror(tmp.c_str());
                        }
                    }

                    else if($2.type == INT){
                        *($$.code) << ". " << $1 << "\n";
                        string s = $1;
                        if(!check_map(s)){
                            push_map(s,v);
                        }
                        else{
                            string tmp = "Error: Symbol \"" + s + "\" is multiply-defined";
                            yyerror(tmp.c_str());
                        }
                    }else{
                            yyerror("ERROR: invalid type");
                    }
                }
                ;

declarations_1:  COMMA IDENT declarations_1 {
                    $$.code = $3.code;
                    $$.type = $3.type;
                    $$.length = $3.length;
                    $$.vars = $3.vars;
                    Var v = Var();
                    v.type = $3.type;
                    v.length = $3.length;
                    v.place = new string();
                    *v.place = $2;
                    $$.vars->push_back(v);
                    if($3.type == INT_ARR){
                        *($$.code) << ".[] " << $2 << ", " << $3.length << "\n";
                        string s = $2;
                        if(!check_map(s)){
                            push_map(s,v);
                        }
                        else{
                            string tmp = "Error: Symbol \"" + s + "\" is multiply-defined";
                            yyerror(tmp.c_str());
                        }
                    }
                    else if($3.type == INT){
                        *($$.code) << ". " << $2 << "\n";
                        string s = $2;
                        if(!check_map(s)){
                            push_map(s,v);
                        }
                        else{
                            string tmp = "Error: Symbol \"" + s + "\" is multiply-defined";
                            yyerror(tmp.c_str());
                        }
                    }
                }
                | COLON declarations_2 INTEGER {
                    $$.code = $2.code;
                    $$.type = $2.type;
                    $$.length = $2.length;
                    $$.vars = $2.vars;
                }
                ;

declarations_2:  ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF{
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

statement:          var ASSIGN expression{
                    $$.code = $1.code;
                    *($$.code) << $3.code->str();
                    if($1.type == INT && $3.type == INT){
                       *($$.code) << "= " << *$1.place << ", " << *$3.place << "\n";
                    }
                    else if($1.type == INT && $3.type == INT_ARR){
                        *($$.code) << gen_code($1.place, "=[]", $3.place, $3.index);
                    }
                    else if($1.type == INT_ARR && $3.type == INT && $1.value != NULL){
                        *($$.code) << gen_code($1.value, "[]=", $1.index, $3.place);
                    }
                    else if($1.type == INT_ARR && $3.type == INT_ARR){
                        string *tmp = new_temp();
                        *($$.code) << dec_temp(tmp) << gen_code(tmp, "=[]", $3.place, $3.index);
                        *($$.code) << gen_code($1.value, "[]=", $1.index, tmp);
                    }
                    else{
                        yyerror("Error: expression is null.");
                    }
                }
                | IF bool_expr THEN statements assi_expr ENDIF{
                    $$.code = new stringstream();
                    $$.begin = new_label();
                    $$.end = new_label();
                    *($$.code) << $2.code->str() << "?:= " << *$$.begin << ", " <<  *$2.place << "\n";
                    if($5.begin != NULL){                       
                        *($$.code) << go_to($5.begin); 
                        *($$.code) << dec_label($$.begin)  << $4.code->str() << go_to($$.end);
                        *($$.code) << dec_label($5.begin) << $5.code->str();
                    }
                    else{
                        *($$.code) << go_to($$.end)<< dec_label($$.begin)  << $4.code->str();
                    }
                    *($$.code) << dec_label($$.end);
                }
                | WHILE bool_expr enter_loop BEGINLOOP statements ENDLOOP{
                    $$.code = new stringstream();
                    $$.begin = $3.begin;
                    $$.parent = $3.parent;
                    $$.end = $3.end;
                    *($$.code) << dec_label($$.parent) << $2.code->str() << "?:= " << *$$.begin << ", " << *$2.place << "\n" 
                    << go_to($$.end) << dec_label($$.begin) << $5.code->str() << go_to($$.parent) << dec_label($$.end);
                    loop_stack.pop();

                }
                | DO enter_loop BEGINLOOP statements ENDLOOP WHILE bool_expr{
                    $$.code = new stringstream();
                    $$.begin = $2.begin;
                    $$.parent = $2.parent;
                    $$.end = $2.end;
                    *($$.code) << dec_label($$.begin) << $4.code->str() << dec_label($$.parent) << $7.code->str() << "?:= " << *$$.begin << ", " << *$7.place << "\n" << dec_label($$.end);
                    loop_stack.pop();
                }
                | READ var read_vars{
                    $$.code = $2.code;
                    if($2.type == INT){
                       *($$.code) << ".< " << *$2.place << "\n"; 
                    }
                    else{
                       *($$.code) << ".[]< " << *$2.place << ", " << $2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                }
                | WRITE var write_vars {
                    $$.code = $2.code;
                    if($2.type == INT){
                       *($$.code) << ".> " << *$2.place << "\n"; 
                    }
                    else{
                       *($$.code) << ".[]> " << *$2.value << ", " << *$2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                  }
                | CONTINUE{
                    $$.code = new stringstream();
                    if(loop_stack.size() <= 0){
                        yyerror("ERROR: continue statement not within a loop");
                    }
                    else{
                        Loop l = loop_stack.top();
                        *($$.code) << ":= " << *l.parent << "\n";
                    }
                }
                | RETURN expression{
                    $$.code = $2.code;
                    $$.place = $2.place;
                    *($$.code) << "ret " << *$$.place << "\n";
                }
                
assi_expr:   {
                    $$.code = new stringstream();
                    $$.begin = NULL;
                }
                | ELSE statements{
                    $$.code = $2.code;
                    $$.begin = new_label();
                }
                ;

enter_loop:         {
                    $$.code = new stringstream();
                    $$.begin = new_label();
                    $$.parent = new_label();
                    $$.end = new_label();
                    Loop l = Loop();
                    l.parent = $$.parent;
                    l.begin = $$.begin;
                    l.end = $$.end;
                    loop_stack.push(l);
                };

read_vars:   COMMA var read_vars {
                    $$.code = $2.code;
                    if($2.type == INT){
                       *($$.code) << ".< " << *$2.place << "\n"; 
                    }
                    else{
                       *($$.code) << ".[]< " << *$2.place << ", " << $2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                }
                | {
                    $$.code = new stringstream();
                  }
                ;

write_vars:   COMMA var write_vars{
                    $$.code = $2.code;
                    if($2.type == INT){
                       *($$.code) << ".> " << *$2.place << "\n"; 
                    }
                    else{
                       *($$.code) << ".[]> " << *$2.value << ", " << *$2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                  }
                |{
                    $$.code = new stringstream();
                 }
                ;

bool_expr:       rel_expr bool_expr_continue{
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    if($2.op != NULL && $2.place != NULL)
                    {                        
                        $$.place = new_temp();
                       *($$.code) << dec_temp($$.place) << gen_code($$.place, *$2.op, $1.place, $2.place);
                    }
                    else{
                        $$.place = $1.place;
                        $$.op = $1.op;
                    }
                }
                ;

bool_expr_continue:      OR rel_expr bool_expr_continue{
                    expression_code($$,$2,$3,"||");
                }
                |{
                    $$.code = new stringstream();
                    $$.op = NULL;
                 }
                ; 

rel_expr:    rel_exprs rel_expr_continute{
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    if($2.op != NULL && $2.place != NULL)
                    {                        
                        $$.place = new_temp();
                       *($$.code) << dec_temp($$.place) << gen_code($$.place, *$2.op, $1.place, $2.place);
                    }
                    else{
                        $$.place = $1.place;
                        $$.op = $1.op;
                    }
                }
                ;

rel_expr_continute:   AND rel_exprs rel_expr_continute{
                    expression_code($$,$2,$3,"&&");

                }
                |{
                    $$.code = new stringstream();
                    $$.op = NULL;
                 }
                ;

rel_exprs:   rel_exprs_continue{
                    $$.code = $1.code;
                    $$.place = $1.place; 
                }
                | NOT rel_exprs_continue{
                    $$.code = $2.code;
                    $$.place = new_temp();
                    *($$.code) << dec_temp($$.place) << gen_code($$.place, "!", $2.place, NULL);
                }
                ;

rel_exprs_continue: expression comp expression{
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    *($$.code) << $3.code->str();
                    $$.place = new_temp();
                    *($$.code)<< dec_temp($$.place) << gen_code($$.place, *$2.op, $1.place, $3.place);
                }
                | TRUE{                    
                    $$.code = new stringstream();
                    $$.place = new string();
                    *$$.place = "1";
                    }
                | FALSE{
                    $$.code = new stringstream();
                    $$.place = new string();
                    *$$.place = "0";
                  }
                | L_PAREN bool_expr R_PAREN{
                    $$.code = $2.code;
                    $$.place = $2.place;
                }
                ;

comp:           EQ{
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "==";
                  }
                | NEQ{
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "!=";
                  }
                | LT{
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "<";
                  }
                | GT{
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = ">";
                  }
                | LTE{
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "<=";
                  }
                | GTE{
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = ">=";
                  }
                ;

expression:     mult_expr expressions{
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    if($2.op != NULL && $2.place != NULL)
                    {                        
                        $$.place = new_temp();
                       *($$.code)<< dec_temp($$.place) << gen_code($$.place, *$2.op, $1.place, $2.place);
                    }
                    else{
                        $$.place = $1.place;
                        $$.op = $1.op;
                    }
                    $$.type = INT;
                  }
                ;

expressions:   ADD mult_expr expressions {
                    expression_code($$,$2,$3,"+");
                  }
                | SUB mult_expr expressions{
                    expression_code($$,$2,$3,"-");
                  }
                | {
                    $$.code = new stringstream();
                    $$.op = NULL;
                  }
                ;

mult_expr:      term mult_exprs{
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    if($2.op != NULL && $2.place != NULL)
                    {                        
                        $$.place = new_temp();
                       *($$.code)<< dec_temp($$.place)<< gen_code($$.place, *$2.op, $1.place, $2.place);
                    }
                    else{
                        $$.place = $1.place;
                        $$.op = $1.op;
                    }
                  }
                ;


mult_exprs:    MULT term mult_exprs{
                    expression_code($$,$2,$3,"*");

                  }
                | DIV term mult_exprs{
                    expression_code($$,$2,$3,"/");
                  }
                | MOD term mult_exprs{          
                    expression_code($$,$2,$3,"%");
                  }
                |{
                    $$.code = new stringstream();
                    $$.op = NULL;
                 }
                ;

term:           SUB terms{
                    $$.code = $2.code;
                    $$.place = new_temp();
                    string tmp = "-1";
                    *($$.code)<< dec_temp($$.place) << gen_code($$.place, "*",$2.place, &tmp );
                  }
                | terms{
                    $$.code = $1.code;
                    $$.place = $1.place;
                  }
                | termss{
                    $$.code = $1.code;
                    $$.place = $1.place;
                  }
                ;

terms:         var{
                    $$.code = $1.code;
                    $$.place= $1.place;
                    $$.index = $1.index;
                  }
                | NUMBER{
                    $$.code = new stringstream();
                    $$.place = new string();
                    *$$.place = to_string($1);
                  }
                | L_PAREN expression R_PAREN{
                    $$.code = $2.code;
                    $$.place = $2.place;
                  }
                ;

termss:         IDENT L_PAREN termsss R_PAREN{
                    $$.code = $3.code;
                    $$.place = new_temp();
                    *($$.code) << dec_temp($$.place)<< "call " << $1 << ", " << *$$.place << "\n";
                    string tmp = $1;
                    check_map_dec(tmp);
                }
                ;

termsss:        expression termssss{
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    *($$.code) << "param " << *$1.place << "\n";
                } 
                | {
                    $$.code = new stringstream(); 
                  }
                ;
termssss:        COMMA termsss{
                    $$.code = $2.code;
                } 
                | {
                    $$.code = new stringstream();
                  }

var:            IDENT vars{

                    $$.code = $2.code;
                    $$.type = $2.type;
                    string tmp = $1;
                    check_map_dec(tmp);
                    if(check_map(tmp) && var_map[tmp].type != $2.type){
                        if($2.type == INT_ARR){
                            string output ="Error: used variable \"" + tmp + "\" is not an array.";
                            yyerror(output.c_str());
                        }
                        else if($2.type == INT){
                            string output ="Error: used array variable \"" + tmp + "\" is missing a specified index.";
                            yyerror(output.c_str());
                        }
                    }

                    if($2.index == NULL){
                        $$.place = new string();
                        *$$.place = $1;
                    }
                    else{
                        $$.index = $2.index;
                        $$.place = new_temp();
                        string* tmp = new string();
                        *tmp = $1;
                        *($$.code) << dec_temp($$.place) << gen_code($$.place, "=[]", tmp,$2.index);
                        $$.value = new string();
                        *$$.value = $1;
                    }
                }
                ;

vars:          L_SQUARE_BRACKET expression R_SQUARE_BRACKET{
                    $$.code = $2.code;
                    $$.place = NULL;
                    $$.index = $2.place;
                    $$.type = INT_ARR;
                }
                |{
                    $$.code = new stringstream();
                    $$.index = NULL;
                    $$.place = NULL;
                    $$.type = INT;
                 }
                ;
            
%%

void print_test(string o){
    cout << "\n---------TEST-----------\n"
        << o
        << "\n----------END -----------\n";
}

string gen_code(string *res, string op, string *val1, string *val2){
    if(op == "!"){
        return op + " " + *res + ", " + *val1 + "\n";
    }
    else{
        return op + " " + *res + ", " + *val1 + ", "+ *val2 +"\n";
    }
}

string to_string(char* s){
    ostringstream c;
    c << s;
    return c.str();
}

string to_string(int s){
    ostringstream c;
    c << s;
    return c.str();
}
string go_to(string *s){
    return ":= "+ *s + "\n"; 
}
string dec_label(string *s){
    return ": " +*s + "\n"; 
}
string dec_temp(string *s){
    return ". " +*s + "\n"; 
}
string * new_temp(){
    string * t = new string();
    ostringstream conv;
    conv << tempi;
    *t = "__temp__"+ conv.str();
    tempi++;
    return t;
}
string * new_label(){
    string * t = new string();
    ostringstream conv;
    conv << templ;
    *t = "__label__"+ conv.str();
    templ++;
    return t;
}
                   
void expression_code( Terminal &DD, Terminal D2, Terminal D3, string op){
    DD.code = D2.code;
    *(DD.code) << D3.code->str();
    if(D3.op == NULL){
        DD.place = D2.place;
        DD.op = new string();
        *DD.op = op;
    }
    else{
        DD.place = new_temp();
        DD.op = new string();
        *DD.op = op;

        *(DD.code) << dec_temp(DD.place)<< gen_code(DD.place , *D3.op, D2.place, D3.place);
    } 
}


void push_map(string name, Var v){
    if(var_map.find(name) == var_map.end()){
        var_map[name] = v;
    }
    else{
        string tmp = "ERROR: " + name + " already exists";
        yyerror(tmp.c_str());
    }
}
bool check_map(string name){
    if(var_map.find(name) == var_map.end()){
        return false;
    }
    return true;
}
void check_map_dec(string name){
    if(!check_map(name)){
        string tmp = "ERROR: \"" + name + "\" does not exist";
        yyerror(tmp.c_str());
    }
}

int yyerror(const char *s)
{
    extern int line_cnt;
    extern int cursor_pos;
    success = false;
    printf(">>> Line %d, position %d: %s\n",line_cnt,cursor_pos,s);
    return -1;
}


int main(int argc, char **argv) {

    if ( (argc > 1) && (myin = fopen(argv[1],"r")) == NULL){
        printf("syntax: %s filename\n", argv[0]);
        return 1;
    }

    yyparse();

    if(success){
        ofstream file;
        file.open("mil_code.mil");
        file << all_code->str();
        file.close();
    }
    else{
        cout << "***Errors exist, fix to compile code***" << endl;
    }


    return 0;
}
