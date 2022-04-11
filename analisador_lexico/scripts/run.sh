clear
cd analisador_lexico/src
flex anlex.l
gcc lex.yy.c -o output -lfl
./output
cd ../..