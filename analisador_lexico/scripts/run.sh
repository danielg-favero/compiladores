cd analisador_lexico/src
flex index.l
gcc lex.yy.c -o output -lfl
./output
cd ../..