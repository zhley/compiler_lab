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
addi $sp, $sp, -304                
addi $t0, $fp, -28
sw $t0, -32($fp)
li $t0, 0
move $t1, $t0
sw $t0, -36($fp)
sw $t1, -40($fp)
li $t0, 5
move $t1, $t0
sw $t0, -44($fp)
sw $t1, -48($fp)
li $t0, 0
move $t1, $t0
sw $t0, -52($fp)
sw $t1, -56($fp)
label0:
lw $t0, -40($fp)
move $t1, $t0
sw $t0, -40($fp)
li $t0, 5
sw $t0, -60($fp)
sw $t1, -64($fp)
lw $t0, -64($fp)
lw $t1, -60($fp)
blt $t0, $t1, label1
j label2
label1:
lw $t0, -32($fp)
move $t1, $t0
sw $t0, -32($fp)
lw $t0, -40($fp)
move $t2, $t0
li $t3, 4
mul $t3, $t2, $t3
sw $t2, -68($fp)
add $t1, $t1, $t3
sw $t1, -72($fp)
sw $t3, -76($fp)
jal read
move $t1, $v0
lw $t2, -72($fp)
sw $t1, 0($t2)
sw $t1, -80($fp)
sw $t2, -72($fp)
move $t1, $t0
sw $t0, -40($fp)
li $t0, 1
add $t2, $t1, $t0
sw $t1, -84($fp)
sw $t0, -88($fp)
move $t0, $t2
sw $t2, -92($fp)
sw $t0, -40($fp)
j label0
label2:
lw $t0, -48($fp)
move $t1, $t0
sw $t0, -48($fp)
move $t0, $t1
sw $t1, -96($fp)
sw $t0, -40($fp)
label3:
lw $t0, -40($fp)
move $t1, $t0
sw $t0, -40($fp)
li $t0, 0
sw $t0, -100($fp)
sw $t1, -104($fp)
lw $t0, -104($fp)
lw $t1, -100($fp)
bgt $t0, $t1, label4
j label5
label4:
label6:
lw $t0, -56($fp)
move $t1, $t0
sw $t0, -56($fp)
lw $t0, -40($fp)
move $t2, $t0
sw $t0, -40($fp)
li $t0, 1
sub $t3, $t2, $t0
sw $t2, -108($fp)
sw $t0, -112($fp)
sw $t1, -116($fp)
sw $t3, -120($fp)
lw $t0, -116($fp)
lw $t1, -120($fp)
blt $t0, $t1, label7
j label8
label7:
lw $t0, -32($fp)
move $t1, $t0
lw $t2, -56($fp)
move $t3, $t2
li $t4, 4
mul $t4, $t3, $t4
sw $t3, -124($fp)
add $t1, $t1, $t4
sw $t4, -128($fp)
lw $t3, 0($t1)
sw $t1, -132($fp)
move $t1, $t0
sw $t0, -32($fp)
move $t0, $t2
sw $t2, -56($fp)
li $t2, 1
add $t4, $t0, $t2
sw $t0, -136($fp)
sw $t2, -140($fp)
li $t0, 4
mul $t0, $t4, $t0
sw $t4, -144($fp)
add $t1, $t1, $t0
sw $t0, -148($fp)
lw $t0, 0($t1)
sw $t1, -152($fp)
sw $t0, -156($fp)
sw $t3, -160($fp)
lw $t0, -160($fp)
lw $t1, -156($fp)
bgt $t0, $t1, label9
j label10
label9:
lw $t0, -32($fp)
move $t1, $t0
lw $t2, -56($fp)
move $t3, $t2
li $t4, 4
mul $t4, $t3, $t4
sw $t3, -164($fp)
add $t1, $t1, $t4
sw $t4, -168($fp)
lw $t3, 0($t1)
sw $t1, -172($fp)
move $t1, $t3
sw $t3, -176($fp)
move $t3, $t0
move $t4, $t2
li $t5, 4
mul $t5, $t4, $t5
sw $t4, -180($fp)
add $t3, $t3, $t5
sw $t3, -184($fp)
sw $t5, -188($fp)
move $t3, $t0
move $t4, $t2
li $t5, 1
add $t6, $t4, $t5
sw $t4, -192($fp)
sw $t5, -196($fp)
li $t4, 4
mul $t4, $t6, $t4
sw $t6, -200($fp)
add $t3, $t3, $t4
sw $t4, -204($fp)
lw $t4, 0($t3)
sw $t3, -208($fp)
lw $t3, -184($fp)
sw $t4, 0($t3)
sw $t4, -212($fp)
sw $t3, -184($fp)
move $t3, $t0
sw $t0, -32($fp)
move $t0, $t2
sw $t2, -56($fp)
li $t2, 1
add $t4, $t0, $t2
sw $t0, -216($fp)
sw $t2, -220($fp)
li $t0, 4
mul $t0, $t4, $t0
sw $t4, -224($fp)
add $t3, $t3, $t0
sw $t3, -228($fp)
sw $t0, -232($fp)
move $t0, $t1
sw $t1, -236($fp)
lw $t1, -228($fp)
sw $t0, 0($t1)
sw $t0, -240($fp)
sw $t1, -228($fp)
label10:
lw $t0, -56($fp)
move $t1, $t0
sw $t0, -56($fp)
li $t0, 1
add $t2, $t1, $t0
sw $t1, -244($fp)
sw $t0, -248($fp)
move $t0, $t2
sw $t2, -252($fp)
sw $t0, -56($fp)
j label6
label8:
li $t0, 0
move $t1, $t0
sw $t0, -256($fp)
sw $t1, -56($fp)
lw $t0, -40($fp)
move $t1, $t0
sw $t0, -40($fp)
li $t0, 1
sub $t2, $t1, $t0
sw $t1, -260($fp)
sw $t0, -264($fp)
move $t0, $t2
sw $t2, -268($fp)
sw $t0, -40($fp)
j label3
label5:
li $t0, 0
move $t1, $t0
sw $t0, -272($fp)
sw $t1, -40($fp)
label11:
lw $t0, -40($fp)
move $t1, $t0
sw $t0, -40($fp)
li $t0, 5
sw $t0, -276($fp)
sw $t1, -280($fp)
lw $t0, -280($fp)
lw $t1, -276($fp)
blt $t0, $t1, label12
j label13
label12:
lw $t0, -32($fp)
move $t1, $t0
sw $t0, -32($fp)
lw $t0, -40($fp)
move $t2, $t0
li $t3, 4
mul $t3, $t2, $t3
sw $t2, -284($fp)
add $t1, $t1, $t3
sw $t3, -288($fp)
lw $t2, 0($t1)
sw $t1, -292($fp)
move $a0, $t2
jal write
sw $t2, -296($fp)
move $t1, $t0
sw $t0, -40($fp)
li $t0, 1
add $t2, $t1, $t0
sw $t1, -300($fp)
sw $t0, -304($fp)
move $t0, $t2
sw $t2, -308($fp)
sw $t0, -40($fp)
j label11
label13:
li $t0, 0
sw $t0, -312($fp)
lw $v0, -312($fp)
j ret_main
ret_main:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 312
jr $ra
