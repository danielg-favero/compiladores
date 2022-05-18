%{
    #include <stdio.h>
    #include <stdlib.h>

    int yylex();

    int yylval;
    extern FILE *yyin;
%}

%token  PROG 
        START 
        END
        VAR
        ATRIB
        DOUBDOT
        SEMICON
        COL
        IF
        ELIF
        THEN
        WHILE
        DO
        INT
        FLOAT
        BOOL
        PLUS
        MULT
        MINUS
        DIV
        NUM
        TRUE
        FALSE
        NOT
        READ
        WRITE
        OPPAR
        CLOPAR
        EQ
        LTHAN
        GTHAN
        LEQTHAN
        GEQTHAN
        DIFF
        OR
        AND
        ID
        ERROR
%right NOT
%left MULT DIV
%left MINUS PLUS
%left LTHAN GTHAN LEQTHAN GEQTHAN
%left EQ DIFF
%left TRUE FALSE
%right ATRIB

/* GLC DA LINGUAGEM SMALL L */
%%
P : PROG IDENT SEMICON B;                               ;
B : VAR D START CS END;
D : NV DOUBDOT T SEMICON | NV DOUBDOT T SEMICON D;
NV : IDENT | IDENT COL NV;
T : INT | FLOAT | BOOL;
CS : C | C SEMICON CS;
C : A | I | F | R | W;
A : IDENT ATRIB E;
I : IF E THEN CS | IF E THEN CS ELIF CS;
F : WHILE E DO CS;
R : READ OPPAR IDENT CLOPAR;
W : WRITE OPPAR IDENT CLOPAR;
E : S | S RO S;
RO : DIFF | EQ | LTHAN | GTHAN | LEQTHAN | GEQTHAN;
S : TE O TE | TE;
O : PLUS | MINUS | OR;
TE : FA | FA OP FA;
OP : MULT | DIV | AND;
FA : IDENT | N | OPPAR E CLOPAR | TRUE | FALSE | NOT FA;
IDENT : ID;
N : NUM;   
%%

int main(int argc, char *argv[]){
    char *inputFile = argv[1];

    FILE *file = fopen(inputFile, "r");

    if(!file){
        printf("\n\n*\033[0;31m\033[1m 📂 ARQUIVO '%s' NÃO ENCONTRADO\n\n", inputFile);
        return -1;
    }

    yyin = file;

    yyparse();
    return 0;
}

void yyerror(const char *s){ printf("\nERROR: %s\n", s); }
int yywrap(){ return 1; }