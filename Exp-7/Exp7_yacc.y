%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char * s);
int yylex(void);
%}

%token NUMBER

%%
program:
        program expr '\n' {printf("Result: %d\n",$2);}
        | /* empty */
        ;

expr:
     NUMBER         { $$ = $1; }
    | expr expr '+'   { $$ = $1 + $2; }
    | expr expr '-'   { $$ = $1 - $2; }
    | expr expr '*'   { $$ = $1 * $2; }
    | expr expr '/'   { $$ = $1 / $2; }

%%

int main(void){
    printf("Enter postfix expression (one per line):\n");
    yyparse();
    return 0;
}

void yyerror(char *s){
    fprintf(stderr,"Error: %s\n", s);
}
