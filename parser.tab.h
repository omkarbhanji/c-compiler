
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
     MAIN = 258,
     INT = 259,
     FLOAT = 260,
     CHAR = 261,
     VOID = 262,
     RETURN = 263,
     INCLUDE = 264,
     OPEN_PARENTHESES = 265,
     CLOSE_PARENTHESES = 266,
     OPEN_CURLY = 267,
     CLOSE_CURLY = 268,
     SEMICOLON = 269,
     NUMBER = 270,
     FLOAT_NUM = 271,
     CHARACTER = 272,
     STRING = 273,
     PRINTF = 274,
     COMMA = 275,
     AMPERSEND = 276,
     SCANF = 277,
     IF = 278,
     ELSE = 279,
     FOR = 280,
     IDENTIFIER = 281,
     ASSIGN = 282,
     LE = 283,
     GE = 284,
     EQ = 285,
     NE = 286,
     LT = 287,
     GT = 288,
     AND = 289,
     OR = 290,
     ADD = 291,
     SUBTRACT = 292,
     MULTIPLY = 293,
     DIVIDE = 294,
     TRUE = 295,
     FALSE = 296,
     UNARY = 297
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


