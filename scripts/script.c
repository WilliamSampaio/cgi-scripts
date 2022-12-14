#include "stdio.h"

int main(void) {

    char lang[] = "C";

    printf( "Content-Type: text/html\n\n" );
    printf("<html><head><title>%s</title></head><body><h1>Hello world!</h1><p>I am a %s Program :)</p></body></html>",lang, lang);
    return 0;
}