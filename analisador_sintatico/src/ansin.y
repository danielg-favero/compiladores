%{
    #include "../../memory/memory.h"

    extern void yyerror(char const *message);
    extern int yylex(void);
    extern FILE *yyin;
    extern int lexical_errors;

    Memory *memory;
%}

%union {
    int val;
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
%left ATRIB
%left PLUS MINUS
%left MULT DIV
%left LTHAN GTHAN LEQTHAN GEQTHAN
%left EQ DIFF
%left TRUE FALSE
%right NOT

%type <val> numero fator termo simples expressao id

%start programa

/* GLC DA LINGUAGEM SMALL L */
%%
programa : PROG id SEMICON bloco                                    { 
                                                                        printf("\n\n\033[0;32m\033[1m🎉 ANÁLISE SINTÁTICA CONCLUÍDA:\033[0;37m \033[0mo código está sintaticamente correto\n");
                                                                        clearMemory(memory);
                                                                    };

bloco : VAR declaracao START comandos END                           { };

declaracao : 
    nome_var DOUBDOT tipo SEMICON                                   { }
    | nome_var DOUBDOT tipo SEMICON declaracao                      { };

nome_var : 
    id                                                              { }
    | id COL nome_var                                               { };

tipo : 
    INT                                                             { }
    | FLOAT                                                         { }
    | BOOL                                                          { };

comandos : 
    comando                                                         { }
    | comando SEMICON comandos                                      { };

comando: 
    comando_combinado                                               { }
    | comando_aberto                                                { };

comando_combinado :
    IF expressao THEN comando_combinado ELIF comando_combinado      { }
    | atribuicao                                                    { }
    | enquanto                                                      { }
    | leitura                                                       { }
    | escrita                                                       { };

comando_aberto: 
    IF expressao THEN comando                                       { }
    | IF expressao THEN comando_combinado ELIF comando_aberto       { };

atribuicao : 
    id ATRIB expressao                                              {
                                                                       if(isEmpty(memory)){
                                                                         memory = createMemory();
                                                                       }
                                                                       assignID(memory, $<lex_val>1, $<val>3);
                                                                    };

enquanto : 
    WHILE expressao DO comando_combinado                            { };

leitura : 
    READ OPPAR id CLOPAR                                            { };

escrita : 
    WRITE OPPAR id CLOPAR                                           {
                                                                        printf("%d\n", getID(memory, $<lex_val>3));
                                                                    };

expressao : 
    simples                                                         {
                                                                        $<val>$ = $<val>1;
                                                                    }
    | simples op_relacional simples                                 { };

op_relacional : 
    DIFF                                                            { }
    | EQ                                                            { }
    | LTHAN                                                         { }
    | GTHAN                                                         { }
    | LEQTHAN                                                       { }
    | GEQTHAN                                                       { };

simples : 
    termo operador termo                                            {
                                                                        if(strcmp($<lex_val>2, "+") == 0) {
                                                                            $<val>$ =  $<val>1 + $<val>3;
                                                                        } else if(strcmp($<lex_val>2, "-") == 0) {
                                                                            $<val>$ =  $<val>1 - $<val>3;
                                                                        }
                                                                    }
    | termo                                                         {
                                                                        $<val>$ = $<val>1;
                                                                    };

operador : 
    PLUS                                                            { }
    | MINUS                                                         { }
    | OR                                                            { };

termo : 
    fator                                                           {
                                                                        $<val>$ = $<val>1;
                                                                    }
    | fator op fator                                                { 
                                                                        if(strcmp($<lex_val>2, "*") == 0) {
                                                                            $<val>$ =  $<val>1 * $<val>3;
                                                                        } else if(strcmp($<lex_val>2, "div") == 0) {
                                                                            $<val>$ =  $<val>1 / $<val>3;
                                                                        }
                                                                    };

op : 
    MULT                                                            { }
    | DIV                                                           { }
    | AND                                                           { };

fator : 
    id                                                              { 
                                                                        $<val>$ = getID(memory, $<lex_val>1);
                                                                    }
    | numero                                                        {
                                                                        $<val>$ = $<val>1;
                                                                    }
    | OPPAR expressao CLOPAR                                        {
                                                                        $<val>$ = $<val>2;
                                                                    }
    | TRUE                                                          { }
    | FALSE                                                         { }
    | NOT fator                                                     { };

id : 
    ID                                                              { };

numero : 
    NUM                                                             {
                                                                        $<val>$ = $<val>1;
                                                                    };
    
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