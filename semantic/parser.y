 %{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern char *yytext; // Declare yytext from Flex
extern FILE *yyin;
int yylex(); 
void yyerror(const char *s);

void addSymbol(char c);
void insertDataType();
void printST();
void checkDeclaration(char *var);
void checkReturnType(char *val, char *type);
char *getDataType(char *var);


struct symbolTableEntry {
    char* identifierName;
    char* identifierType;
    char* dataType;
    int lineNum;

    struct symbolTableEntry *next;
};

struct symbolTableEntry *symbolTable = NULL;

int count = 0;
char type[10];
char errors[20][50];
int errorCount = 0;

extern int lineNumber;

%}

%union {
    struct varName{
        char name[50];
        struct node *nd;
    }ndObj;

    struct varName2{
        char name[50];
        struct node *nd;
        char type[5];
    }ndObj2;
}
%token VOID
%token <ndObj> MAIN INT FLOAT CHAR  RETURN INCLUDE OPEN_PARENTHESES CLOSE_PARENTHESES OPEN_CURLY CLOSE_CURLY SEMICOLON NUMBER FLOAT_NUM CHARACTER STRING PRINTF
%token <ndObj> COMMA AMPERSEND SCANF IF ELSE FOR IDENTIFIER ASSIGN LE GE EQ NE LT GT AND OR ADD SUBTRACT MULTIPLY DIVIDE TRUE FALSE UNARY

%type <ndObj2> value

%%

program: headers datatype MAIN { addSymbol('F'); }OPEN_PARENTHESES CLOSE_PARENTHESES OPEN_CURLY body return_stmt CLOSE_CURLY { printf("Correct code!\n"); }
    ;

headers: headers INCLUDE { addSymbol('H'); }
       | INCLUDE { addSymbol('H'); }
       ;


datatype: INT { insertDataType(); }
        | FLOAT { insertDataType(); }
        | CHAR { insertDataType(); }
        | VOID { insertDataType(); }
        ;

body: code_list
    ;

code_list: 
         | code_list code
         ;


code : PRINTF OPEN_PARENTHESES STRING CLOSE_PARENTHESES SEMICOLON
      | IF OPEN_PARENTHESES condition CLOSE_PARENTHESES OPEN_CURLY code_list CLOSE_CURLY else
      | FOR OPEN_PARENTHESES for_initialization SEMICOLON condition SEMICOLON inc_dec CLOSE_PARENTHESES OPEN_CURLY code_list CLOSE_CURLY
      | statement SEMICOLON
      ;

for_initialization : datatype IDENTIFIER {addSymbol('V'); } init
                    | IDENTIFIER init
                    ;

inc_dec : IDENTIFIER UNARY
        | UNARY IDENTIFIER  
        ;

statement : datatype IDENTIFIER {addSymbol('V'); } init 
          | IDENTIFIER { checkDeclaration($1.name) } ASSIGN expression 
          | IDENTIFIER { checkDeclaration($1.name) } UNARY
          | UNARY IDENTIFIER { checkDeclaration($2.name) }
          | IDENTIFIER { checkDeclaration($1.name) } relation_op expression
          ;

init: ASSIGN value
    | 
    ;

else : ELSE  OPEN_CURLY code_list CLOSE_CURLY
     |
     ; 

condition : value relation_op value 
          | IDENTIFIER relation_op value
          | value relation_op IDENTIFIER
          | IDENTIFIER relation_op IDENTIFIER
          | TRUE  
          | FALSE  
          ;

expression : value arithmetic_op expression
           | IDENTIFIER arithmetic_op expression
           | value
           | IDENTIFIER
           ;

return_stmt : RETURN value SEMICOLON { checkReturnType($2.name, $2.type); }
            |
            ;

value : NUMBER  { strcpy($$.name, $1.name); sprintf($$.type, "int"); addSymbol('C'); }
      | FLOAT_NUM  { strcpy($$.name, $1.name); sprintf($$.type, "float"); addSymbol('C'); }
      | CHARACTER  { strcpy($$.name, $1.name); sprintf($$.type, "char"); addSymbol('C'); }
      ;

