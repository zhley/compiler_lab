#include <stdio.h>
#include <stdlib.h>

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
        // function read and write
        SymbolEntry* read_func = (SymbolEntry*)malloc(sizeof(SymbolEntry));
        read_func->name = "read";
        read_func->kind = SYM_FUNC;
        read_func->func_info.ret_type = &INT;
        read_func->func_info.params = NULL;
        insert_symbol(read_func);
        SymbolEntry* write_func = (SymbolEntry*)malloc(sizeof(SymbolEntry));
        write_func->name = "write";
        write_func->kind = SYM_FUNC;
        write_func->func_info.ret_type = NULL;
        FuncParam* write_param = (FuncParam*)malloc(sizeof(FuncParam)); 
        write_param->type = &INT;
        write_func->func_info.params = write_param;
        insert_symbol(write_func);

        if(analyze_semantics(root)) {
            IRInst* ir = translate(root);
            if(ir){
                FILE* output_file = fopen(argv[2], "w");
                if (!output_file) {
                    perror(argv[2]);
                    return 1;
                }
                print_ir(ir, output_file);
                fclose(output_file);
            }
        }
    }
    fclose(file);
    return 0;
}