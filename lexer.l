%{

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include"parser.tab.h"

int lineNumber = 1;
int tokenCount = 0;

struct tokenNode{
    char token[50];
    struct tokenNode *next;
};

struct tokenNode *keywords = NULL;
struct tokenNode *identifiers = NULL;
struct tokenNode *constants = NULL;
struct tokenNode *operators = NULL;
struct tokenNode *specialSymbols = NULL;

int searchToken(char *var , struct tokenNode *list){
    struct tokenNode *n = list;

    while(n != NULL){
        if(strcmp(n->token , var) == 0){
            return 1;
        }

        n = n->next;
    }

    return 0;
}

void addToken(char* name , struct tokenNode **list) {
    struct tokenNode* newNode = (struct tokenNode *)malloc(sizeof(struct tokenNode));
    strcpy(newNode->token, name);
    newNode->next = NULL;
    if(!searchToken(name, *list)){

    if (*list == NULL) {
        *list = newNode;
    } else {
        struct tokenNode* temp = *list;
        while (temp->next != NULL) {
            temp = temp->next;
        }
        temp->next = newNode;
    }
    }
}


void printTokens() {
    struct tokenNode* temp = keywords;
    printf("Keywords : \n");
    while (temp != NULL) {
        printf("%s ", temp->token);
        temp = temp->next;
    }
    printf("\n\nIdentifiers : \n");
    temp = identifiers;
   
    while (temp != NULL) {
        printf("%s ", temp->token);
        temp = temp->next;
    }
    printf("\n\nConstants : \n");
    temp = constants;
   
    while (temp != NULL) {
        printf("%s ", temp->token);
        temp = temp->next;
    }
    printf("\n\nOperators : \n");
    temp = operators;
   
    while (temp != NULL) {
        printf("%s ", temp->token);
        temp = temp->next;
    }
    printf("\n\nSpecial Symbols : \n");
    temp = specialSymbols;
   
    while (temp != NULL) {
        printf("%s ", temp->token);
        temp = temp->next;
    }

    printf("\n\nTotal number of tokens : %d\n\n" , tokenCount);
}


%}

alpha [a-zA-Z]
digit [0-9]
unary "++"|"--"

%%
[ \t]+      ;  
"main"                                  { tokenCount++; strcpy(yylval.ndObj.name, (yytext)); return MAIN; }
"int"                                   { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return INT; }
"float"                                 { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return FLOAT; }
"char"                                  { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return CHAR; }
"void"                                  { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return VOID; }
"printf"                                { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return PRINTF; }
"scanf"                                 { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return SCANF; }
"if"                                    { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return IF; }
"else"                                  { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return ELSE; }
"for"                                   { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return FOR; }
"do"                                    { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return DO; }
"while"                                 { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return WHILE; }
"switch"                                { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return SWITCH; }
"case"                                  { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return CASE; }
"break"                                 { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return BREAK; }
"default"                               { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return DEFAULT; }
"true"                                  { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return TRUE; }
"false"                                 { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return FALSE; }
"return"                                { tokenCount++; addToken(yytext, &keywords); strcpy(yylval.ndObj.name, (yytext)); return RETURN; }
{alpha}({alpha}|{digit})*               { tokenCount++; addToken(yytext, &identifiers); strcpy(yylval.ndObj.name, (yytext)); return IDENTIFIER; }
["].*["]                                { tokenCount++; addToken(yytext, &constants); strcpy(yylval.ndObj.name, (yytext)); return STRING; }
^"#include"[ ]*<.+\.h>                  { tokenCount++; addToken(yytext, &constants); strcpy(yylval.ndObj.name, (yytext)); return INCLUDE; }
"("                                     { tokenCount++; addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return OPEN_PARENTHESES; }
")"                                     { tokenCount++; addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return CLOSE_PARENTHESES; }
"{"                                     { tokenCount++; addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return OPEN_CURLY; }
"}"                                     { tokenCount++; addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return CLOSE_CURLY; }
";"                                     { tokenCount++; addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return SEMICOLON; }
":"                                     { tokenCount++; addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return COLON; }
","                                     { tokenCount++; addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return COMMA; }
"="                                     { tokenCount++; addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return ASSIGN; }
"&"                                     { tokenCount++; addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return AMPERSEND; }
"<="                        { tokenCount++; addToken(yytext, &operators); strcpy(yylval.ndObj.name, (yytext));return LE; }
">="                        { tokenCount++; addToken(yytext, &operators); strcpy(yylval.ndObj.name, (yytext)); return GE; }
"=="                        { tokenCount++; addToken(yytext, &operators); strcpy(yylval.ndObj.name, (yytext));return EQ; }
"!="                        { tokenCount++; addToken(yytext, &operators); strcpy(yylval.ndObj.name, (yytext)); return NE; }
">"	                    { tokenCount++; addToken(yytext, &operators); addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return GT; }
"<"	                    { tokenCount++; addToken(yytext, &operators); addToken(yytext, &specialSymbols); strcpy(yylval.ndObj.name, (yytext)); return LT; }
"&&"	                    { tokenCount++; addToken(yytext, &operators); strcpy(yylval.ndObj.name, (yytext)); return AND; }
"||"	                    { tokenCount++; addToken(yytext, &operators); strcpy(yylval.ndObj.name, (yytext)); return OR; }
"+"                         { tokenCount++; addToken(yytext, &operators); strcpy(yylval.ndObj.name, (yytext)); return ADD; }
"-"                         { tokenCount++; addToken(yytext, &operators); strcpy(yylval.ndObj.name, (yytext)); return SUBTRACT; }
"/"                         { tokenCount++; addToken(yytext, &operators); strcpy(yylval.ndObj.name, (yytext)); return DIVIDE; }
"*"                         { tokenCount++; addToken(yytext, &operators); strcpy(yylval.ndObj.name, (yytext)); return MULTIPLY; }
"++"                        { tokenCount++; strcpy(yylval.ndObj.name, (yytext)); return UNARY; }
"--"                        { tokenCount++; strcpy(yylval.ndObj.name, (yytext)); return UNARY; }
[\n]                        { lineNumber++;}
[-]?[0-9]+                              { tokenCount++; addToken(yytext, &constants); strcpy(yylval.ndObj.name, (yytext)); return NUMBER; }
[-]?[0-9]+\.[0-9]{1,6}                  { tokenCount++; addToken(yytext, &constants); strcpy(yylval.ndObj.name, (yytext)); return FLOAT_NUM; }
['].[']                                 { tokenCount++; addToken(yytext, &constants); strcpy(yylval.ndObj.name, (yytext)); return CHARACTER; }
.                                       { return yytext[0]; }
%%


int yywrap(){
    return 1;
}