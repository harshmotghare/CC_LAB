%{
#include <stdio.h>

int vowel_count = 0;
int consonant_count = 0;
int digit_count = 0;
%}

%%
[aeiouAEIOU]    { vowel_count++; }
[a-zA-Z]        { consonant_count++; }
[0-9]           { digit_count++; }
[ \t\n]         ; // Ignore whitespace
.               ; // Ignore any other character
%%

int main() {
    printf("Enter text (Ctrl+D to stop):\n");
    yylex();

    printf("\nVowels: %d\n", vowel_count);
    printf("Consonants: %d\n", consonant_count);
    printf("Digits: %d\n", digit_count);
    return 0;
}

int yywrap() {
    return 1;
}
