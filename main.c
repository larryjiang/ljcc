#include <assert.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "ljcc.h"










int main(int argc, char** argv){
    if(argc != 2){
        fprintf(stderr, "%s: invalid number of arguments\n",argv[0]);
        return 1;
    };
    Token* token = tokenize(argv[1]);

    Function * node = parse(token);

    codegen(node);

    return 0;

};
