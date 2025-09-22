%{
#include <stdio.h>
#include <stdlib.h>

// function to print integer → hexadecimal manually
void printHex(int num) {
    char hex[50];
    int i = 0;

    if (num == 0) {
        printf("Hexadecimal: 0\n");
        return;
    }

    while (num > 0) {
        int rem = num % 16;
        if (rem < 10)
            hex[i++] = rem + '0';
        else
            hex[i++] = rem - 10 + 'A';
        num /= 16;
    }
    hex[i] = '\0';

    // reverse and print
    printf("Hexadecimal: ");
    for (int j = i - 1; j >= 0; j--)
        putchar(hex[j]);
    printf("\n");
}

// function to print integer → octal manually
void printOctal(int num) {
    char oct[50];
    int i = 0;

    if (num == 0) {
        printf("Octal: 0\n");
        return;
    }

    while (num > 0) {
        int rem = num % 8;
        oct[i++] = rem + '0';
        num /= 8;
    }
    oct[i] = '\0';

    // reverse and print
    printf("Octal: ");
    for (int j = i - 1; j >= 0; j--)
        putchar(oct[j]);
    printf("\n");
}
%}

%%

[0-9]+   {
             int num = atoi(yytext);   // convert string → int
             printf("Decimal: %d\n", num);
             printHex(num);            // manual Hex
             printOctal(num);          // manual Octal
             printf("\n");
          }

\n        ;   // ignore newlines
.         ;   // ignore other characters

%%

int main() {
    printf("Enter a decimal number: ");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
