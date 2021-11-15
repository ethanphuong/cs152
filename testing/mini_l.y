/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
//#include <stdio.h>
//#define YY_NO_UNPUT
//int yyparse();
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

    //enum Type {INT, INT_ARR};

    struct {
        stringstream *code;
    }NonTerminal;

    struct Terminal Terminal;


//    struct {
//       stringstream *code;
//       //location
//       string *place;
//       string *value;
//       string *offset;
//       // branches
//       string *op;
//       string *begin;
//       string *parent;
//       string *end;
//       // type
//       //uint val;
//       Type type;
//       int length;
//       string *index;
//       // idents and vars
//       vector<string> *ids;
//       vector<Var> *vars; 
//    } Terminal;


}

%error-verbose
//%skeleton "lalr1.cc"
//%require "3.0.4"
//%define api.token.constructor
//%define api.value.type variant
//%define parse.assert

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


%type <NonTerminal> program
%type <Terminal> decl_loop stmt_loop function function_2 declaration declaration_2 declaration_3 statement  statement_1 statement_2   statement_21 statement_3   statement_4   statement_5   statement_51  statement_6   statement_61  bool_exp      bool_exp2     rel_and_exp   rel_and_exp2  relation_exp   relation_exp_s comp          expression    expression_2  mult_expr     mult_expr_2   term          term_2        term_3        term_31       term_32       var           var_2         b_loop b_func


%%

program:    function program {
                //printf("program -> function program\n");
                $$.code = $1.code;
                *($$.code) << $2.code->str();
                if(!no_main){
                    yyerror("ERROR: main function not defined.");
                }
                //print_test("program:\n" + $$.code->str());

                all_code = $$.code;
              } 
            | {
                //printf("program -> EPSILON\n");
                $$.code = new stringstream();
              }
            ;

function:   FUNCTION b_func SEMICOLON BEGIN_PARAMS decl_loop END_PARAMS BEGIN_LOCALS decl_loop END_LOCALS BEGIN_BODY statement SEMICOLON function_2 {
                //printf("function -> FUNCTION IDENT SEMICOLON BEGIN_PARAMS decl_loop END_PARAMS BEGIN_LOCALS decl_loop END_LOCALS BEGIN_BODY statement SEMICOLON function_2\n");
                //IDENT = $2
                //decl_loop = $5
                //decl_loop = $8
                //statement = $11
                //func_2 = $13
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
b_func: IDENT {
            //cout << "b_func" << endl;
            string tmp = $1;
            Var myf = Var();
            myf.type = FUNC;
            if(!check_map(tmp)){
                push_map(tmp,myf); 
            }
            $$.place = new string();
            *$$.place = tmp;
            //cout << "end b_func" << endl;
        };

function_2: statement SEMICOLON function_2 {
                //printf("function_2 -> statement SEMICOLON function_2\n");
                $$.code = $1.code;
                *($$.code) << $3.code->str();
              } 
            | END_BODY {
                //printf("function_2 -> END_BODY\n");
                $$.code = new stringstream();
                *($$.code) << "endfunc\n";
              }
            ;

decl_loop:  declaration SEMICOLON decl_loop {
                    //printf("decl_loop -> declaration SEMICOLON decl_loop\n");
                $$.code = $1.code;
                $$.vars = $1.vars;
                for( int i = 0; i < $3.vars->size(); ++i){
                    $$.vars->push_back((*$3.vars)[i]);
                }
                *($$.code) << $3.code->str();
                } 
            | {
                //printf("decl_loop -> EPSILON\n");
                $$.code = new stringstream();
                $$.vars = new vector<Var>();
              }
            ;

stmt_loop:  statement SEMICOLON stmt_loop {
                //printf("stmt_loop -> statement SEMICOLON stmt_loop\n");
                $$.code = $1.code;
                *($$.code) << $3.code->str();
              } 
            | {
                //printf("stmt_loop -> EPSILON\n");
                $$.code = new stringstream();
              }
            ;

declaration:    IDENT declaration_2 {
                    //printf("declaration -> IDENT declaration_2\n");
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
                        //if(var_map.find($1) == var_map.end()){
                        //    string s = $1;
                        //    var_map[s] = v;
                        //}
                        //else{
                        //    yyerror("");
                        //}
                    }else{
                            yyerror("ERROR: invalid type");
                    }
                    //print_test(to_string($$.vars->size()));
                    //for(int i = 0; i < $$.vars->size(); ++i){
                    //    print_test("type:" + to_string((*$$.vars)[i].type) + "\nlength:" + to_string((*$$.vars)[i].length) + "\nplace:" + *(*$$.vars)[i].place);
                    //}

                }
                ;

