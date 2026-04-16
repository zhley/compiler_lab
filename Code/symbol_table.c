#include "symbol_table.h"
#include <stdlib.h>
#include <string.h>

#define HASH_SIZE 0x3fff

Type INT = {BASIC, 1};
Type FLOAT = {BASIC, 0};

typedef struct HashNode {
    SymbolEntry* entry;
    struct HashNode* next;
} HashNode;

static HashNode* hash_table[HASH_SIZE];

static unsigned int hash_pjw(const char *name) {
    unsigned int val = 0, i;
    for (; *name; ++name) {
        val = (val << 2) + *name;
        if (i = val & ~0x3fff)
            val = (val ^ (i >> 12)) & 0x3fff;
    }
    return val;
}

void init_symbol_table() {
    for (int i = 0; i < HASH_SIZE; ++i) {
        hash_table[i] = NULL;
    }
}

int insert_symbol(SymbolEntry* entry) {
    unsigned int index = hash_pjw(entry->name);
    HashNode* p = hash_table[index];
    while (p) {
        if (strcmp(p->entry->name, entry->name) == 0) {
            return 0; // already exists
        }
        p = p->next;
    }
    HashNode* new_node = (HashNode*)malloc(sizeof(HashNode));
    new_node->entry = entry;
    new_node->next = hash_table[index];
    hash_table[index] = new_node;
    return 1; // success
}

SymbolEntry* find_symbol(const char* name) {
    unsigned int index = hash_pjw(name);
    HashNode* p = hash_table[index];
    while (p) {
        if (strcmp(p->entry->name, name) == 0) {
            return p->entry;
        }
        p = p->next;
    }
    return NULL;
}

FieldList* find_field(Type* struct_type, const char* field_name){
    if(!struct_type || struct_type->kind != STRUCT) return NULL;
    for(FieldList* p = struct_type->structure; p; p = p->next){
        if(strcmp(p->name, field_name) == 0){
            return p;
        }
    }
    return NULL;
}
