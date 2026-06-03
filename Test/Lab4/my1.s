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

f_f1:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -32                 
sw $a0, -12($fp)
sw $a1, -16($fp)
sw $a2, -20($fp)
lw $t0, -12($fp)
move $t1, $t0
sw $t0, -12($fp)
lw $t0, -16($fp)
move $t2, $t0
sw $t0, -16($fp)
mul $t0, $t1, $t2
sw $t1, -24($fp)
sw $t2, -28($fp)
lw $t1, -20($fp)
move $t2, $t1
sw $t1, -20($fp)
mul $t1, $t0, $t2
sw $t0, -32($fp)
sw $t2, -36($fp)
sw $t1, -40($fp)
lw $v0, -40($fp)
j ret_f1
ret_f1:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 40
jr $ra
main:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -48                 
li $t0, 4
li $t1, 5
sub $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
sw $t2, -20($fp)
li $t0, 2
li $t1, 4
add $t2, $t0, $t1
sw $t0, -24($fp)
sw $t1, -28($fp)
sw $t2, -32($fp)
li $t0, 1
li $t1, 2
mul $t2, $t0, $t1
sw $t0, -36($fp)
sw $t1, -40($fp)
sw $t2, -44($fp)
lw $a0, -44($fp)
lw $a1, -32($fp)
lw $a2, -20($fp)
jal f_f1
sw $v0, -48($fp)
lw $t0, -48($fp)
move $t1, $t0
sw $t0, -48($fp)
sw $t1, -52($fp)
li $t0, 0
sw $t0, -56($fp)
lw $v0, -56($fp)
j ret_main
ret_main:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 56
jr $ra