declaration_2:  COMMA IDENT declaration_2 {
                    //printf("declaration_2 -> COMMA IDENT declaration_2\n");
                    $$.code = $3.code;
                    $$.type = $3.type;
                    $$.length = $3.length;
                    //TODO: add variable to symbol_table
                    //TODO: check if symbol already exists
                    //TODO: check if array size <= 0
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
                    }else{
                        //printf("================ ERRRR\n");
                    }
                }
                | COLON declaration_3 INTEGER {
                    //printf("declaration_2 -> COLON declaration_3 INTEGER\n");
                    $$.code = $2.code;
                    $$.type = $2.type;
                    $$.length = $2.length;
                    $$.vars = $2.vars;
                }
                ;

declaration_3:  ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF{
                    //printf("declaration_3 -> ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF\n");
                    $$.code = new stringstream();
                    $$.vars = new vector<Var>();
                    $$.type = INT_ARR;
                    $$.length = $3;
                }
                | {
                    //printf("declaration_3 -> EPSILON\n");
                    $$.code = new stringstream();
                    $$.vars = new vector<Var>();
                    $$.type = INT;
                    $$.length = 0;
                  }
                ;

statement:      statement_1 {
                    $$.code = $1.code;
                }
                | statement_2 {
                    $$.code = $1.code;
                }
                | statement_3 {
                    $$.code = $1.code;
                }
                | statement_4 {
                    $$.code = $1.code;
                }
                | statement_5 {
                    $$.code = $1.code;
                    //print_test($$.code->str());
                }
                | statement_6 {
                    $$.code = $1.code;
                }
                | CONTINUE{
                    //printf("statement -> CONTINUE\n");
                    $$.code = new stringstream();
                    if(loop_stack.size() <= 0){
                        yyerror("ERROR: continue statement not within a loop");
                    }
                    else{
                        Loop l = loop_stack.top();
                        *($$.code) << ":= " << *l.parent << "\n";
                        //loop_stack.pop();
                    }
                    //TODO: probably add code to jump to start of loop?
                    //TODO: check if used inside loop
                }
                | RETURN expression{
                    //printf("statement -> RETURN expression\n");
                    $$.code = $2.code;
                    $$.place = $2.place;
                    *($$.code) << "ret " << *$$.place << "\n";
                }

statement_1:    var ASSIGN expression{
                    //printf("statement -> var ASSIGN expression\n");
                    //TODO: check if var was declared?
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
                    //print_test($$.code->str());
                }
                ;

