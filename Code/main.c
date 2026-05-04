#include <stdio.h>

#include "ir.h"
#include "symbol_table.h"
#include "tree.h"
#include "semantic_analysis.h"
#include "translate.h"

// Flex
void yyrestart(FILE*);
int yylex(void);
// Bison
int yyparse(void);

int ok = 1;
TreeNode* root;

int main(int argc, char* argv[]){
    if(argc <= 2){
        fprintf(stderr, "Usage: %s [input_filename] [output_filename]\n", argv[0]);
        return 1;
    }
    FILE* file;
    if(!(file = fopen(argv[1], "r"))){
        perror(argv[1]);
        return 1;
    }
    init_symbol_table();
    yyrestart(file);
    yyparse();
    if(ok) {
        if(analyze_semantics(root)) {
            IRInst* ir = translate(root);
            FILE* output_file = fopen(argv[2], "w");
            if (!output_file) {
                perror(argv[2]);
                return 1;
            }
            print_ir(ir, output_file);
            fclose(output_file);
        }
    }
    fclose(file);
    return 0;
}