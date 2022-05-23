clear
bison -dy ansin.y
flex anlex.l
gcc -o output lex.yy.c y.tab.c -lfl
./output $1
