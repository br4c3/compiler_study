%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylex(void);
extern FILE *yyin;

FILE *fout;

void yyerror(const char *s);
%}

%union {
    double dval;
}

%token <dval> NUMBER
%type <dval> expr term factor

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

program:
      lines
    ;

lines:
      lines line
    | line
    ;

line:
      expr ';' '\n'        { fprintf(fout, "%.10g\n", $1); }
    | expr ';'             { fprintf(fout, "%.10g\n", $1); }
    | error '\n'           { fprintf(fout, "error\n"); yyerrok; }
    | error                { fprintf(fout, "error\n"); yyerrok; }
    ;

expr:
      expr '+' term        { $$ = $1 + $3; }
    | expr '-' term        { $$ = $1 - $3; }
    | term                 { $$ = $1; }
    ;

term:
      term '*' factor      { $$ = $1 * $3; }
    | term '/' factor      {
                              if ($3 == 0) {
                                  fprintf(fout, "error\n");
                                  YYERROR;
                              } else {
                                  $$ = $1 / $3;
                              }
                           }
    | factor               { $$ = $1; }
    ;

factor:
      NUMBER               { $$ = $1; }
    | '-' factor %prec UMINUS { $$ = -$2; }
    | '(' expr ')'         { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    // Error handling
}

int main(void) {
    yyin = fopen("input.txt", "r");
    if (!yyin) {
        printf("Cannot open input.txt\n");
        return 1;
    }

    fout = fopen("output.txt", "w");
    if (!fout) {
        printf("Cannot open output.txt\n");
        fclose(yyin);
        return 1;
    }

    yyparse();

    fclose(yyin);
    fclose(fout);

    return 0;
}