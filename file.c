//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: tm
//----------------------------------------------------------
#include <stdio.h>
#include "magic.h"

int main(int argc, char** argv){
    magic_t m = magic_open(MAGIC_NONE);

    // load magic
    magic_load(m, "./magic");

    // checking file
    const char* result = magic_file(m, "testfile");

    if ( result == NULL ) {
        printf("error: %s\n", magic_error(m));
    } else {
        printf("%s\n", result);
    }

    magic_close(m);
    return 0;
}