statement_2:    IF bool_exp THEN stmt_loop statement_21 ENDIF{
                    //cout << "statement -> IF bool_exp THEN stmt_loop statement_21 ENDIF\n" << endl;
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
                ;

statement_21:   {
                    //printf("statement_21 -> EPSILON\n");
                    $$.code = new stringstream();
                    $$.begin = NULL;
                }
                | ELSE stmt_loop{
                    //printf("statement_21 -> ELSE stmt_loop\n");
                    $$.code = $2.code;
                    $$.begin = new_label();
                }
                ;

statement_3:    WHILE bool_exp b_loop BEGINLOOP stmt_loop ENDLOOP{
                    //cout << "statement -> WHILE bool_exp BEGINLOOP stmt_loop ENDLOOP\n" << endl;
                    $$.code = new stringstream();
                    $$.begin = $3.begin;
                    $$.parent = $3.parent;
                    $$.end = $3.end;
                    //$$.begin = new_label();
                    //$$.parent = new_label();
                    //$$.end = new_label();
                    //Loop l = Loop();
                    //l.parent = $$.parent;
                    //l.begin = $$.begin;
                    //l.end = $$.end;
                    ////cout << "\n\nBEFORE:" << loop_stack.size();
                    //loop_stack.push(l);
                    *($$.code) << dec_label($$.parent) << $2.code->str() << "?:= " << *$$.begin << ", " << *$2.place << "\n" 
                    << go_to($$.end) << dec_label($$.begin) << $5.code->str() << go_to($$.parent) << dec_label($$.end);
                    loop_stack.pop();

                }
                ;

b_loop:         {
                    //cout << "bLOOP" << endl;
                    $$.code = new stringstream();
                    $$.begin = new_label();
                    $$.parent = new_label();
                    $$.end = new_label();
                    //cout << "add loop" << endl;
                    Loop l = Loop();
                    l.parent = $$.parent;
                    l.begin = $$.begin;
                    l.end = $$.end;
                    //cout << "\n\nBEFORE:" << loop_stack.size();
                    //cout << "push loop: " << loop_stack.size() << endl;
                    loop_stack.push(l);
                    //cout << "end bloop" << endl;
                };

statement_4:    DO b_loop BEGINLOOP stmt_loop ENDLOOP WHILE bool_exp{
                    //cout << "statement -> DO BEGINLOOP stmt_loop ENDLOOP WHILE bool_exp\n" << endl;
                    $$.code = new stringstream();
                    $$.begin = $2.begin;
                    $$.parent = $2.parent;
                    $$.end = $2.end;
                    *($$.code) << dec_label($$.begin) << $4.code->str() << dec_label($$.parent) << $7.code->str() << "?:= " << *$$.begin << ", " << *$7.place << "\n" << dec_label($$.end);
                    loop_stack.pop();
                }
                ;

statement_5:    READ var statement_51{
                    //printf("statement -> READ var statement_51\n");
                    $$.code = $2.code;
                    if($2.type == INT){
                       *($$.code) << ".< " << *$2.place << "\n"; 
                    }
                    else{
                       *($$.code) << ".[]< " << *$2.place << ", " << $2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                    //print_test($$.code->str());
                }
                ;

statement_51:   COMMA var statement_51 {
                    //printf("statement_51 -> COMMA var statement_51\n");
                    $$.code = $2.code;
                    if($2.type == INT){
                       *($$.code) << ".< " << *$2.place << "\n"; 
                    }
                    else{
                       *($$.code) << ".[]< " << *$2.place << ", " << $2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                    //print_test($$.code->str());
                }
                | {
                    //printf("statement_51 -> EPSILON\n");
                    $$.code = new stringstream();
                  }
                ;

statement_6:    WRITE var statement_61{
                    //printf("statement -> WRITE var statement_61\n");
                    $$.code = $2.code;
                    if($2.type == INT){
                       *($$.code) << ".> " << *$2.place << "\n"; 
                    }
                    else{
                       *($$.code) << ".[]> " << *$2.value << ", " << *$2.index << "\n"; 
                    }
                    *($$.code) << $3.code->str();
                  }
                ;

statement_61:   COMMA var statement_61{
                    //printf("statement_61 -> COMMA var statement_61\n");
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
                    //printf("statement_61 -> EPSILON\n");
                    $$.code = new stringstream();
                 }
                ;

bool_exp:       rel_and_exp bool_exp2{
                    //cout << "bool_exp -> rel_and_exp bool_exp2\n" << endl;
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    if($2.op != NULL && $2.place != NULL)
                    {                        
                        $$.place = new_temp();
                        //cout << "\n\nOP:" << *$2.op << "\nPLACE:" << *$1.place << "\n$2PLACE:" << *$2.place << endl;
                       *($$.code) << dec_temp($$.place) << gen_code($$.place, *$2.op, $1.place, $2.place);
                        //cout << "\n\nOP:" << $2.op << "\nPLACE:" << $1.place << "\n$2PLACE:" << $2.place << endl;
                    }
                    else{
                        //cout << "ELSE" << endl;
                        $$.place = $1.place;
                        $$.op = $1.op;
                    }
                    //print_test($$.code->str());
                    //cout << "END OF BOOL" << endl;
                }
                ;

bool_exp2:      OR rel_and_exp bool_exp2{
                    //cout <<"bool_exp2 -> OR rel_and_exp bool_exp2\n" << endl;
                    //$$.code = $2.code;
                    //*($$.code) << $3.code->str();
                    //if($3.op == NULL){
                    //    $$.place = $2.place;
                    //    $$.op = new string();
                    //    *$$.op = "||";
                    //}
                    //else{
                    //    $$.place = new_temp();
                    //    $$.op = new string();
                    //    *$$.op = "||";

                    //    *($$.code) << dec_temp($$.place) << gen_code($$.place , *$$.op, $2.place, $3.place);
                    //} 
                    expression_code($$,$2,$3,"||");


                }
                |{
                    //cout << "bool_exp2 -> EPSILON\n" << endl;
                    $$.code = new stringstream();
                    $$.op = NULL;
                 }
                ; 

rel_and_exp:    relation_exp rel_and_exp2{
                    //printf("rel_and_exp -> relation_exp rel_and_exp2\n");
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

rel_and_exp2:   AND relation_exp rel_and_exp2{
                    //printf("rel_and_exp2 -> AND relation_exp rel_and_exp2\n");
                    //$$.code = $2.code;
                    //*($$.code) << $3.code->str();
                    //if($3.op == NULL){
                    //    $$.place = $2.place;
                    //    $$.op = new string();
                    //    *$$.op = "&&";
                    //}
                    //else{
                    //    $$.place = new_temp();
                    //    $$.op = new string();
                    //    *$$.op = "&&";

                    //    *($$.code) << dec_temp($$.place) << gen_code($$.place , *$$.op, $2.place, $3.place);
                    //} 
                    expression_code($$,$2,$3,"&&");

                }
                |{
                    //printf("rel_and_exp2 -> EPSILON\n");
                    $$.code = new stringstream();
                    $$.op = NULL;
                 }
                ;

relation_exp:   relation_exp_s{
                    //printf("relation_exp -> relation_exp_s\n");
                    $$.code = $1.code;
                    $$.place = $1.place; 
                }
                | NOT relation_exp_s{
                    //printf("relation_exp -> NOT relation_exp_s\n");
                    $$.code = $2.code;
                    $$.place = new_temp();
                    *($$.code) << dec_temp($$.place) << gen_code($$.place, "!", $2.place, NULL);
                }
                ;

relation_exp_s: expression comp expression{
                    //printf("relation_exp_s -> expression comp expression\n");
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    *($$.code) << $3.code->str();
                    $$.place = new_temp();
                    *($$.code)<< dec_temp($$.place) << gen_code($$.place, *$2.op, $1.place, $3.place);
                }
                | TRUE{                    
                    //printf("relation_exp_s -> TRUE\n");
                    $$.code = new stringstream();
                    $$.place = new string();
                    *$$.place = "1";
                    }
                | FALSE{
                    //printf("relation_exp_s -> FALSE\n");
                    $$.code = new stringstream();
                    $$.place = new string();
                    *$$.place = "0";
                  }
                | L_PAREN bool_exp R_PAREN{
                    //cout << "relation_exp_s -> L_PAREN bool_exp R_PAREN\n" << endl;
                    $$.code = $2.code;
                    $$.place = $2.place;
                }
                ;

comp:           EQ{
                    //printf("comp -> EQ\n");
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "==";
                  }
                | NEQ{
                    //printf("comp -> NEQ\n");
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "!=";
                  }
                | LT{
                    //printf("comp -> LT\n");
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "<";
                  }
                | GT{
                    //printf("comp -> GT\n");
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = ">";
                  }
                | LTE{
                    //printf("comp -> LTE\n");
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = "<=";
                  }
                | GTE{
                    //printf("comp -> GTE\n");
                    $$.code = new stringstream();
                    $$.op = new string();
                    *$$.op = ">=";
                  }
                ;

expression:     mult_expr expression_2{
                    //printf("expression -> mult_expr expression_2\n");
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

expression_2:   ADD mult_expr expression_2 {
                    //printf("expression_2 -> ADD mult_expr expression_2\n");
                    //$$.code = $2.code;
                    //*($$.code) << $3.code->str();
                    //if($3.op == NULL){
                    //    $$.place = $2.place;
                    //    $$.op = new string();
                    //    *$$.op = "+";
                    //}
                    //else{
                    //    $$.place = new_temp();
                    //    $$.op = new string();
                    //    *$$.op = "+";

                    //    *($$.code)<< dec_temp($$.place) << gen_code($$.place , *$$.op, $2.place, $3.place);
                    //} 
                    expression_code($$,$2,$3,"+");

                    //print_test("ADD\n" +$$.code->str() +"\n");
                    //print_test($$.code->str());

                  }
                | SUB mult_expr expression_2{
                    //printf("expression_2 -> SUB mult_expr expression_2\n");
                    //$$.code = $2.code;
                    //*($$.code) << $3.code->str();
                    //if($3.op == NULL){
                    //    $$.place = $2.place;
                    //    $$.op = new string();
                    //    *$$.op = "-";
                    //}
                    //else{
                    //    $$.place = new_temp();
                    //    $$.op = new string();
                    //    *$$.op = "-";

                    //    *($$.code)<< dec_temp($$.place) << gen_code($$.place , *$$.op, $2.place, $3.place);
                    //}
                    expression_code($$,$2,$3,"-");
                    //print_test("SUB\n" +$$.code->str());
                  }
                | {
                    //printf("expression -> EPSILON\n");
                    $$.code = new stringstream();
                    $$.op = NULL;
                  }
                ;

mult_expr:      term mult_expr_2{
                    //printf("mult_expr -> term mult_expr_2\n");
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


mult_expr_2:    MULT term mult_expr_2{
                    //printf("mult_expr_2 -> MULT mult_expr\n");
                    //$$.code = $2.code;
                    //*($$.code) << $3.code->str();
                    //if($3.op == NULL){
                    //    $$.place = $2.place;
                    //    $$.op = new string();
                    //    *$$.op = "*";
                    //}
                    //else{
                    //    $$.place = new_temp();
                    //    $$.op = new string();
                    //    *$$.op = "*";

                    //    *($$.code) << dec_temp($$.place)<< gen_code($$.place , *$$.op, $2.place, $3.place);
                    //} 
                    expression_code($$,$2,$3,"*");

                  }
                | DIV term mult_expr_2{
                    //printf("mult_expr_2 -> DIV mult_expr\n");
                    // $$.code = $2.code;
                    //*($$.code) << $3.code->str();
                    //if($3.op == NULL){
                    //    $$.place = $2.place;
                    //    $$.op = new string();
                    //    *$$.op = "/";
                    //}
                    //else{
                    //    $$.place = new_temp();
                    //    $$.op = new string();
                    //    *$$.op = "/";

                    //    *($$.code)<< dec_temp($$.place) << gen_code($$.place , *$$.op, $2.place, $3.place);
                    //} 
                    expression_code($$,$2,$3,"/");
                    //print_test($$.code->str());
                  }
                | MOD term mult_expr_2{
                    //printf("mult_expr_2 -> MOD mult_expr\n");
                    expression_code($$,$2,$3,"%");
                    // $$.code = $2.code;
                    //*($$.code) << $3.code->str();
                    //if($3.op == NULL){
                    //    $$.place = $2.place;
                    //    $$.op = new string();
                    //    *$$.op = "%";
                    //}
                    //else{
                    //    $$.place = new_temp();
                    //    $$.op = new string();
                    //    *$$.op = "%";
                    //    *($$.code)<< dec_temp($$.place) << gen_code($$.place , *$$.op, $2.place, $3.place);
                    //} 
                  }
                |{
                    //printf("mult_expr_2 -> EPSILON\n");
                    $$.code = new stringstream();
                    $$.op = NULL;
                 }
                ;

term:           SUB term_2{
                    //printf("term -> SUB term_2\n");
                    $$.code = $2.code;
                    $$.place = new_temp();
                    string tmp = "-1";
                    *($$.code)<< dec_temp($$.place) << gen_code($$.place, "*",$2.place, &tmp );
                  }
                | term_2{
                    //printf("term -> term_2\n");
                    $$.code = $1.code;
                    $$.place = $1.place;
                  }
                | term_3{
                    //printf("term -> term_3\n");
                    $$.code = $1.code;
                    $$.place = $1.place;
                  }
                ;

term_2:         var{
                    //printf("term_2 -> var\n");
                    //TODO: check if var was declared?
                    $$.code = $1.code;
                    $$.place= $1.place;
                    $$.index = $1.index;
                  }
                | NUMBER{
                    //printf("term_2 -> NUMBER\n");
                    $$.code = new stringstream();
                    $$.place = new string();
                    *$$.place = to_string($1);
                  }
                | L_PAREN expression R_PAREN{
                    //printf("term_2 -> L_PAREN expression R_PAREN\n");
                    $$.code = $2.code;
                    $$.place = $2.place;
                  }
                ;

term_3:         IDENT L_PAREN term_31 R_PAREN{
                    //printf("term_3 -> IDENT L_PAREN term_31 R_PAREN\n");
                    //TODO: check if var was declared?
                    $$.code = $3.code;
                    $$.place = new_temp();
                    *($$.code) << dec_temp($$.place)<< "call " << $1 << ", " << *$$.place << "\n";
                    string tmp = $1;
                    check_map_dec(tmp);
                }
                ;

term_31:        expression term_32{
                    //printf("term_31-> expression term_32\n");
                    //TODO: check if function declared?
                    $$.code = $1.code;
                    *($$.code) << $2.code->str();
                    *($$.code) << "param " << *$1.place << "\n";
                } 
                | {
                    //printf("term_31 -> EPSILON\n");
                    $$.code = new stringstream(); 
                  }
                ;
term_32:        COMMA term_31{
                    //printf("term_32 -> COMMA term_31\n");
                    $$.code = $2.code;
                } 
                | {
                    //printf("term_32 -> EPSILON\n");
                    $$.code = new stringstream();
                  }

var:            IDENT var_2{
                    //printf("var -> IDENT var_2\n");
                    $$.code = $2.code;
                    $$.type = $2.type;
                    //TODO: check if var was declared?
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

var_2:          L_SQUARE_BRACKET expression R_SQUARE_BRACKET{
                    //TODO: check if var was declared?
                    //printf("var_2 -> L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");
                    $$.code = $2.code;
                    $$.place = NULL;
                    $$.index = $2.place;
                    $$.type = INT_ARR;
                }
                |{
                    //printf("var_2 -> EPSILON\n");
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

//void print_test(stringstream &o){
//    cout << "\n---------TEST-----------\n"
//        << o.str()
//        << "\n----------END -----------\n";
//}

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
                    //printf("expression_2 -> ADD mult_expr expression_2\n");
                    //$$.code = $2.code;
                    //*($$.code) << $3.code->str();
                    //if($3.op == NULL){
                    //    $$.place = $2.place;
                    //    $$.op = new string();
                    //    *$$.op = "+";
                    //}
                    //else{
                    //    $$.place = new_temp();
                    //    $$.op = new string();
                    //    *$$.op = "+";

                    //    *($$.code)<< dec_temp($$.place) << gen_code($$.place , *$$.op, $2.place, $3.place);
                    //} 
                    // 1 + i - j
 
void expression_code( Terminal &DD, Terminal D2, Terminal D3, string op){
    DD.code = D2.code;
    *(DD.code) << D3.code->str();
    if(D3.op == NULL){
        DD.place = D2.place;
        DD.op = new string();
        *DD.op = op;
    }
    else{
        //cout << "IN ELSE" << endl;
        DD.place = new_temp();
        DD.op = new string();
        *DD.op = op;

        *(DD.code) << dec_temp(DD.place)<< gen_code(DD.place , *D3.op, D2.place, D3.place);
    } 
}


void push_map(string name, Var v){
    //cout << "pushing map" << endl;
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

//void print_error(string s){
//    extern int line_cnt;
//    extern int cursor_pos;
//    cout << ">>> Error
//}


//int main(int argc, char **argv) {
//    if ( (argc > 1) && (yyin = fopen(argv[1],"r")) == NULL){
//        //printf("syntax: %s filename\n", argv[0]);
//        return 1;
//    }
//    yyparse();
//    return 0;
//}
//
int yyerror(const char *s)
{
    extern int line_cnt;
    extern int cursor_pos;
    success = false;
    printf(">>> Line %d, position %d: %s\n",line_cnt,cursor_pos,s);
    return -1;
    //return yyerror(string(s));
}


int main(int argc, char **argv) {

    if ( (argc > 1) && (myin = fopen(argv[1],"r")) == NULL){
        printf("syntax: %s filename\n", argv[0]);
        return 1;
    }

    //    for(int i = 0; i < argc; ++i){
    //        cout << argv[i] << endl;
    //    }

    yyparse();

    //all_code << program_code->str();

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

