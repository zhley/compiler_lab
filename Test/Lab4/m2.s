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
addi $sp, $sp, -40                 
li $t0, 1
move $t1, $t0
sw $t0, -12($fp)
sw $t1, -16($fp)
jal read
move $t0, $v0
move $t1, $t0
sw $t0, -20($fp)
move $t0, $t1
li $t2, 0
sub $t2, $t2, $t0
sw $t0, -24($fp)
li $t0, 1
add $t3, $t2, $t0
sw $t2, -28($fp)
sw $t0, -32($fp)
move $a0, $t3
jal write
sw $t3, -36($fp)
move $t0, $t1
sw $t1, -16($fp)
sw $t0, -40($fp)
lw $t0, -40($fp)
li $t1, 0
bne $t0, $t1, label0
j label1
label0:
jal main
sw $v0, -44($fp)
lw $v0, -44($fp)
j ret_main
j label2
label1:
li $t0, 0
sw $t0, -48($fp)
lw $v0, -48($fp)
j ret_main
label2:
ret_main:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 48
jr $ra
