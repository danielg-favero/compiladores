%{
    #include <stdio.h>
    #include <stdlib.h>

    extern void yyerror(char const *message);
    extern int yylex(void);
    extern FILE *yyin;
    extern int lexical_errors;

    #define YYSTYPE double
%}

%union{
    double val;
    char* lex_val;
}

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
        <val>NUM
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
        <lex_val>ID
%right NOT
%left MULT DIV
%left MINUS PLUS
%left LTHAN GTHAN LEQTHAN GEQTHAN
%left EQ DIFF
%left TRUE FALSE
%right ATRIB

%start programa

/* GLC DA LINGUAGEM SMALL L */
%%
programa : PROG id SEMICON bloco                                    { printf("\n\n\033[0;32m\033[1m🎉 ANÁLISE SINTÁTICA CONCLUÍDA:\033[0;37m \033[0mo código está sintaticamente correto\n"); };

bloco : VAR declaracao START comandos END                           { }

declaracao : 
    nome_var DOUBDOT tipo SEMICON                                   { }
    | nome_var DOUBDOT tipo SEMICON declaracao                      { }

nome_var : 
    id                                                              { }
    | id COL nome_var                                               { }

tipo : 
    INT                                                             { }
    | FLOAT                                                         { }
    | BOOL                                                          { }

comandos : 
    comando                                                         { }
    | comando SEMICON comandos                                      { }

comando: 
    comando_combinado                                               { }
    | comando_aberto                                                { }

comando_combinado :
    IF expressao THEN comando_combinado ELIF comando_combinado      { }
    | atribuicao                                                    { }
    | enquanto                                                      { }
    | leitura                                                       { }
    | escrita                                                       { }

comando_aberto: 
    IF expressao THEN comando                                       { }
    | IF expressao THEN comando_combinado ELIF comando_aberto       { }

atribuicao : 
    id ATRIB expressao                                              { }

enquanto : 
    WHILE expressao DO comando_combinado                            { }

leitura : 
    READ OPPAR id CLOPAR                                            { }

escrita : 
    WRITE OPPAR id CLOPAR                                           { printf("%f", $3); }

expressao : 
    simples                                                         { $$ = $1; }
    | simples op_relacional simples                                 { }

op_relacional : 
    DIFF                                                            { }
    | EQ                                                            { }
    | LTHAN                                                         { }
    | GTHAN                                                         { }
    | LEQTHAN                                                       { }
    | GEQTHAN                                                       { }

simples : 
    termo operador termo                                            { 
                                                                        if($2 == '+') { 
                                                                            $$ = $1 + $2;
                                                                        }
                                                                    }
    | termo                                                         { $$ = $1; }

operador : 
    PLUS                                                            { $$ = $1; }
    | MINUS                                                         { $$ = $1; }
    | OR                                                            { $$ = $1; }

termo : 
    fator                                                           { $$ = $1; }
    | fator op fator                                                { 
                                                                            printf("%f", $2); 
                                                                        if($2 == '*') {
                                                                            $$ = $1 * $2;
                                                                        }
                                                                    }

op : 
    MULT                                                            { $$ = $1; }
    | DIV                                                           { $$ = $1; }
    | AND                                                           { $$ = $1; }

fator : 
    id                                                              { $$ = $1; }
    | numero                                                        { $$ = $1; }
    | OPPAR expressao CLOPAR                                        { $$ = $2; }
    | TRUE                                                          { }
    | FALSE                                                         { }
    | NOT fator                                                     { }

id : 
    ID                                                              { $$ = $1; };

numero : 
    NUM                                                             { $$.val = $1; };
%%

int main(int argc, char *argv[]){
    char *inputFile = argv[1];

    FILE *file = fopen(inputFile, "r");

    if(!file){
        printf("\n\n*\033[0;31m\033[1m 📂 ARQUIVO '%s' NÃO ENCONTRADO\n\n", inputFile);
        return -1;
    }

    yyin = file;

    int result_code = yyparse();
    printf("\n\033[0;31m\033[1m❌ ERROS LÉXICOS ENCONTRADOS: %d\n\n", lexical_errors);
    fclose(yyin);

    return result_code;
}

void yyerror(const char *s){ 
    printf("\n\033[0;31m\033[1m ❌ ERRO: %s\n", s);
}
int yywrap(){ return 1; }