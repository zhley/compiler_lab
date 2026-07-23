# 实验二: 语义分析 实验报告

## 1. 编译方式

使用 `make` 进行编译, 执行

``````bash
cd ./Code/
make
``````

## 2. 功能介绍

在实验一的词法语法分析得到的语法分析树的基础上进行语义分析.

## 3. 技术细节

### 3.1 语法树优化

1. 实验一的语法分析树节点的子节点使用链表来表示, 语义分析时经常要跳过终结符访问某个特定的子节点, 所以改成了通过**动态数组**来存储, 方便随机访问.

2. 为语法树节点增加了一个属性`prod_id`, 用来表示该节点的子节点是应用哪个产生式得到的, 方便语义分析做判断.

### 3.2 符号表设计

``````C
typedef struct Type {
    enum {
        BASIC, ARRAY, STRUCT
    } kind;
    union {
        int basic; // 1 int 0 float
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
        Type* struct_type;
    };
} SymbolEntry;
``````

符号表使用哈希表实现以达到快速查找和插入, 冲突的元素通过开一个链表来解决.

类型通过链表来表示.

用了两个全局变量表示基本数据类型:

``````C
Type INT = {BASIC, 1};
Type FLOAT = {BASIC, 0};
``````

**相关接口**:

``````C
void init_symbol_table();
int insert_symbol(SymbolEntry* entry);
SymbolEntry* find_symbol(const char* name);
FieldList* find_field(Type* struct_type, const char* field_name);
int type_equal(Type* a, Type* b);
``````

`type_equal`用以判断两类型是否等价, 结构体采用结构等价.

### 3.3 函数参数

在检查函数参数时, 没有在遇到第一个类型不匹配的参数或者发现参数过多时立即报错返回, 而是将整个传参列表遍历完再报错返回, 因为后续的参数可能是表达式, 可能含有其他语义错误.

### 3.4 错误传递

用`NULL`表示因为各种原因导致的错误类型. 

结构体定义出错时依然会将`tag`存入符号表, 避免检测不出重定义错误, 此时这个表项的类型就是`NULL`.

在处理表达式时有大量的类型传递, 为避免因为一处语义错误引发连锁反应导致大量错误, 只在第一次产生`NULL`时抛出错误, 并将这个`NULL`向上传递, 上层见到`NULL`不再抛出错误, 而是直接返回`NULL`继续向上传递.

### 3.5 函数声明产生式

我抽到的是选做3, 不需要实现函数声明, 遇到函数声明应该报语法错误, 但是在遇到连续的两个函数声明时, 只会报第一个, 原因是没有函数声明的产生式, 语法分析器试图匹配函数定义, 但是在匹配函数体时预期左花括号却得到了分号, 进入错误恢复, 但是这个时候分号已经被吞了, 导致匹配`error`产生式时同步到的是下一个分号, 也就是跳过了下一个函数声明.

解决方法是直接加了一个函数声明的产生式, 匹配到这个产生式时手动调用`yyerror`报错.

``````
ExtDef : Specifier ExtDecList SEMI { ADD_NODE3(ExtDef, $$, $1, $2, $3) $$->prod_id = 1; }
    | Specifier SEMI { ADD_NODE2(ExtDef, $$, $1, $2) $$->prod_id = 2; }
    | Specifier FunDec CompSt { ADD_NODE3(ExtDef, $$, $1, $2, $3) $$->prod_id = 3; }
    | Specifier FunDec SEMI { yyerror("function declaration is not supported in C--"); }
    | error SEMI
    ;
``````

