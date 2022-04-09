%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "./utils/countCharacter/countCharacter.c"
    int line = 1;
    int errors = 0;
%}

/* Declaração de expressões regulares */

id                               [a-zA-Z_][a-zA-Z0-9_]*
natural                          [0-9][1-9]*
digito                           [0-9]*
inteiro                          "-"?{natural}
real                             {inteiro}"."?{digito}?

%%
\n                               { line++; printf("\n"); }
\t                               { /* IGNORAR TABULAÇÃO */ }
[ ]                              { /* IGNORAR ESPAÇOS EM BRANCO */ }
"{".*"}"                         { /* IGNORAR COMENTÁRIO DE UM LINHA */ }
"{"[^}]*"}"                      { line += countCharacter(yytext, '\n'); /* IGNORAR COMENTÁRIO MULTILINHA */ }

"programa"                       { printf("<PROG, %d>", line); }
"inicio"                         { printf("<BEGGIN, %d>", line); }
"fim"                            { printf("<END, %d>", line); }

"var"                            { printf("<VAR, %d>", line); }
":="                             { printf("<ATRIB, %d>", line); }
":"                              { printf("<DOUBDOT, %d>", line); }
"verdadeiro"                     { printf("<TRUE, %d>", line); }
"falso"                          { printf("<FALSE, %d>", line); }
"nao"                            { printf("<NOT, %d>", line); }

";"                              { printf("<SEMICON, %d>", line); }
","                              { printf("<COL, %d>", line); }

"se"                             { printf("<IF, %d>", line); }
"senao"                          { printf("<ELIF, %d>", line); }
"entao"                          { printf("<THEN, %d>", line); }

"enquanto"                       { printf("<WHILE, %d>", line); }
"faca"                           { printf("<DO, %d>", line); }

{natural}                        { printf("<NUM, %d>", line); }                   
{inteiro}                        { printf("<NUM, %d>", line); }
{real}                           { printf("<NUM, %d>", line); }
"inteiro"                        { printf("<INT, %d>", line); }
"real"                           { printf("<FLOAT, %d>", line); }
"booleano"                       { printf("<BOOL, %d>", line); }

"leia"                           { printf("<READ, %d>", line); }
"escreva"                        { printf("<WRITE, %d>", line); }
"("                              { printf("<OPPAR, %d>", line); }
")"                              { printf("<CLOPAR, %d>", line); }

"="                              { printf("<EQ, %d>", line); }
"<"                              { printf("<LTHAN, %d>", line); }
">"                              { printf("<GTHAN, %d>", line); }
"<="                             { printf("<LEQTHAN, %d>", line); }
">="                             { printf("<GEQTHAN, %d>", line); }
"<>"                             { printf("<DIFF, %d>", line); }
"ou"                             { printf("<OR, %d>", line); }

"+"                              { printf("<PLUS, %d>", line); }
"-"                              { printf("<MINUS, %d>", line); }
"*"                              { printf("<MULT, %d>", line); }
"div"                            { printf("<DIV, %d>", line); }
"e"                              { printf("<EXP, %d>", line); }

{id}                             { printf("<ID, %d>", line); }

.                                { errors++; printf("<ERROR, %d>", line); }
([0-9]*[a-zA-Z_]+[0-9]*)+        { errors++; printf("<ERROR, %d>", line); }
%%

int main(){
    FILE *file = fopen("input.dgf", "r");

    if(!file){
        printf("Arquivo não encontrado");
        return -1;
    }

    yyin = file;

    yylex();

    fclose(file);
}