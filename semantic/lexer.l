%{

#include<stdio.h>
#include<string.h>
#include"parser.tab.h"

int lineNumber = 1;

%}

alpha [a-zA-Z]
digit [0-9]
unary "++"|"--"

%%
[ \t]+      ;  
"main"                                  { strcpy(yylval.ndObj.name, (yytext)); return MAIN; }
"int"                                   { strcpy(yylval.ndObj.name, (yytext)); return INT; }
"float"                                 { strcpy(yylval.ndObj.name, (yytext)); return FLOAT; }
"char"                                  { strcpy(yylval.ndObj.name, (yytext)); return CHAR; }
"void"                                  { strcpy(yylval.ndObj.name, (yytext)); return VOID; }
"printf"                                { strcpy(yylval.ndObj.name, (yytext)); return PRINTF; }
"scanf"                                 { strcpy(yylval.ndObj.name, (yytext)); return SCANF; }
"if"                                    { strcpy(yylval.ndObj.name, (yytext)); return IF; }
"else"                                  { strcpy(yylval.ndObj.name, (yytext)); return ELSE; }
"for"                                   { strcpy(yylval.ndObj.name, (yytext)); return FOR; }
"true"                                  { strcpy(yylval.ndObj.name, (yytext)); return TRUE; }
"false"                                 { strcpy(yylval.ndObj.name, (yytext)); return FALSE; }
"return"                                { strcpy(yylval.ndObj.name, (yytext)); return RETURN; }
{alpha}({alpha}|{digit})*               { strcpy(yylval.ndObj.name, (yytext)); return IDENTIFIER; }
["].*["]                                { strcpy(yylval.ndObj.name, (yytext)); return STRING; }
^"#include"[ ]*<.+\.h>                  { strcpy(yylval.ndObj.name, (yytext)); return INCLUDE; }
"("                                     { strcpy(yylval.ndObj.name, (yytext)); return OPEN_PARENTHESES; }
")"                                     { strcpy(yylval.ndObj.name, (yytext)); return CLOSE_PARENTHESES; }
"{"                                     { strcpy(yylval.ndObj.name, (yytext)); return OPEN_CURLY; }
"}"                                     { strcpy(yylval.ndObj.name, (yytext)); return CLOSE_CURLY; }
";"                                     { strcpy(yylval.ndObj.name, (yytext)); return SEMICOLON; }
","                                     { strcpy(yylval.ndObj.name, (yytext)); return COMMA; }
"="                                     { strcpy(yylval.ndObj.name, (yytext)); return ASSIGN; }
"&"                                     { strcpy(yylval.ndObj.name, (yytext)); return AMPERSEND; }
"<="                        { strcpy(yylval.ndObj.name, (yytext));return LE; }
">="                        { strcpy(yylval.ndObj.name, (yytext)); return GE; }
"=="                        { strcpy(yylval.ndObj.name, (yytext));return EQ; }
"!="                        { strcpy(yylval.ndObj.name, (yytext)); return NE; }
">"	                    { strcpy(yylval.ndObj.name, (yytext)); return GT; }
"<"	                    { strcpy(yylval.ndObj.name, (yytext)); return LT; }
"&&"	                    { strcpy(yylval.ndObj.name, (yytext)); return AND; }
"||"	                    { strcpy(yylval.ndObj.name, (yytext)); return OR; }
"+"                         { strcpy(yylval.ndObj.name, (yytext)); return ADD; }
"-"                         { strcpy(yylval.ndObj.name, (yytext)); return SUBTRACT; }
"/"                         { strcpy(yylval.ndObj.name, (yytext)); return DIVIDE; }
"*"                         { strcpy(yylval.ndObj.name, (yytext)); return MULTIPLY; }
"++"                        { strcpy(yylval.ndObj.name, (yytext)); return UNARY; }
"--"                        { strcpy(yylval.ndObj.name, (yytext)); return UNARY; }
[\n]                        { lineNumber++; }
[-]?[0-9]+                              { strcpy(yylval.ndObj.name, (yytext)); return NUMBER; }
[-]?[0-9]+\.[0-9]{1,6}                  { strcpy(yylval.ndObj.name, (yytext)); return FLOAT_NUM; }
['].[']                                 { strcpy(yylval.ndObj.name, (yytext)); return CHARACTER; }
.                                       { return yytext[0]; }
%%


int yywrap(){
    return 1;
}