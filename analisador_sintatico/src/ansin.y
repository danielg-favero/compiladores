%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    extern void yyerror(char const *message);
    extern int yylex(void);
    extern FILE *yyin;
    extern int lexical_errors;
%}

%union {
    struct {
        int val;
        char* lex_val;
    } attr;
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
        <attr>PLUS
        <attr>MULT
        <attr>MINUS
        <attr>DIV
        <attr>NUM
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
        <attr>ID
%right NOT
%left MULT DIV
%left MINUS PLUS
%left LTHAN GTHAN LEQTHAN GEQTHAN
%left EQ DIFF
%left TRUE FALSE
%right ATRIB

%type <attr> numero fator termo simples expressao atribuicao id operador op
/* %type <attr> NUM ID AND DIV MULT OR MINUS PLUS */

%start programa

/* GLC DA LINGUAGEM SMALL L */
%%
programa : PROG id SEMICON bloco                                    { printf("\n\n\033[0;32m\033[1m🎉 ANÁLISE SINTÁTICA CONCLUÍDA:\033[0;37m \033[0mo código está sintaticamente correto\n"); };

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
                                                                        $1.val = $3.val;
                                                                        printf("%s = %d\n", $1.lex_val, $1.val);
                                                                    };

enquanto : 
    WHILE expressao DO comando_combinado                            { };

leitura : 
    READ OPPAR id CLOPAR                                            { };

escrita : 
    WRITE OPPAR id CLOPAR                                           { printf("%s = %d\n", $3.lex_val, $3.val); };

expressao : 
    simples                                                         { $$.val = $1.val; }
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
                                                                        if(strcmp($2.lex_val, "+") == 0){
                                                                            $$.val = $1.val + $3.val;
                                                                        } else if(strcmp($2.lex_val, "-") == 0){
                                                                            $$.val = $1.val - $3.val;
                                                                        }
                                                                    }
    | termo                                                         { $$.val = $1.val; };

operador : 
    PLUS                                                            { }
    | MINUS                                                         { }
    | OR                                                            { };

termo : 
    fator                                                           { $$.val = $1.val; }
    | fator op fator                                                { 
                                                                        if(strcmp($2.lex_val, "*") == 0){
                                                                            $$.val = $1.val * $3.val;
                                                                        } else if(strcmp($2.lex_val, "div") == 0){
                                                                            $$.val = $1.val / $3.val;
                                                                        }
                                                                    };

op : 
    MULT                                                            { }
    | DIV                                                           { }
    | AND                                                           { };

fator : 
    id                                                              { }
    | numero                                                        { $$.val = $1.val; }
    | OPPAR expressao CLOPAR                                        { $$.val = $2.val; }
    | TRUE                                                          { }
    | FALSE                                                         { }
    | NOT fator                                                     { };

id : 
    ID                                                              { $$.lex_val = $1.lex_val; /*printf("%s = %s\n", $$.lex_val, $1.lex_val);*/ };

numero : 
    NUM                                                             { $$.val = $1.val; };
    
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