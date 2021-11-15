#ifndef _minil_h_
#define _minil_h_

#define YY_NO_UNPUT

#include <iostream>
#include <vector>
#include <stack>
#include <map>
#include <sstream>
#include <fstream>
#include <stdio.h>
#include <string>

using namespace std;

enum Type {INT,INT_ARR,FUNC};

    struct Var{
        
        string *place;
        string *value;
        string *offset;
        //vector
        Type type;
        int length;
        string *index;
    } ;

    struct Loop{
        string *begin;
        string *parent;
        string *end;
    };


    struct secondStruct{
       stringstream *code;
       string *place;
       string *value;
       string *offset;
       string *op;
       string *begin;
       string *parent;
       string *end;
       Type type;
       int length;
       string *index;
       vector<string> *ids;
       vector<Var> *vars; 
    };

#endif
