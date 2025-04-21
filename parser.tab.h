
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     VOID = 258,
     MAIN = 259,
     INT = 260,
     FLOAT = 261,
     CHAR = 262,
     RETURN = 263,
     INCLUDE = 264,
     OPEN_PARENTHESES = 265,
     CLOSE_PARENTHESES = 266,
     OPEN_CURLY = 267,
     CLOSE_CURLY = 268,
     SEMICOLON = 269,
     COLON = 270,
     NUMBER = 271,
     FLOAT_NUM = 272,
     CHARACTER = 273,
     STRING = 274,
     PRINTF = 275,
     COMMA = 276,
     AMPERSEND = 277,
     SCANF = 278,
     IF = 279,
     ELSE = 280,
     FOR = 281,
     DO = 282,
     WHILE = 283,
     SWITCH = 284,
     CASE = 285,
     BREAK = 286,
     DEFAULT = 287,
     IDENTIFIER = 288,
     ASSIGN = 289,
     LE = 290,
     GE = 291,
     EQ = 292,
     NE = 293,
     LT = 294,
     GT = 295,
     AND = 296,
     OR = 297,
     ADD = 298,
     SUBTRACT = 299,
     MULTIPLY = 300,
     DIVIDE = 301,
     TRUE = 302,
     FALSE = 303,
     UNARY = 304,
     LINE = 305
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 42 "parser.y"

    struct varName{
        char name[50];
        struct node *nd;
    }ndObj;

    struct varName2{
        char name[50];
        struct node *nd;
        char type[5];
    }ndObj2;



/* Line 1676 of yacc.c  */
#line 117 "parser.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


