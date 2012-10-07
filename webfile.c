//-*-coding:utf-8-*-
#include <stdio.h>
#include "magic.h"

magic_t m=NULL;

void init_magic(){
    m = magic_open(MAGIC_NONE);

    // load magic
    magic_load(m, "./magic");
}

const char * webfile_check(char * filename){
    if ( m == NULL ) {
        init_magic();
    }

    // checking file
    const char* result = magic_file(m, filename);

    if ( result == NULL ) {
        printf("error: %s\n", magic_error(m));
    } else {
        printf("%s\n", result);
    }

    return result;
}


int main(){
    int * p = (int *)webfile_check;
    return 0;
}
