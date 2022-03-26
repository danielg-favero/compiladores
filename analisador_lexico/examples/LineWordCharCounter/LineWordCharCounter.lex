%{
    int chars = 0;
    int words = 0;
    int lines = 0;
%}

%%
[a-zA-Z]+   { words++; chars += strlen(yytext); }
\n          { chars++; lines++; }
.           { chars++; }
%%

int main(){
    FILE *file = fopen("../example.c", "r");

    if(!file){
        printf("Arquivo não encontrado");
        return -1;
    }

    yyin = file;

    while(yylex());
    printf("%8d%8d%8d\n", lines, words, chars);

    fclose(file);
}