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
addi $sp, $sp, -308                
jal read
move $t0, $v0
move $t1, $t0
sw $t0, -12($fp)
jal read
move $t0, $v0
move $t2, $t0
sw $t0, -16($fp)
jal read
move $t0, $v0
move $t3, $t0
sw $t0, -20($fp)
move $t0, $t1
sw $t1, -24($fp)
move $t1, $t2
sw $t2, -28($fp)
add $t2, $t0, $t1
sw $t0, -32($fp)
sw $t1, -36($fp)
move $t0, $t3
sw $t3, -40($fp)
sw $t0, -44($fp)
sw $t2, -48($fp)
lw $t0, -48($fp)
lw $t1, -44($fp)
bgt $t0, $t1, label4
j label1
label4:
lw $t0, -28($fp)
move $t1, $t0
sw $t0, -28($fp)
lw $t0, -40($fp)
move $t2, $t0
sw $t0, -40($fp)
add $t0, $t1, $t2
sw $t1, -52($fp)
sw $t2, -56($fp)
lw $t1, -24($fp)
move $t2, $t1
sw $t1, -24($fp)
sw $t0, -60($fp)
sw $t2, -64($fp)
lw $t0, -60($fp)
lw $t1, -64($fp)
bgt $t0, $t1, label3
j label1
label3:
lw $t0, -24($fp)
move $t1, $t0
sw $t0, -24($fp)
lw $t0, -40($fp)
move $t2, $t0
sw $t0, -40($fp)
add $t0, $t1, $t2
sw $t1, -68($fp)
sw $t2, -72($fp)
lw $t1, -28($fp)
move $t2, $t1
sw $t1, -28($fp)
sw $t0, -76($fp)
sw $t2, -80($fp)
lw $t0, -76($fp)
lw $t1, -80($fp)
bgt $t0, $t1, label0
j label1
label0:
lw $t0, -24($fp)
move $t1, $t0
lw $t2, -28($fp)
move $t3, $t2
add $t4, $t1, $t3
sw $t1, -84($fp)
sw $t3, -88($fp)
lw $t1, -40($fp)
move $t3, $t1
sw $t1, -40($fp)
add $t1, $t4, $t3
sw $t4, -92($fp)
sw $t3, -96($fp)
move $t3, $t1
sw $t1, -100($fp)
sw $t3, -104($fp)
move $t1, $t0
sw $t0, -24($fp)
move $t0, $t2
sw $t2, -28($fp)
sw $t0, -108($fp)
sw $t1, -112($fp)
lw $t0, -112($fp)
lw $t1, -108($fp)
beq $t0, $t1, label8
j label6
label8:
lw $t0, -24($fp)
move $t1, $t0
sw $t0, -24($fp)
lw $t0, -40($fp)
move $t2, $t0
sw $t0, -40($fp)
sw $t1, -116($fp)
sw $t2, -120($fp)
lw $t0, -116($fp)
lw $t1, -120($fp)
beq $t0, $t1, label5
j label6
label5:
li $t0, 1
move $t1, $t0
sw $t0, -124($fp)
sw $t1, -128($fp)
j label7
label6:
lw $t0, -24($fp)
move $t1, $t0
sw $t0, -24($fp)
lw $t0, -28($fp)
move $t2, $t0
sw $t0, -28($fp)
sw $t1, -132($fp)
sw $t2, -136($fp)
lw $t0, -132($fp)
lw $t1, -136($fp)
beq $t0, $t1, label9
j label13
label13:
lw $t0, -24($fp)
move $t1, $t0
sw $t0, -24($fp)
lw $t0, -40($fp)
move $t2, $t0
sw $t0, -40($fp)
sw $t1, -140($fp)
sw $t2, -144($fp)
lw $t0, -140($fp)
lw $t1, -144($fp)
beq $t0, $t1, label9
j label12
label12:
lw $t0, -28($fp)
move $t1, $t0
sw $t0, -28($fp)
lw $t0, -40($fp)
move $t2, $t0
sw $t0, -40($fp)
sw $t1, -148($fp)
sw $t2, -152($fp)
lw $t0, -148($fp)
lw $t1, -152($fp)
beq $t0, $t1, label9
j label10
label9:
li $t0, 2
move $t1, $t0
sw $t0, -156($fp)
sw $t1, -128($fp)
j label11
label10:
li $t0, 0
sw $t0, -160($fp)
lw $t0, -24($fp)
move $t1, $t0
move $t2, $t0
sw $t0, -24($fp)
mul $t0, $t1, $t2
sw $t1, -164($fp)
sw $t2, -168($fp)
lw $t1, -28($fp)
move $t2, $t1
move $t3, $t1
sw $t1, -28($fp)
mul $t1, $t2, $t3
sw $t2, -172($fp)
sw $t3, -176($fp)
add $t2, $t0, $t1
sw $t0, -180($fp)
sw $t1, -184($fp)
lw $t0, -40($fp)
move $t1, $t0
move $t3, $t0
sw $t0, -40($fp)
mul $t0, $t1, $t3
sw $t1, -188($fp)
sw $t3, -192($fp)
sw $t0, -196($fp)
sw $t2, -200($fp)
lw $t0, -200($fp)
lw $t1, -196($fp)
beq $t0, $t1, label19
j label20
label19:
li $t0, 1
sw $t0, -160($fp)
label20:
lw $t0, -160($fp)
li $t1, 0
bne $t0, $t1, label14
j label18
label18:
li $t0, 0
sw $t0, -204($fp)
lw $t0, -24($fp)
move $t1, $t0
move $t2, $t0
sw $t0, -24($fp)
mul $t0, $t1, $t2
sw $t1, -208($fp)
sw $t2, -212($fp)
lw $t1, -40($fp)
move $t2, $t1
move $t3, $t1
sw $t1, -40($fp)
mul $t1, $t2, $t3
sw $t2, -216($fp)
sw $t3, -220($fp)
add $t2, $t0, $t1
sw $t0, -224($fp)
sw $t1, -228($fp)
lw $t0, -28($fp)
move $t1, $t0
move $t3, $t0
sw $t0, -28($fp)
mul $t0, $t1, $t3
sw $t1, -232($fp)
sw $t3, -236($fp)
sw $t0, -240($fp)
sw $t2, -244($fp)
lw $t0, -244($fp)
lw $t1, -240($fp)
beq $t0, $t1, label21
j label22
label21:
li $t0, 1
sw $t0, -204($fp)
label22:
lw $t0, -204($fp)
li $t1, 0
bne $t0, $t1, label14
j label17
label17:
li $t0, 0
sw $t0, -248($fp)
lw $t0, -28($fp)
move $t1, $t0
move $t2, $t0
sw $t0, -28($fp)
mul $t0, $t1, $t2
sw $t1, -252($fp)
sw $t2, -256($fp)
lw $t1, -40($fp)
move $t2, $t1
move $t3, $t1
sw $t1, -40($fp)
mul $t1, $t2, $t3
sw $t2, -260($fp)
sw $t3, -264($fp)
add $t2, $t0, $t1
sw $t0, -268($fp)
sw $t1, -272($fp)
lw $t0, -24($fp)
move $t1, $t0
move $t3, $t0
sw $t0, -24($fp)
mul $t0, $t1, $t3
sw $t1, -276($fp)
sw $t3, -280($fp)
sw $t0, -284($fp)
sw $t2, -288($fp)
lw $t0, -288($fp)
lw $t1, -284($fp)
beq $t0, $t1, label23
j label24
label23:
li $t0, 1
sw $t0, -248($fp)
label24:
lw $t0, -248($fp)
li $t1, 0
bne $t0, $t1, label14
j label15
label14:
li $t0, 3
move $t1, $t0
sw $t0, -292($fp)
sw $t1, -128($fp)
j label16
label15:
li $t0, 0
move $t1, $t0
sw $t0, -296($fp)
sw $t1, -128($fp)
label16:
label11:
label7:
lw $t0, -128($fp)
move $t1, $t0
sw $t0, -128($fp)
move $a0, $t1
jal write
sw $t1, -300($fp)
lw $t0, -104($fp)
move $t1, $t0
sw $t0, -104($fp)
move $a0, $t1
jal write
sw $t1, -304($fp)
j label2
label1:
li $t0, 1
li $t1, 0
sub $t1, $t1, $t0
sw $t0, -308($fp)
move $a0, $t1
jal write
sw $t1, -312($fp)
label2:
li $t0, 0
sw $t0, -316($fp)
lw $v0, -316($fp)
j ret_main
ret_main:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 316
jr $ra
