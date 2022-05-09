%{
#include <stdio.h>

void yyerror(char *c);
int yylex(void);

%}

%token NUM OP EOL
%left OP

%%

S:
  S E EOL { printf("Resultado: %d\n", $2); }
  |
  ;

E: 
  NUM {$$ = $1; printf("Numero %d\n", $1);}
  | E OP E {$$ = $1 + $3; printf("Soma %d + %d = %d\n", $1, $3, $$); }
  ;

%%
void yyerror(char *c) {
 printf("Erro: %s\n", c) ;
}

int main() {
 yyparse();
 return 0;
}

