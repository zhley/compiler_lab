# 实验五: 中间代码优化 实验报告

## 1. 编译方式

``````bash
cd ./Code/
make TASK=task1
``````

## 2. 编译环境

GNU/Linux Release: Ubuntu 24.04.4 LTS, kernel: 6.6.87.2-microsoft-standard-WSL2
gcc version 13.3.0
flex 2.6.4
bison (GNU Bison) 3.8.2

## 3. 功能介绍

接受输入文件和输出文件两个参数, 将输入的中间代码进行三种数据流优化后输出.

``````bash
./parser test.ir test_opt.ir
``````

## 4. 实现

使用了框架代码, 完成了`task1`中的TODO内容.
