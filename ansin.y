%{
    #include <stdio.h>
    #include <stdlib.h>

    extern void yyerror(char const *message);
    extern int yylex(void);
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
programa : PROG id SEMICON bloco                            { printf("PROGRAMA -> programa ID ; BLOCO \n\n\033[0;32m\033[1m🎉 ANÁLISE SINTÁTICA CONCLUÍDA:\033[0;37m \033[0mo código está sintaticamente correto\n\n"); };
bloco : VAR declaracao START comandos END                   { printf("BLOCO -> var DECLARACAO inicio COMANDOS fim \n"); };
declaracao : nome_var DOUBDOT tipo SEMICON                  { printf("DECLARACAO -> nome_var : tipo ; \n"); };                            
             | nome_var DOUBDOT tipo SEMICON declaracao     { printf("DECLARACAO -> nome_var : tipo ; DECLARACAO \n"); };
nome_var : id                                               { printf("NOME_VAR -> ID \n"); };
           | id COL nome_var                                { printf("NOME_VAR -> ID , NOME_VAR \n"); };
tipo : INT                                                  { printf("TIPO -> inteiro \n"); };            
       | FLOAT                                              { printf("TIPO -> real \n"); }; 
       | BOOL                                               { printf("TIPO -> booleano \n"); }; 
comandos : comando                                          { printf("COMANDOS -> COMANDO \n"); };
           | comando SEMICON comandos                       { printf("COMANDOS -> COMANDO ; COMANDOS \n"); };
comando : atribuicao                                        { printf("COMANDO -> ATRIBUICAO \n"); };
          | condicional                                     { printf("COMANDO -> CONDICIONAL \n"); };
          | enquanto                                        { printf("COMANDO -> ENQUANTO \n"); };
          | leitura                                         { printf("COMANDO -> LEITURA \n"); };
          | escrita                                         { printf("COMANDO -> ESCRITA \n"); };
atribuicao : id ATRIB expressao                             { printf("ATRIBUICAO -> ID := EXPRESSAO \n"); };
condicional : IF expressao THEN comandos                    { printf("CONDICIONAL -> se EXPRESSAO entao COMANDOS \n"); };
              | IF expressao THEN comandos ELIF comandos    { printf("CONDICIONAL -> se EXPRESSAO entao COMANDOS senao COMANDOS \n"); };
enquanto : WHILE expressao DO comandos                      { printf("ENQUANTO -> enquanto EXPRESSAO faca COMANDOS \n"); };
leitura : READ OPPAR id CLOPAR                              { printf("LEITURA -> leia ( ID ) \n"); };
escrita : WRITE OPPAR id CLOPAR                             { printf("ESCRITA -> escreva ( ID ) \n"); };
expressao : simples                                         { printf("EXPRESSAO -> SIMPLES \n"); };
            | simples op_relacional simples                 { printf("EXPRESSAO -> SIMPLES OP_RELACIONAL SIMPLES \n"); };
op_relacional : DIFF                                        { printf("OP_RELACIONAL -> <> \n"); };
                | EQ                                        { printf("OP_RELACIONAL -> = \n"); };
                | LTHAN                                     { printf("OP_RELACIONAL -> < \n"); };
                | GTHAN                                     { printf("OP_RELACIONAL -> > \n"); };
                | LEQTHAN                                   { printf("OP_RELACIONAL -> <= \n"); };
                | GEQTHAN                                   { printf("OP_RELACIONAL -> => \n"); };
simples : termo operador termo                              { printf("SIMPLES -> TERMO OPERADOR TERMO \n"); };
          | termo                                           { printf("SIMPLES -> TERMO \n"); };
operador : PLUS                                             { printf("OPERADOR -> + \n"); };
           | MINUS                                          { printf("OPERADOR -> - \n"); };
           | OR                                             { printf("OPERADOR -> ou \n"); };
termo : fator                                               { printf("TERMO -> FATOR \n"); };
        | fator op fator                                    { printf("TERMO -> FATOR OP FATOR \n"); };
op : MULT                                                   { printf("OP -> * \n"); };
     | DIV                                                  { printf("OP -> div \n"); };
     | AND                                                  { printf("OP -> e \n"); };
fator : id                                                  { printf("FATOR -> ID \n"); };
        | numero                                            { printf("FATOR -> NUMERO \n"); };
        | OPPAR expressao CLOPAR                            { printf("FATOR -> ( EXPRESSAO ) \n"); };
        | TRUE                                              { printf("FATOR -> verdadeiro \n"); };
        | FALSE                                             { printf("FATOR -> falso \n"); };
        | NOT fator                                         { printf("FATOR -> nao FATOR \n"); };
id : ID                                                     { printf("ID -> id \n"); };
numero : NUM                                                { printf("NUMERO -> numero \n"); };
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
    fclose(yyin);

    return result_code;
}

void yyerror(const char *s){ printf("\n\033[0;31m\033[1m ❌ ERRO: %s\n\n", s); }
int yywrap(){ return 1; }