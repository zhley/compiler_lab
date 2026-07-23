# 编译原理实验

南京大学 编译原理 2026Spring 课程实验

课程包含5个实验:

- 实验1: 词法和语法分析

- 实验2: 语义分析

- 实验3: 中间代码生成

- 实验4: 目标代码生成

- 实验5: 中间代码优化

本仓库包含的是实验4完成后的代码.
实验5是独立的不依赖前四个实验, 使用了框架代码, 不包含在此.

## 编译环境

- GNU/Linux Release: Ubuntu 24.04.4 LTS, kernel: 6.6.87.2-microsoft-standard-WSL2
- gcc version 13.3.0
- flex 2.6.4
- bison (GNU Bison) 3.8.2

## 使用方法

**编译**:

``````shell
cd Code/
make
``````

**运行**:

``````shell
./parser [input_filename] [output_filename]
``````

将输入的 C-- 源文件编译成 MIPS32 汇编文件输出.
