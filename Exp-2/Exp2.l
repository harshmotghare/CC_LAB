%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int comment_count = 0;
int keyword_count = 0;
int identifier_count = 0;
int word_count = 0;
int line_count = 0;
int space_count = 0;

char *keywords[] = {
    "int", "char", "float", "double", "return", "if", "else", "while", "for", "do",
    "switch", "case", "break", "continue", "void", "long"
};

int is_keyword(char *str) {
    for (int i = 0; i < sizeof(keywords) / sizeof(char*); i++) {
        if (strcmp(str, keywords[i]) == 0)
            return 1;
    }
    return 0;
}
%}

%%

"//".*                               { comment_count++; }
"/*"([^*]|\*+[^*/])*\*+"/"           { comment_count++; }

[a-zA-Z_][a-zA-Z0-9_]*               {
                                        if (is_keyword(yytext)) {
                                            keyword_count++;
                                        } else {
                                            identifier_count++;
                                        }
                                        word_count++;
                                    }

[0-9]+                               { word_count++; }

[ \t]+                               { space_count += yyleng; }
\n                                   { line_count++; }

.                                    ; // Ignore other characters

%%
int main() {
    printf("Enter code (Ctrl+D to stop):\n");
    yylex();


    printf("\n--- Analysis Result ---\n");
    printf("Comments      : %d\n", comment_count);
    printf("Keywords      : %d\n", keyword_count);
    printf("Identifiers   : %d\n", identifier_count);
    printf("Words         : %d\n", word_count);
    printf("Lines         : %d\n", line_count + 1); // +1 to include the last line
    printf("Spaces        : %d\n", space_count);

    return 0;
}

int yywrap() {
    return 1;
}

