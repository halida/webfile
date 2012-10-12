#include <stdio.h>

int main(int argc, char** argv){

    printf("check file: %s\n", argv[1]);
    
    FILE *fd = fopen(argv[1], "r");
    int v, result = 0;
    while ( (v = fgetc(fd)) != EOF ) {
        result ++;
    }
    printf("count char: %d\n", result);
    return 0;
}


