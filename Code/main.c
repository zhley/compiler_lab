#include <stdio.h>

#include "tree.h"
// Flex
void yyrestart(FILE*);
int yylex(void);
// Bison
int yyparse(void);

int ok = 1;
TreeNode* root;

int main(int argc, char* argv[]){
    if(argc <= 1){
        fprintf(stderr, "Usage: %s [input_filename]\n", argv[0]);
        return 1;
    }
    FILE* file;
    if(!(file = fopen(argv[1], "r"))){
        perror(argv[1]);
        return 1;
    }
    yyrestart(file);
    yyparse();
    if(ok) print_tree(root);
    fclose(file);
    return 0;
}