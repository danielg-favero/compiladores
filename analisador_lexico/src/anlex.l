%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "./utils/countCharacter/countCharacter.c"
    #include "y.tab.h"
    extern int yylval;

    int line = 1;
    int errors = 0;
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

"programa"                       { yylval = yytext[0]; return PROG; }
"inicio"                         { yylval = yytext[0]; return START; }
"fim"                            { yylval = yytext[0]; return END; }

"var"                            { yylval = yytext[0]; return VAR; }
":="                             { yylval = yytext[0]; return ATRIB; }
":"                              { yylval = yytext[0]; return DOUBDOT; }
";"                              { yylval = yytext[0]; return SEMICON; }
","                              { yylval = yytext[0]; return COL; }

"se"                             { yylval = yytext[0]; return IF; }
"senao"                          { yylval = yytext[0]; return ELIF; }
"entao"                          { yylval = yytext[0]; return THEN; }

"enquanto"                       { yylval = yytext[0]; return WHILE; }
"faca"                           { yylval = yytext[0]; return DO; }

"inteiro"                        { yylval = yytext[0]; return INT; }
"real"                           { yylval = yytext[0]; return FLOAT; }
"booleano"                       { yylval = yytext[0]; return BOOL; }

"+"                              { yylval = yytext[0]; return PLUS; }
"*"                              { yylval = yytext[0]; return MULT; }
"-"                              { yylval = yytext[0]; return MINUS; }
"div"                            { yylval = yytext[0]; return DIV; }

{natural}                        { yylval = yytext[0]; return NUM; }
{inteiro}                        { yylval = yytext[0]; return NUM; }
{real}                           { yylval = yytext[0]; return NUM; }
"verdadeiro"                     { yylval = yytext[0]; return TRUE; }
"falso"                          { yylval = yytext[0]; return FALSE; }
"nao"                            { yylval = yytext[0]; return NOT; }

"leia"                           { yylval = yytext[0]; return READ; }
"escreva"                        { yylval = yytext[0]; return WRITE; }
"("                              { yylval = yytext[0]; return OPPAR; }
")"                              { yylval = yytext[0]; return CLOPAR; }

"="                              { yylval = yytext[0]; return EQ; }
"<"                              { yylval = yytext[0]; return LTHAN; }
">"                              { yylval = yytext[0]; return GTHAN; }
"<="                             { yylval = yytext[0]; return LEQTHAN; }
">="                             { yylval = yytext[0]; return GEQTHAN; }
"<>"                             { yylval = yytext[0]; return DIFF; }
"ou"                             { yylval = yytext[0]; return OR; }
"e"                              { yylval = yytext[0]; return AND; }

{id}                             { yylval = yytext[0]; return ID; }

.                                { errors++; yylval = yytext[0]; return ERROR; }
([0-9]*[a-zA-Z_]+[0-9]*)+        { errors++; yylval = yytext[0]; return ERROR; }
{id}[^(\n\t[:space:])]+                { errors++; yylval = yytext[0]; return ERROR; }
%%

/* int main(int argc, char *argv[]){
    char *inputFile = argv[1];

    FILE *file = fopen(inputFile, "r");

    if(!file){
        printf("\n\n*\033[0;31m\033[1m 📂 ARQUIVO '%s' NÃO ENCONTRADO\n\n", inputFile);
        return -1;
    }

    yyin = file;
    
    printf("\n\n*\033[0;32m\033[1m 🎉 ANÁLISE LÉXICA CONCLUÍDA\n");
    printf("\033[0;37m*\033[0;33m\033[1m ✅ LISTA DE TOKENS GERADA: \033[0;37m \033[0m\n");
    yylex();
    printf("\n*\033[0;31m\033[1m ❌ ERROS LÉXICOS ENCONTRADOS: %d\n\n", errors);

    fclose(file);
} */