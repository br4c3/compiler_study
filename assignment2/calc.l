%{
#include "calc.tab.h"
#include <stdlib.h>
%}

%%

[ \t\r]+                                  ;

\n                                       { return '\n'; }

(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))([eE][+-]?[0-9]+)? {
                                            yylval.dval = atof(yytext);
                                            return NUMBER;
                                         }

"+"                                      { return '+'; }
"-"                                      { return '-'; }
"*"                                      { return '*'; }
"/"                                      { return '/'; }
"("                                      { return '('; }
")"                                      { return ')'; }
";"                                      { return ';'; }

.                                        { return yytext[0]; }

%%

int yywrap(void) {
    return 1;
}