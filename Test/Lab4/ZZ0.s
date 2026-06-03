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

f_f0:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -4                  
li $t0, 1
sw $t0, -12($fp)
lw $v0, -12($fp)
j ret_f0
ret_f0:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 12
jr $ra
f_f1:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f0
sw $v0, -12($fp)
jal f_f0
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 1
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f1
ret_f1:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f2:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f1
sw $v0, -12($fp)
jal f_f1
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 2
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f2
ret_f2:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f3:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f2
sw $v0, -12($fp)
jal f_f2
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 3
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f3
ret_f3:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f4:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f3
sw $v0, -12($fp)
jal f_f3
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 4
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f4
ret_f4:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f5:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f4
sw $v0, -12($fp)
jal f_f4
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 5
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f5
ret_f5:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f6:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f5
sw $v0, -12($fp)
jal f_f5
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 6
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f6
ret_f6:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f7:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f6
sw $v0, -12($fp)
jal f_f6
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 7
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f7
ret_f7:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f8:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f7
sw $v0, -12($fp)
jal f_f7
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 8
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f8
ret_f8:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f9:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f8
sw $v0, -12($fp)
jal f_f8
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 9
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f9
ret_f9:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f10:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f9
sw $v0, -12($fp)
jal f_f9
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 10
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f10
ret_f10:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f11:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f10
sw $v0, -12($fp)
jal f_f10
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 11
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f11
ret_f11:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f12:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f11
sw $v0, -12($fp)
jal f_f11
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 12
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f12
ret_f12:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f13:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f12
sw $v0, -12($fp)
jal f_f12
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 13
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f13
ret_f13:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f14:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f13
sw $v0, -12($fp)
jal f_f13
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 14
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f14
ret_f14:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f15:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f14
sw $v0, -12($fp)
jal f_f14
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 15
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f15
ret_f15:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f16:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f15
sw $v0, -12($fp)
jal f_f15
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 16
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f16
ret_f16:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f17:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f16
sw $v0, -12($fp)
jal f_f16
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 17
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f17
ret_f17:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f18:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f17
sw $v0, -12($fp)
jal f_f17
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 18
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f18
ret_f18:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f19:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f18
sw $v0, -12($fp)
jal f_f18
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 19
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f19
ret_f19:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f20:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f19
sw $v0, -12($fp)
jal f_f19
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 20
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f20
ret_f20:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f21:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f20
sw $v0, -12($fp)
jal f_f20
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 21
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f21
ret_f21:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f22:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f21
sw $v0, -12($fp)
jal f_f21
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 22
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f22
ret_f22:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f23:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f22
sw $v0, -12($fp)
jal f_f22
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 23
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f23
ret_f23:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f24:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f23
sw $v0, -12($fp)
jal f_f23
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 24
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f24
ret_f24:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f25:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f24
sw $v0, -12($fp)
jal f_f24
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 25
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f25
ret_f25:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f26:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f25
sw $v0, -12($fp)
jal f_f25
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 26
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f26
ret_f26:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f27:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f26
sw $v0, -12($fp)
jal f_f26
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 27
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f27
ret_f27:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f28:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f27
sw $v0, -12($fp)
jal f_f27
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 28
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f28
ret_f28:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f29:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f28
sw $v0, -12($fp)
jal f_f28
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 29
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f29
ret_f29:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f30:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f29
sw $v0, -12($fp)
jal f_f29
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 30
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f30
ret_f30:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f31:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f30
sw $v0, -12($fp)
jal f_f30
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 31
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f31
ret_f31:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f32:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f31
sw $v0, -12($fp)
jal f_f31
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 32
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f32
ret_f32:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f33:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f32
sw $v0, -12($fp)
jal f_f32
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 33
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f33
ret_f33:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f34:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f33
sw $v0, -12($fp)
jal f_f33
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 34
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f34
ret_f34:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f35:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f34
sw $v0, -12($fp)
jal f_f34
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 35
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f35
ret_f35:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f36:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f35
sw $v0, -12($fp)
jal f_f35
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 36
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f36
ret_f36:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f37:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f36
sw $v0, -12($fp)
jal f_f36
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 37
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f37
ret_f37:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f38:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f37
sw $v0, -12($fp)
jal f_f37
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 38
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f38
ret_f38:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f39:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f38
sw $v0, -12($fp)
jal f_f38
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 39
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f39
ret_f39:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f40:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f39
sw $v0, -12($fp)
jal f_f39
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 40
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f40
ret_f40:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f41:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f40
sw $v0, -12($fp)
jal f_f40
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 41
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f41
ret_f41:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f42:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f41
sw $v0, -12($fp)
jal f_f41
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 42
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f42
ret_f42:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f43:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f42
sw $v0, -12($fp)
jal f_f42
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 43
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f43
ret_f43:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f44:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f43
sw $v0, -12($fp)
jal f_f43
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 44
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f44
ret_f44:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f45:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f44
sw $v0, -12($fp)
jal f_f44
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 45
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f45
ret_f45:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f46:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f45
sw $v0, -12($fp)
jal f_f45
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 46
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f46
ret_f46:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f47:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f46
sw $v0, -12($fp)
jal f_f46
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 47
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f47
ret_f47:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f48:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f47
sw $v0, -12($fp)
jal f_f47
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 48
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f48
ret_f48:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f49:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f48
sw $v0, -12($fp)
jal f_f48
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 49
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f49
ret_f49:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f50:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f49
sw $v0, -12($fp)
jal f_f49
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 50
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f50
ret_f50:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f51:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f50
sw $v0, -12($fp)
jal f_f50
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 51
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f51
ret_f51:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f52:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f51
sw $v0, -12($fp)
jal f_f51
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 52
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f52
ret_f52:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f53:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f52
sw $v0, -12($fp)
jal f_f52
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 53
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f53
ret_f53:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f54:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f53
sw $v0, -12($fp)
jal f_f53
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 54
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f54
ret_f54:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f55:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f54
sw $v0, -12($fp)
jal f_f54
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 55
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f55
ret_f55:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f56:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f55
sw $v0, -12($fp)
jal f_f55
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 56
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f56
ret_f56:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f57:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f56
sw $v0, -12($fp)
jal f_f56
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 57
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f57
ret_f57:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f58:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f57
sw $v0, -12($fp)
jal f_f57
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 58
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f58
ret_f58:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f59:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f58
sw $v0, -12($fp)
jal f_f58
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 59
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f59
ret_f59:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f60:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f59
sw $v0, -12($fp)
jal f_f59
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 60
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f60
ret_f60:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f61:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f60
sw $v0, -12($fp)
jal f_f60
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 61
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f61
ret_f61:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f62:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f61
sw $v0, -12($fp)
jal f_f61
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 62
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f62
ret_f62:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f63:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f62
sw $v0, -12($fp)
jal f_f62
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 63
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f63
ret_f63:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f64:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f63
sw $v0, -12($fp)
jal f_f63
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 64
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f64
ret_f64:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f65:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f64
sw $v0, -12($fp)
jal f_f64
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 65
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f65
ret_f65:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f66:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f65
sw $v0, -12($fp)
jal f_f65
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 66
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f66
ret_f66:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f67:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f66
sw $v0, -12($fp)
jal f_f66
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 67
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f67
ret_f67:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f68:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f67
sw $v0, -12($fp)
jal f_f67
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 68
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f68
ret_f68:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f69:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f68
sw $v0, -12($fp)
jal f_f68
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 69
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f69
ret_f69:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f70:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f69
sw $v0, -12($fp)
jal f_f69
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 70
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f70
ret_f70:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f71:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f70
sw $v0, -12($fp)
jal f_f70
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 71
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f71
ret_f71:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f72:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f71
sw $v0, -12($fp)
jal f_f71
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 72
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f72
ret_f72:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f73:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f72
sw $v0, -12($fp)
jal f_f72
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 73
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f73
ret_f73:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f74:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f73
sw $v0, -12($fp)
jal f_f73
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 74
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f74
ret_f74:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f75:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f74
sw $v0, -12($fp)
jal f_f74
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 75
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f75
ret_f75:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f76:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f75
sw $v0, -12($fp)
jal f_f75
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 76
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f76
ret_f76:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f77:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f76
sw $v0, -12($fp)
jal f_f76
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 77
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f77
ret_f77:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f78:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f77
sw $v0, -12($fp)
jal f_f77
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 78
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f78
ret_f78:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f79:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f78
sw $v0, -12($fp)
jal f_f78
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 79
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f79
ret_f79:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f80:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f79
sw $v0, -12($fp)
jal f_f79
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 80
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f80
ret_f80:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f81:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f80
sw $v0, -12($fp)
jal f_f80
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 81
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f81
ret_f81:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f82:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f81
sw $v0, -12($fp)
jal f_f81
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 82
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f82
ret_f82:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f83:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f82
sw $v0, -12($fp)
jal f_f82
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 83
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f83
ret_f83:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f84:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f83
sw $v0, -12($fp)
jal f_f83
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 84
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f84
ret_f84:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f85:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f84
sw $v0, -12($fp)
jal f_f84
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 85
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f85
ret_f85:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f86:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f85
sw $v0, -12($fp)
jal f_f85
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 86
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f86
ret_f86:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f87:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f86
sw $v0, -12($fp)
jal f_f86
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 87
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f87
ret_f87:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f88:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f87
sw $v0, -12($fp)
jal f_f87
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 88
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f88
ret_f88:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f89:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f88
sw $v0, -12($fp)
jal f_f88
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 89
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f89
ret_f89:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f90:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f89
sw $v0, -12($fp)
jal f_f89
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 90
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f90
ret_f90:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f91:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f90
sw $v0, -12($fp)
jal f_f90
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 91
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f91
ret_f91:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f92:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f91
sw $v0, -12($fp)
jal f_f91
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 92
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f92
ret_f92:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f93:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f92
sw $v0, -12($fp)
jal f_f92
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 93
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f93
ret_f93:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f94:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f93
sw $v0, -12($fp)
jal f_f93
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 94
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f94
ret_f94:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f95:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f94
sw $v0, -12($fp)
jal f_f94
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 95
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f95
ret_f95:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f96:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f95
sw $v0, -12($fp)
jal f_f95
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 96
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f96
ret_f96:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f97:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f96
sw $v0, -12($fp)
jal f_f96
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 97
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f97
ret_f97:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f98:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f97
sw $v0, -12($fp)
jal f_f97
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 98
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f98
ret_f98:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
f_f99:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -20                 
jal f_f98
sw $v0, -12($fp)
jal f_f98
sw $v0, -16($fp)
lw $t0, -12($fp)
lw $t1, -16($fp)
add $t2, $t0, $t1
sw $t0, -12($fp)
sw $t1, -16($fp)
li $t0, 99
add $t1, $t2, $t0
sw $t2, -20($fp)
sw $t0, -24($fp)
sw $t1, -28($fp)
lw $v0, -28($fp)
j ret_f99
ret_f99:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 28
jr $ra
main:
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $fp, 0($sp)
addi $fp, $sp, 8
addi $sp, $sp, -48                 
jal f_f99
sw $v0, -12($fp)
lw $t0, -12($fp)
move $a0, $t0
jal write
sw $t0, -12($fp)
jal f_f98
sw $v0, -16($fp)
lw $t0, -16($fp)
move $a0, $t0
jal write
sw $t0, -16($fp)
jal f_f94
sw $v0, -20($fp)
lw $t0, -20($fp)
move $a0, $t0
jal write
sw $t0, -20($fp)
jal f_f89
sw $v0, -24($fp)
lw $t0, -24($fp)
move $a0, $t0
jal write
sw $t0, -24($fp)
jal f_f84
sw $v0, -28($fp)
lw $t0, -28($fp)
move $a0, $t0
jal write
sw $t0, -28($fp)
jal f_f81
sw $v0, -32($fp)
lw $t0, -32($fp)
move $a0, $t0
jal write
sw $t0, -32($fp)
jal f_f72
sw $v0, -36($fp)
lw $t0, -36($fp)
move $a0, $t0
jal write
sw $t0, -36($fp)
jal f_f69
sw $v0, -40($fp)
lw $t0, -40($fp)
move $a0, $t0
jal write
sw $t0, -40($fp)
jal f_f63
sw $v0, -44($fp)
lw $t0, -44($fp)
move $a0, $t0
jal write
sw $t0, -44($fp)
jal f_f60
sw $v0, -48($fp)
lw $t0, -48($fp)
move $a0, $t0
jal write
sw $t0, -48($fp)
jal f_f29
sw $v0, -52($fp)
lw $t0, -52($fp)
move $a0, $t0
jal write
sw $t0, -52($fp)
li $t0, 0
sw $t0, -56($fp)
lw $v0, -56($fp)
j ret_main
ret_main:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 56
jr $ra
