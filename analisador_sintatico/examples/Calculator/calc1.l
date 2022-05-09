%option noyywrap
%{
#include <stdlib.h>

void yyerror(char *c);
#include "y.tab.h"
%}

%%
[0-9]+ {
   yylval = atoi(yytext);
   return NUM;
  }

\n {return EOL; }

[+] {return OP;}

[[:space:]]+ ;
. { yyerror("Token desconhecido\n"); }
%%

