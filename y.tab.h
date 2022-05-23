/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PROG = 258,
    START = 259,
    END = 260,
    VAR = 261,
    ATRIB = 262,
    DOUBDOT = 263,
    SEMICON = 264,
    COL = 265,
    IF = 266,
    ELIF = 267,
    THEN = 268,
    WHILE = 269,
    DO = 270,
    INT = 271,
    FLOAT = 272,
    BOOL = 273,
    PLUS = 274,
    MULT = 275,
    MINUS = 276,
    DIV = 277,
    NUM = 278,
    TRUE = 279,
    FALSE = 280,
    NOT = 281,
    READ = 282,
    WRITE = 283,
    OPPAR = 284,
    CLOPAR = 285,
    EQ = 286,
    LTHAN = 287,
    GTHAN = 288,
    LEQTHAN = 289,
    GEQTHAN = 290,
    DIFF = 291,
    OR = 292,
    AND = 293,
    ID = 294,
    ERROR = 295
  };
#endif
/* Tokens.  */
#define PROG 258
#define START 259
#define END 260
#define VAR 261
#define ATRIB 262
#define DOUBDOT 263
#define SEMICON 264
#define COL 265
#define IF 266
#define ELIF 267
#define THEN 268
#define WHILE 269
#define DO 270
#define INT 271
#define FLOAT 272
#define BOOL 273
#define PLUS 274
#define MULT 275
#define MINUS 276
#define DIV 277
#define NUM 278
#define TRUE 279
#define FALSE 280
#define NOT 281
#define READ 282
#define WRITE 283
#define OPPAR 284
#define CLOPAR 285
#define EQ 286
#define LTHAN 287
#define GTHAN 288
#define LEQTHAN 289
#define GEQTHAN 290
#define DIFF 291
#define OR 292
#define AND 293
#define ID 294
#define ERROR 295

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
