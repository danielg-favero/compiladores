# ANALISADOR LÉXICO

Para executar essa etapa do compilador é preciso ter instalado a ferramenta **FLEX**

*No Linux:*

```bash
sudo apt-get update
sudo apt-get install flex
```

Em seguida, providencie um arquivo de entrada em `analisador_lexico/src` e altere o nome do arquivo de entrada dentro do arquivo `analisador_lexico/src/anlex.l`:

```c
char *inputFile = "nome_do_arquivo";
```

Adiciona o segunite alias nas configurações do seu terminal:

```bash
alias lexicgen="analisador_lexico/scripts/run.sh"
```

Para executar o analisador execute o comando dentro da raiz do projeto:

```bash
lexicgen
```



### Resultados esperados

1 - Arquivo fonte não encontrado:

![image-20220411163337884](/home/user/.config/Typora/typora-user-images/image-20220411163337884.png)

2 - Execução concluída com sucesso:

![image-20220411163421727](/home/user/.config/Typora/typora-user-images/image-20220411163421727.png)