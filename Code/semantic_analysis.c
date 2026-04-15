#include "semantic_analysis.h"
#include "symbol_table.h"
#include "tree.h"
#include <stdlib.h>

static void process(TreeNode* node);
static void handle_ext_def(TreeNode* node);

void analyze_semantics(TreeNode* root){
    if(!root) return;
    if(root->type == SU_Program){
        process(root);
    }
}

static void process(TreeNode* node){
    if(!node) return;
    switch (node->type) {
        case SU_ExtDef: handle_ext_def(node); break;
        default:
            for(TreeNode* child = node->children.head; child != NULL; child = child->next){
                process(child);
            }
            break;
    }
}

static void handle_ext_def(TreeNode* node){
    TreeNode* ptr = node->children.head;
    Type* type = handle_type(ptr);
    ptr = ptr->next;
    if(ptr->type == SU_ExtDecList){
        
    }
}
