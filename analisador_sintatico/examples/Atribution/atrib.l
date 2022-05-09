%{
#include "y.tab.h"
#include <stdlib.h>
extern int yylval;
%}

digito [0-9]
letra [a-zA-Z]
%%
"+" {yylval = yytext[0]; return MAIS;}
"-" {yylval = yytext[0]; return MENOS;}
"*" {yylval = yytext[0]; return MULT;}
"/" {yylval = yytext[0]; return DIV;}
"=" {yylval = yytext[0]; return ATRIB;}
";" {return PV;}
"(" {return ABREPAR;}
")" {return FECHAPAR;}
{digito} {yylval = atoi(yytext); return NUM;}
{letra} {yylval = yytext[0]; return ID;}
%%
