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

 extern int lineNumber;

%}

%token MAIN INT FLOAT CHAR VOID RETURN INCLUDE OPEN_PARENTHESES CLOSE_PARENTHESES OPEN_CURLY CLOSE_CURLY SEMICOLON NUMBER FLOAT_NUM CHARACTER STRING PRINTF
%token COMMA AMPERSEND SCANF IF ELSE FOR IDENTIFIER ASSIGN LE GE EQ NE LT GT AND OR ADD SUBTRACT MULTIPLY DIVIDE TRUE FALSE UNARY

 

%%

program: headers datatype MAIN OPEN_PARENTHESES CLOSE_PARENTHESES OPEN_CURLY body return_stmt CLOSE_CURLY { printf("Correct code!\n"); }
    ;

headers: INCLUDE headers
        | INCLUDE
        ;

datatype: INT
        | FLOAT
        | CHAR
        | VOID
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

for_initialization : datatype IDENTIFIER init
                    | IDENTIFIER init
                    ;

inc_dec : IDENTIFIER UNARY
        | UNARY IDENTIFIER
        ;

statement : datatype IDENTIFIER init 
          | IDENTIFIER ASSIGN expression 
          | IDENTIFIER UNARY
          | UNARY IDENTIFIER
          | IDENTIFIER relation_op expression
          ;

init: ASSIGN value
    | 
    ;

else : ELSE OPEN_CURLY code_list CLOSE_CURLY
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

return_stmt : RETURN value SEMICOLON
            |
            ;

value : NUMBER
      | FLOAT_NUM
      | CHARACTER
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
    printf("Total lines in code : %d" , lineNumber);
    fclose(yyin);
    return 0;
}






void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}