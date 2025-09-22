%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

void convert(char *s, int mode) {
    int i;
    switch(mode) {
        case 1: // to UPPER
            for (i = 0; s[i]; i++) s[i] = toupper(s[i]);
            break;
        case 2: // to lower
            for (i = 0; s[i]; i++) s[i] = tolower(s[i]);
            break;
        case 3: // to Title
            if (s[0]) s[0] = toupper(s[0]);
            for (i = 1; s[i]; i++) s[i] = tolower(s[i]);
            break;
    }
}
%}

%%

^[0-9]+$ {
    printf("Input is a number: %s (no case conversion done)\n", yytext);
}

[a-z]+ {
    char word[100];
    strcpy(word, yytext);
    convert(word, 1); printf("UPPERCASE: %s\n", word);
    convert(yytext, 3); printf("Title Case: %s\n", yytext);
}

[A-Z]+ {
    char word[100];
    strcpy(word, yytext);
    convert(word, 2); printf("lowercase: %s\n", word);
    convert(yytext, 3); printf("Title Case: %s\n", yytext);
}

[A-Z][a-z]+ {
    char word[100];
    strcpy(word, yytext);
    convert(word, 1); printf("UPPERCASE: %s\n", word);
    convert(yytext, 2); printf("lowercase: %s\n", yytext);
}

[a-zA-Z]+ {
    printf("Invalid or Mixed Case input: %s\n", yytext);
}

. ; // ignore other characters

%%

int main() {
    printf("Enter a single word: ");
    yylex();
    return 0;
}

int yywrap() { return 1; }
