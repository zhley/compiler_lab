.data
_prompt: .asciiz "Enter an integer:"
_ret: .asciiz "\n"
.globl main
.text
read:
li $v0, 4
la $a0, _prompt
syscall
li $v0, 5
syscall
jr $ra
write:
li $v0, 1
syscall
li $v0, 4
la $a0, _ret
syscall
move $v0, $0
jr $ra

main:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -44                 
jal read
move $t0, $v0
move $t1, $t0
sw $t0, -12($fp)
move $t0, $t1
sw $t1, -16($fp)
li $t1, 0
sw $t0, -20($fp)
sw $t1, -24($fp)
lw $t0, -20($fp)
lw $t1, -24($fp)
bgt $t0, $t1, label0
j label1
label0:
li $t0, 1
move $a0, $t0
jal write
sw $t0, -28($fp)
j label2
label1:
lw $t0, -16($fp)
move $t1, $t0
li $t0, 0
sw $t0, -32($fp)
sw $t1, -36($fp)
lw $t0, -36($fp)
lw $t1, -32($fp)
blt $t0, $t1, label3
j label4
label3:
li $t0, 1
li $t1, 0
sub $t1, $t1, $t0
sw $t0, -40($fp)
move $a0, $t1
jal write
sw $t1, -44($fp)
j label5
label4:
li $t0, 0
move $a0, $t0
jal write
sw $t0, -48($fp)
label5:
label2:
li $t0, 0
sw $t0, -52($fp)
lw $v0, -52($fp)
j ret_main
ret_main:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 52
jr $ra
