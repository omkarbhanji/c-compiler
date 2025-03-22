%{

#include<stdio.h>
#include"parser.tab.h"

int lineNumber = 1;

%}

alpha [a-zA-Z]
digit [0-9]
unary "++"|"--"

%%
[ \t]+      ;  
"main"                                  { return MAIN; }
"int"                                   { return INT; }
"float"                                 { return FLOAT; }
"char"                                  { return CHAR; }
"void"                                  { return VOID; }
"printf"                                { return PRINTF; }
"scanf"                                 { return SCANF; }
"if"                                    { return IF; }
"else"                                  { return ELSE; }
"for"                                   {  return FOR; }
"true"                                  {  return TRUE; }
"false"                                 {  return FALSE; }
"return"                                { return RETURN; }
{alpha}({alpha}|{digit})*               { return IDENTIFIER; }
["].*["]                                { return STRING; }
^"#include"[ ]*<.+\.h>                  { return INCLUDE; }
"("                                     { return OPEN_PARENTHESES; }
")"                                     { return CLOSE_PARENTHESES; }
"{"                                     { return OPEN_CURLY; }
"}"                                     { return CLOSE_CURLY; }
";"                                     { return SEMICOLON; }
","                                     { return COMMA; }
"="                                     { return ASSIGN; }
"&"                                     { return AMPERSEND; }
"<="                        { return LE; }
">="                        { return GE; }
"=="                        { return EQ; }
"!="                        { return NE; }
">"	                    { return GT; }
"<"	                    { return LT; }
"&&"	                    { return AND; }
"||"	                    { return OR; }
"+"                         { return ADD; }
"-"                         { return SUBTRACT; }
"/"                         { return DIVIDE; }
"*"                         { return MULTIPLY; }
"++"                        { return UNARY; }
"--"                        { return UNARY; }
[\n]                        { lineNumber++; }
[-]?[0-9]+                              { return NUMBER; }
[-]?[0-9]+\.[0-9]{1,6}                  { return FLOAT_NUM; }
['].[']                                 { return CHARACTER; }
.                                       { return yytext[0]; }
%%


int yywrap(){
    return 1;
}