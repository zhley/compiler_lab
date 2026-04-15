#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

typedef struct Type {
    enum {
        BASIC, ARRAY, STRUCT
    } kind;
    union {
        int basic; // 0 int 1 float
        struct {
            struct Type* elem;
            int size;
        } array;
        struct FieldList* structure;
    };
} Type;

typedef struct FieldList {
    const char* name;
    struct Type* type;
    struct FieldList* next;
} FieldList;

typedef struct FuncParam {
    Type* type;
    struct FuncParam* next;
} FuncParam;

typedef enum { 
    SYM_VAR, SYM_FUNC, SYM_STRUCT_TAG
} SymKind;

typedef struct SymbolEntry{
    const char* name;
    SymKind kind;
    union {
        Type* var_type;
        struct {
            Type* ret_type;
            FuncParam* params;
        } func_info;
        FieldList* struct_type;
    };
} SymbolEntry;

void init_symbol_table();
int insert_symbol(SymbolEntry* entry);
SymbolEntry* find_symbol(const char* name);

#endif
