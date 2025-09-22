%{
#include <stdio.h>

int a_word_count = 0;
%}

%%

[aA][a-zA-Z0-9]*     { a_word_count++; }   // Words starting with a or A
[a-zA-Z0-9]+         ;                     // Other words: ignore
[ \t\n]+             ;                     // Whitespace: ignore
.                    ;                     // Punctuation/symbols: ignore

%%

int main() {
    printf("Enter text (Ctrl+D to stop):\n");
    yylex();
    printf("\nNumber of words starting with 'a' or 'A': %d\n", a_word_count);
    return 0;
}

int yywrap() {
    return 1;
}


