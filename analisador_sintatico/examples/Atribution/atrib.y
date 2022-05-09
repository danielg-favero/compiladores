%{
#include <stdio.h>
// To avoid warning, we include below definitions:
int yylex();
void yyerror (const char *s);
%}

%token MAIS MENOS MULT DIV NUM ID ATRIB PV ABREPAR FECHAPAR
%left ATRIB // Operator precedence and associativity
%left MAIS MENOS
%left MULT DIV

%%

cmd : ID ATRIB {printf("%c", $1);} expr PV {printf("%c", $2); printf("\n%d\n", $4);}
    ;

expr : expr MAIS termo {$$ = $1 + $3; printf("%c", $2);}
     | expr MENOS termo {$$ = $1 - $3; printf("%c", $2);}
     | termo
     ;

termo : termo MULT fator {$$ = $1 * $3; printf("%c", $2);}
      | termo DIV fator {$$ = $1 / $3; printf("%c", $2);}
      | fator
      ;

fator : ABREPAR expr FECHAPAR {$$ = $2;}
      | NUM {printf("%d", $1);}
      | ID {printf("%c", $1);}
      ;
%%

//#include "lex.yy.c"
int main(){
yyparse();
return(0);
}
void yyerror(const char *s){ printf("\nERROR\n"); }
int yywrap(){ return 1; }
