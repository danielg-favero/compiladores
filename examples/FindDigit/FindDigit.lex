%{
    #include <stdio.h>
%}

%%
[0-9] { printf("digito encontrado!"); }
%%

int main() {
    FILE *file = fopen("../example.c", "r");

    if(!file){
        printf("Arquivo não encontrado");
        return -1;
    }

    yyin = file;

    while(yylex());

    fclose(file);
}