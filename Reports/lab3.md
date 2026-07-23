# 实验三: 中间代码生成 实验报告

## 1. 编译方式

使用 `make` 进行编译, 执行

``````bash
cd ./Code/
make
``````

## 2. 功能介绍

输出未经优化的中间代码

## 3. 技术细节

通过遍历语法树来完成翻译.

### 3.1 中间代码表示

用四元式表示三地址代码, 使用链表来存储.

``````C
typedef struct IRInst {
    IROp opcode;
    const char* result;
    const char* arg1;
    const char* arg2;
    Relop relop; // for IR_OP_IF_GOTO
    struct IRInst* next;
} IRInst;
``````

为避免变量重名, 临时变量用`t`加一个递增的整数来命名, 变量则是在原始的变量名前面加上字符`v`.

``````C
const char* new_var(const char* var_name){
    char* new_name = (char*)malloc(strlen(var_name) + 2);
    sprintf(new_name, "v%s", var_name);
    return new_name;
}
``````

### 3.2 结构体和数组的翻译

考虑到结构体和数组都是地址传递, 在中间代码中, 结构体和数组变量表示的都是首地址, 也就是在结构体或数组被分配内存时取到首地址, 并赋值给对应的变量.

对应的代码:

``````C
if(sym->var_type->kind == ARRAY){
    const char* t = new_temp();
    ir = link_ir(ir, new_ir(IR_OP_DEC, t, to_str(get_size(sym->var_type)), NULL, 0));
    ir = link_ir(ir, new_ir(IR_OP_ADDRESS, new_var(var_name), t, NULL, 0));
}else if(sym->var_type->kind == STRUCT){
    const char* t = new_temp();
    ir = link_ir(ir, new_ir(IR_OP_DEC, t, to_str(get_size(sym->var_type)), NULL, 0));
    ir = link_ir(ir, new_ir(IR_OP_ADDRESS, new_var(var_name), t, NULL, 0));
}
``````

### 3.3 布尔表达式

因为是在语法树上进行翻译, 所以上层完全可以准备好 `truelabel` 和 `falselabel`, 没有采用回填方案

