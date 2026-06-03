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
addi $sp, $sp, -20                 
li $t0, 2
move $a0, $t0
jal write
sw $t0, -12($fp)
li $t0, 0
move $a0, $t0
jal write
sw $t0, -16($fp)
li $t0, 1
move $a0, $t0
jal write
sw $t0, -20($fp)
li $t0, 7
move $a0, $t0
jal write
sw $t0, -24($fp)
li $t0, 0
sw $t0, -28($fp)
lw $v0, -28($fp)
j ret_main
ret_main:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
