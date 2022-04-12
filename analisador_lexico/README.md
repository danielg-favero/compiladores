# ANALISADOR LÉXICO

Para executar essa etapa do compilador é preciso ter instalado a ferramenta **FLEX**

*No Linux:*

```bash
sudo apt-get update
sudo apt-get install flex
```



### Rodando a analisador

Providencie um arquivo de entrada em `analisador_lexico/src` e altere o nome do arquivo de entrada dentro do arquivo `analisador_lexico/src/anlex.l`:

```c
char *inputFile = "nome_do_arquivo";
```

#### Primeira forma:

Adiciona o segunite alias nas configurações do seu terminal:

```bash
alias lexicgen="analisador_lexico/scripts/run.sh"
```

Para executar o analisador execute o comando dentro da raiz do projeto:

```bash
lexicgen
```

#### Segunda forma:

Dentro do diretoria raiz do projeto rode no terminal:

```bash
cd analisador_lexico/src
flex anlex.l
gcc lex.yy.c -o output -lft
./output
```

