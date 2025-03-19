%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char *yytext; // Declare yytext from Flex
extern FILE *yyin;
int yylex(); 
void yyerror(const char *s);

void add(char c);
void insert_type();
void printST();

struct symbolTableEntry {
    char* identifierName;
    char* identifierType;
    int lineNumber;

    struct symbolTableEntry *next;
};

struct symbolTableEntry *symbolTable = NULL;

int count = 0;
char type[10];

%}

%token MAIN INT FLOAT CHAR VOID RETURN INCLUDE OPEN_PARENTHESES CLOSE_PARENTHESES OPEN_CURLY CLOSE_CURLY SEMICOLON NUMBER FLOAT_NUM CHARACTER STRING PRINTF
%token COMMA AMPERSEND SCANF IF ELSE FOR IDENTIFIER ASSIGN LE GE EQ NE LT GT AND OR ADD SUBTRACT MULTIPLY DIVIDE TRUE FALSE UNARY


%%

code: headers datatype MAIN { add('F'); } OPEN_PARENTHESES CLOSE_PARENTHESES OPEN_CURLY body return_stmt CLOSE_CURLY { printf("Correct code!\n"); }
    ;

headers: INCLUDE { add('H'); }
       | headers INCLUDE { add('H'); }
       ;

datatype: INT { strcpy(type, "int"); }
        | FLOAT { strcpy(type, "float"); }
        | CHAR { strcpy(type, "char"); }
        | VOID { strcpy(type, "void"); }
        ;


value: NUMBER { add('C'); }
     | FLOAT_NUM { add('C'); }
     | CHARACTER { add('C'); }
     | IDENTIFIER { printf("DEBUG: Adding variable %s with type %s\n", yytext, type);
 add('V'); }  // Change from 'C' to 'V'
     ;



body: PRINTF  { add('K'); } OPEN_PARENTHESES STRING CLOSE_PARENTHESES SEMICOLON
    | SCANF  { add('K'); } OPEN_PARENTHESES STRING COMMA AMPERSEND IDENTIFIER CLOSE_PARENTHESES SEMICOLON
    | IF  { add('K'); } OPEN_PARENTHESES condition CLOSE_PARENTHESES OPEN_CURLY body CLOSE_CURLY else
    | FOR  { add('K'); } OPEN_PARENTHESES statement SEMICOLON condition SEMICOLON statement CLOSE_PARENTHESES OPEN_CURLY body CLOSE_CURLY 
    | RETURN { add('K'); } value SEMICOLON  // Fix: Ensure RETURN IS Seperated
    | statement SEMICOLON
    ;



else: ELSE  { add('K'); } OPEN_CURLY body CLOSE_CURLY
    | /* empty */
    ;

statement: datatype IDENTIFIER init { insert_type(); add('V'); }
         | IDENTIFIER ASSIGN expression
         | IDENTIFIER relation_op expression
         | IDENTIFIER UNARY
         | UNARY IDENTIFIER
         ;



init: ASSIGN value
    | /* empty */
    ;

condition: value relation_op value
         | TRUE { add('K'); }
         | FALSE { add('K'); }
         | /* empty */
         ;

expression: value
          | expression arithmetic_op value  // Right recursion for better parsing
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


return_stmt: RETURN  { add('K'); }  value SEMICOLON ;

       ;
%%

int main() {

    yyin = fopen("input.txt", "r");
    if (!yyin) {
        perror("Error opening file");
        return 1;
    }


    yyparse();
    printST();
    fclose(yyin);
    return 0;
}


void add(char c) {

    struct symbolTableEntry *n = (struct symbolTableEntry *)malloc(sizeof(struct symbolTableEntry));

    if (c == 'H') {
        n->identifierName = strdup(yytext);
        n->identifierType = strdup("header");
        n->lineNumber = count; // Assuming countn is a placeholder
        count++;
    }
    else if (c == 'K') {
        n->identifierName = strdup(yytext);
        n->identifierType = strdup("N/A");
        n->lineNumber = count; // Assuming countn is a placeholder
    
        count++;
    }
    else if (c == 'V') {

        n->identifierName = strdup(yytext);
        n->identifierType = strdup(type);
        n->lineNumber = count; // Assuming countn is a placeholder

        count++;
    }
    else if (c == 'C') {

        n->identifierName = strdup(yytext);
        n->identifierType = strdup("CONST");
        n->lineNumber = count; // Assuming countn is a placeholder
       
        count++;
    }
    else if (c == 'F') {

        n->identifierName = strdup(yytext);
        n->identifierType = strdup(type);
        n->lineNumber = count; // Assuming countn is a placeholder
        
        count++;
    }

    n->next = symbolTable;
    symbolTable = n;
}


void printST() {
    struct symbolTableEntry *temp = symbolTable;

    if (temp == NULL) {
        printf("Symbol table is empty.\n");
        return;
    }

    // Print table header
    printf("\nPHASE 1: LEXICAL ANALYSIS \n\n");
    printf("+----------------------+----------------------+--------------+\n");
    printf("| %-20s | %-20s | %-12s |\n", "SYMBOL", "DATATYPE", "LINE NUMBER");
    printf("+----------------------+----------------------+--------------+\n");

    // Print table contents
    while (temp != NULL) {
        printf("| %-20s | %-20s | %-12d |\n", temp->identifierName, temp->identifierType, temp->lineNumber);
        temp = temp->next;
    }

    // Print table footer
    printf("+----------------------+----------------------+--------------+\n");
}



void insert_type() {
    strcpy(type, yytext);
}

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}