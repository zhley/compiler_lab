# 实验一: 词法分析与语法分析 实验报告

## 1. 编译方式

使用 `make` 进行编译, 执行

``````bash
cd ./Code/
make
``````

## 2. 功能介绍

程序接收一个文件名作为参数, 对其中的C--代码进行词法分析和语法分析, 如果有错误, 将在控制台输出错误信息, 类型A表示词法错误, 类型B表示语法错误, 对于没有词法和语法错误的程序, 将输出分析得到的语法树.

## 3. 技术细节

### 3.1 语法树结构

为表示各语法单元, 定义了一个枚举, 包括终结符和非终结符.

同时定义了一个枚举到字符串的映射数组, 用于打印语法单元的名称.

``````C
typedef enum {
    SU_INT,
    SU_FLOAT,
    SU_ID,
    ......
} SyntaxUnit;

const char* su_names[SU_NUM_SYNTAX_UNITS] = {
    "INT",
    "FLOAT",
    "ID",
    ......
};
``````

语法树节点结构:

``````C
typedef struct TreeNode{
    SyntaxUnit type;
    union val {
        int t_int;
        float t_float;
        char* t_str;
    } val;
    unsigned int line;
    struct children {
        struct TreeNode* head;
        struct TreeNode* end;
    } children;
    struct TreeNode* next;
} TreeNode;
``````

词法单元的属性值使用了一个联合体 `val` , 包含整型, 浮点型和动态分配的字符串, 词法单元 `TYPE` 使用 `int` 表示, `0` 表示`int`, `1`表示`float`.

节点的子节点使用一个带尾指针的链表存储.

节点树的操作函数:

``````C
TreeNode* create_node(SyntaxUnit type);			// 创建节点
void add_node(TreeNode* node, TreeNode* child);	// 插入子节点
void free_tree(TreeNode* node);					// 释放以node为根的树
void print_tree(TreeNode* root);				// 打印语法树
``````

### 3.2 错误恢复

在所有可能产生`;` `)` `]` `}` 的产生式中加入了 `error` 的产生式, 目的是尽可能不漏过语法错误.

### 3.3 问题解决

遇到了一个语法树节点重复出现的Bug.

原因是空串产生式没有写任何语义动作, 导致这个非终结符的属性值, 也就是这个`TreeNode*` 类型的指针成了野指针(估计是指向了某个其他节点), 当匹配到空串时,这个野指针指向的节点被加入了语法树.

解决办法是在空串产生式的语义动作中明确将`$$`赋值为`NULL`, 这样就不会被加入语法树.

反思: 一开始本就应该将空串看成和其他语法单元平等的存在, 就不会出现这个问题了, 或许应该将空串作为语法树的一个节点插入(目前没有这样做是因为空串本来就不需要打印出来, 后续阶段如果需要用到再改).
