%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "./utils/countCharacter/countCharacter.c"
    #include "y.tab.h"
    extern YYSTYPE yylval;

    int line = 1;
    int lexical_errors = 0;
%}

/* Declaração de expressões regulares */

id                               [a-zA-Z_][a-zA-Z0-9_]*
natural                          [1-9][0-9]*
digito                           [0-9]*
inteiro                          "-"?{digito}
real                             {inteiro}"."?{digito}?

/* Validação das expressões regulares */

%%
\n                               { line++; }
\t                               { /* IGNORAR TABULAÇÃO */ }
[[:space:]]                      { /* IGNORAR ESPAÇOS EM BRANCO */ }
"{".*"}"                         { /* IGNORAR COMENTÁRIO DE UM LINHA */ }
"{"[^}]*"}"                      { line += countCharacter(yytext, '\n'); /* IGNORAR COMENTÁRIO MULTILINHA */ }

"programa"                       { return PROG; }
"inicio"                         { return START; }
"fim"                            { return END; }

"var"                            { return VAR; }
":="                             { return ATRIB; }
":"                              { return DOUBDOT; }
";"                              { return SEMICON; }
","                              { return COL; }

"se"                             { return IF; }
"senao"                          { return ELIF; }
"entao"                          { return THEN; }

"enquanto"                       { return WHILE; }
"faca"                           { return DO; }

"inteiro"                        { return INT; }
"real"                           { return FLOAT; }
"booleano"                       { return BOOL; }

"+"                              { yylval.attr.lex_val = strdup(yytext); return PLUS; }
"*"                              { yylval.attr.lex_val = strdup(yytext); return MULT; }
"-"                              { yylval.attr.lex_val = strdup(yytext); return MINUS; }
"div"                            { yylval.attr.lex_val = strdup(yytext); return DIV; }

{natural}                        { yylval.attr.val = atoi(yytext); return NUM; }
{inteiro}                        { yylval.attr.val = atoi(yytext); return NUM; }
{real}                           { yylval.attr.val = atoi(yytext); return NUM; }
"verdadeiro"                     { return TRUE; }
"falso"                          { return FALSE; }
"nao"                            { return NOT; }

"leia"                           { return READ; }
"escreva"                        { return WRITE; }
"("                              { return OPPAR; }
")"                              { return CLOPAR; }

"="                              { return EQ; }
"<"                              { return LTHAN; }
">"                              { return GTHAN; }
"<="                             { return LEQTHAN; }
">="                             { return GEQTHAN; }
"<>"                             { return DIFF; }
"ou"                             { return OR; }
"e"                              { return AND; }

{id}                             { yylval.attr.lex_val = strdup(yytext); return ID; }

.                                { lexical_errors++; }
([0-9]*[a-zA-Z_]+[0-9]*)+        { lexical_errors++; }
{id}[^(\n\t[:space:])]+          { lexical_errors++; }
%%