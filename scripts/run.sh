clear

cd analisador_sintatico/src
bison -dy ansin.y
mv y.tab.h ../../analisador_lexico/src
mv y.tab.c ../../analisador_lexico/src

cd ../../analisador_lexico/src
flex anlex.l
gcc -o output ../../memory/memory.c lex.yy.c y.tab.c -lfl
mv output ../../

cd ../../
./output $1