arithmetic_op : ADD
              | SUBTRACT
              | MULTIPLY
              | DIVIDE
              ;

relation_op : LT
            | GT
            | LE
            | GE
            | EQ
            | NE
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

    if(errorCount > 0){
        printf("\n\nSemantic analysis completed with %d errors\n", errorCount);
        for(int i=0; i<errorCount; i++){
			printf(" - %s", errors[i]);
		}
    }else{
        printf("Semantic analysis completed with no errors");
    }
    fclose(yyin);
    return 0;
}

void insertDataType(){
    strcpy(type, yytext);
}

int searchSymbol(char *var){
    struct symbolTableEntry *n = symbolTable;

    while(n != NULL){
        if(strcmp(n->identifierName , var) == 0){
            return 1;
        }

        n = n->next;
    }

    return 0;
}

void addSymbol(char c){

    if(!searchSymbol(yytext)){
        struct symbolTableEntry *n = (struct symbolTableEntry *)malloc(sizeof(struct symbolTableEntry));

        if(c == 'H'){
            n->identifierName = strdup(yytext);
            n->identifierType = strdup("header");
            n->dataType = strdup("N/A");
            n->lineNum  = lineNumber;
        }else if(c == 'K'){
            n->identifierName = strdup(yytext);
            n->identifierType = strdup("keyword");
            n->dataType = strdup("N/A");
            n->lineNum  = lineNumber;
        }else if(c == 'V'){
            n->identifierName = strdup(yytext);
            n->identifierType = strdup("variable");
            n->dataType = strdup(type);
            n->lineNum  = lineNumber;
        }else if(c == 'C'){
            n->identifierName = strdup(yytext);
            n->identifierType = strdup("constant");
            n->dataType = strdup("const");
            n->lineNum  = lineNumber;
        }else if(c == 'F'){
            n->identifierName = strdup(yytext);
            n->identifierType = strdup("function");
            n->dataType = strdup(type);
            n->lineNum  = lineNumber;
        }

        n->next = symbolTable;
        symbolTable = n;
    }
}

void printST() {
    struct symbolTableEntry *temp = symbolTable;

    if (temp == NULL) {
        printf("Symbol table is empty.\n");
        return;
    }

    // Print table header
    printf("\nPHASE 1: LEXICAL ANALYSIS \n\n");
    printf("+----------------------+----------------------+----------------------+--------------+\n");
    printf("| %-20s | %-20s | %-20s | %-12s |\n", "SYMBOL","TYPE", "DATATYPE", "LINE NUMBER");
    printf("+----------------------+----------------------+----------------------+--------------+\n");

    // Print table contents
    while (temp != NULL) {
        printf("| %-20s | %-20s | %-20s | %-12d |\n", temp->identifierName,temp->identifierType, temp->dataType, temp->lineNum);
        temp = temp->next;
    }

    // Print table footer
    printf("+----------------------+----------------------+----------------------+--------------+\n");
}

void checkDeclaration(char *var){
    if(!searchSymbol(var)){
        sprintf(errors[errorCount++], "Line %d. Variable %s not declared before usage.\n", lineNumber, var);
    }
}

void checkReturnType(char *val, char *type){
    char *mainDataType = getDataType("main");
    char *returnDataType = getDataType(val);
    
    if(!strcmp(mainDataType, "void")){
        sprintf(errors[errorCount++], "Line %d. Return with a value, in function returning void.\n", lineNumber);
        return;
    }
    
    if(!strcmp(mainDataType, type)){
        return;
    }else{
        sprintf(errors[errorCount++], "Line %d. Return type mismatch.\n", lineNumber);
    }
}

char *getDataType(char *var){
    struct symbolTableEntry *n = symbolTable;
    while(n != NULL){
        if(!strcmp(n->identifierName, var)){
            return n->dataType;
        }
        n = n->next;
    }

    return "undefined";
}

void yyerror(const char* msg) {
    fprintf(stderr, "Error at line %d: %s\n", lineNumber, msg);
}