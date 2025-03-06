%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char *yytext; // Declare yytext from Flex
 int yylex(); 
void yyerror(const char *s);




void add(char c);
void insert_type();



struct symbolTableEntry {
    char* identifierName;
    char* identifierType;
    int lineNumber;
} symbolTable[40];

int count = 0;
char type[10];

%}

%token MAIN INT FLOAT CHAR VOID RETURN INCLUDE OPEN_PARENTHESES CLOSE_PARENTHESES OPEN_CURLY CLOSE_CURLY SEMICOLON NUMBER FLOAT_NUM CHARACTER STRING PRINTF
%token COMMA AMPERSEND SCANF IF ELSE FOR IDENTIFIER ASSIGN LE GE EQ NE LT GT AND OR ADD SUBTRACT MULTIPLY DIVIDE TRUE FALSE UNARY


%%

code: headers datatype MAIN OPEN_PARENTHESES CLOSE_PARENTHESES OPEN_CURLY body return_stmt CLOSE_CURLY { printf("Correct code!\n");  add('F');   }
    ;

headers: headers INCLUDE { add('H'); }
        | INCLUDE { add('H'); }
        ;

datatype: INT { insert_type(); }
        | FLOAT { insert_type(); }
        | CHAR { insert_type(); }
        | VOID { insert_type(); }
        ;

value: NUMBER
     | FLOAT_NUM
     | CHARACTER
     | IDENTIFIER
     ;

body: PRINTF OPEN_PARENTHESES STRING CLOSE_PARENTHESES SEMICOLON
    | SCANF OPEN_PARENTHESES STRING COMMA AMPERSEND IDENTIFIER CLOSE_PARENTHESES SEMICOLON
    | IF OPEN_PARENTHESES condition CLOSE_PARENTHESES OPEN_CURLY body CLOSE_CURLY else
    | FOR OPEN_PARENTHESES statement SEMICOLON condition SEMICOLON statement CLOSE_PARENTHESES OPEN_CURLY body CLOSE_CURLY 
    | statement SEMICOLON
    |
    ;

else: ELSE OPEN_CURLY body CLOSE_CURLY
    |
    ;

statement: datatype IDENTIFIER init { add('V'); }
         | IDENTIFIER ASSIGN expression
         | IDENTIFIER relation_op expression
         | IDENTIFIER UNARY
         | UNARY IDENTIFIER
         |
         ;

init: ASSIGN value
    |
    ;

condition: value relation_op value
         | TRUE
         | FALSE
         |
         ;

expression: expression arithmetic_op expression
          | value
          ; 

arithmetic_op: ADD  
             | SUBTRACT
             | MULTIPLY
             | DIVIDE
             ;

relation_op: LT
            | GT
            | LE
            | GE
            | EQ
            | NE
            ;

return_stmt: RETURN value SEMICOLON ;

       ;
%%

int main() {

    


    yyparse();

    showSymbolTable();
    for (int i = 0; i < count; i++) {
    free(symbolTable[i].identifierName);
    free(symbolTable[i].identifierType);
}


    return 0;
}

void showSymbolTable(){
printf("\n\n");
	printf("\t\t\t\t\t\t\t\t PHASE 1: LEXICAL ANALYSIS \n\n");
	printf("\nSYMBOL   DATATYPE    LINE NUMBER \n");
	printf("_______________________________________\n\n");
	
	for(int i=0; i<count; i++) {
		printf("%s\t%s\t%d\t\n", symbolTable[i].identifierName, symbolTable[i].identifierType, symbolTable[i].lineNumber);

	}
}
void add(char c) {
   printf("Adding to symbol table: %s (Type: %s) at index %d\n", yytext, type, count);

    if (c == 'H') {
        symbolTable[count].identifierName = strdup(yytext);
        symbolTable[count].identifierType = strdup(type);
        symbolTable[count].lineNumber = count; // Assuming countn is a placeholder
   
        count++;
    }
    else if (c == 'K') {
        symbolTable[count].identifierName = strdup(yytext);
        symbolTable[count].identifierType = strdup("N/A");
        symbolTable[count].lineNumber = count;
       
        count++;
    }
    else if (c == 'V') {
        symbolTable[count].identifierName = strdup(yytext);
        symbolTable[count].identifierType = strdup(type);
        symbolTable[count].lineNumber = count;
       
        count++;
    }
    else if (c == 'C') {
        symbolTable[count].identifierName = strdup(yytext);
        symbolTable[count].identifierType = strdup("CONST");
        symbolTable[count].lineNumber = count;
       
        count++;
    }
    else if (c == 'F') {
        symbolTable[count].identifierName = strdup(yytext);
        symbolTable[count].identifierType = strdup(type);
        symbolTable[count].lineNumber = count;
        
        count++;
    }
}

int search(char *type) {
	int i;
	for(i=count-1; i>=0; i--) {
		if(strcmp(symbolTable[i].identifierName, type)==0) {
			return -1;
			break;
		}
	}
	return 0;
}

void insert_type() {
    strcpy(type, yytext);
}

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}
