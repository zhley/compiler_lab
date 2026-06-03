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
addi $sp, $sp, -1996               
li $t0, 1
move $t1, $t0
sw $t0, -12($fp)
move $t0, $t1
li $t2, 2
add $t3, $t0, $t2
sw $t0, -16($fp)
sw $t2, -20($fp)
move $t0, $t3
sw $t3, -24($fp)
move $t2, $t0
li $t3, 3
add $t4, $t2, $t3
sw $t2, -28($fp)
sw $t3, -32($fp)
move $t2, $t4
sw $t4, -36($fp)
move $t3, $t2
li $t4, 4
add $t5, $t3, $t4
sw $t3, -40($fp)
sw $t4, -44($fp)
move $t3, $t5
sw $t5, -48($fp)
move $t4, $t3
li $t5, 5
add $t6, $t4, $t5
sw $t4, -52($fp)
sw $t5, -56($fp)
move $t4, $t6
sw $t6, -60($fp)
move $t5, $t4
li $t6, 6
add $t7, $t5, $t6
sw $t5, -64($fp)
sw $t6, -68($fp)
move $t5, $t7
sw $t7, -72($fp)
move $t6, $t5
li $t7, 7
add $t8, $t6, $t7
sw $t6, -76($fp)
sw $t7, -80($fp)
move $t6, $t8
sw $t8, -84($fp)
move $t7, $t6
li $t8, 8
add $t9, $t7, $t8
sw $t7, -88($fp)
sw $t8, -92($fp)
move $t7, $t9
sw $t9, -96($fp)
move $t8, $t7
li $t9, 9
add $s0, $t8, $t9
sw $t8, -100($fp)
sw $t9, -104($fp)
move $t8, $s0
sw $s0, -108($fp)
move $t9, $t8
li $s0, 10
add $s1, $t9, $s0
sw $t9, -112($fp)
sw $s0, -116($fp)
move $t9, $s1
sw $s1, -120($fp)
move $s0, $t9
li $s1, 11
add $s2, $s0, $s1
sw $s0, -124($fp)
sw $s1, -128($fp)
move $s0, $s2
sw $s2, -132($fp)
move $s1, $s0
li $s2, 12
add $s3, $s1, $s2
sw $s1, -136($fp)
sw $s2, -140($fp)
move $s1, $s3
sw $s3, -144($fp)
move $s2, $s1
li $s3, 13
add $s4, $s2, $s3
sw $s2, -148($fp)
sw $s3, -152($fp)
move $s2, $s4
sw $s4, -156($fp)
move $s3, $s2
li $s4, 14
add $s5, $s3, $s4
sw $s3, -160($fp)
sw $s4, -164($fp)
move $s3, $s5
sw $s5, -168($fp)
move $s4, $s3
li $s5, 15
add $s6, $s4, $s5
sw $s4, -172($fp)
sw $s5, -176($fp)
move $s4, $s6
sw $s6, -180($fp)
move $s5, $s4
li $s6, 16
add $s7, $s5, $s6
sw $s5, -184($fp)
sw $s6, -188($fp)
move $s5, $s7
sw $s7, -192($fp)
move $s6, $s5
li $s7, 17
add $v1, $s6, $s7
sw $s6, -196($fp)
sw $s7, -200($fp)
move $s6, $v1
sw $v1, -204($fp)
move $s7, $s6
li $v1, 18
sw $s6, -208($fp)
add $s6, $s7, $v1
sw $s7, -212($fp)
sw $v1, -216($fp)
move $s7, $s6
sw $s6, -220($fp)
move $s6, $s7
li $v1, 19
sw $s7, -224($fp)
add $s7, $s6, $v1
sw $s6, -228($fp)
sw $v1, -232($fp)
move $s6, $s7
sw $s7, -236($fp)
move $s7, $s6
li $v1, 20
sw $s6, -240($fp)
add $s6, $s7, $v1
sw $s7, -244($fp)
sw $v1, -248($fp)
move $s7, $s6
sw $s6, -252($fp)
move $s6, $s7
li $v1, 21
sw $s7, -256($fp)
add $s7, $s6, $v1
sw $s6, -260($fp)
sw $v1, -264($fp)
move $s6, $s7
sw $s7, -268($fp)
move $s7, $s6
li $v1, 22
sw $s6, -272($fp)
add $s6, $s7, $v1
sw $s7, -276($fp)
sw $v1, -280($fp)
move $s7, $s6
sw $s6, -284($fp)
move $s6, $s7
li $v1, 23
sw $s7, -288($fp)
add $s7, $s6, $v1
sw $s6, -292($fp)
sw $v1, -296($fp)
move $s6, $s7
sw $s7, -300($fp)
move $s7, $s6
li $v1, 24
sw $s6, -304($fp)
add $s6, $s7, $v1
sw $s7, -308($fp)
sw $v1, -312($fp)
move $s7, $s6
sw $s6, -316($fp)
move $s6, $s7
li $v1, 25
sw $s7, -320($fp)
add $s7, $s6, $v1
sw $s6, -324($fp)
sw $v1, -328($fp)
move $s6, $s7
sw $s7, -332($fp)
move $s7, $s6
li $v1, 26
sw $s6, -336($fp)
add $s6, $s7, $v1
sw $s7, -340($fp)
sw $v1, -344($fp)
move $s7, $s6
sw $s6, -348($fp)
move $s6, $s7
li $v1, 27
sw $s7, -352($fp)
add $s7, $s6, $v1
sw $s6, -356($fp)
sw $v1, -360($fp)
move $s6, $s7
sw $s7, -364($fp)
move $s7, $s6
li $v1, 28
sw $s6, -368($fp)
add $s6, $s7, $v1
sw $s7, -372($fp)
sw $v1, -376($fp)
move $s7, $s6
sw $s6, -380($fp)
move $s6, $s7
li $v1, 29
sw $s7, -384($fp)
add $s7, $s6, $v1
sw $s6, -388($fp)
sw $v1, -392($fp)
move $s6, $s7
sw $s7, -396($fp)
move $s7, $s6
li $v1, 30
sw $s6, -400($fp)
add $s6, $s7, $v1
sw $s7, -404($fp)
sw $v1, -408($fp)
move $s7, $s6
sw $s6, -412($fp)
move $s6, $s7
li $v1, 31
sw $s7, -416($fp)
add $s7, $s6, $v1
sw $s6, -420($fp)
sw $v1, -424($fp)
move $s6, $s7
sw $s7, -428($fp)
move $s7, $s6
li $v1, 32
sw $s6, -432($fp)
add $s6, $s7, $v1
sw $s7, -436($fp)
sw $v1, -440($fp)
move $s7, $s6
sw $s6, -444($fp)
move $s6, $s7
li $v1, 33
sw $s7, -448($fp)
add $s7, $s6, $v1
sw $s6, -452($fp)
sw $v1, -456($fp)
move $s6, $s7
sw $s7, -460($fp)
move $s7, $s6
li $v1, 34
sw $s6, -464($fp)
add $s6, $s7, $v1
sw $s7, -468($fp)
sw $v1, -472($fp)
move $s7, $s6
sw $s6, -476($fp)
move $s6, $s7
li $v1, 35
sw $s7, -480($fp)
add $s7, $s6, $v1
sw $s6, -484($fp)
sw $v1, -488($fp)
move $s6, $s7
sw $s7, -492($fp)
move $s7, $s6
li $v1, 36
sw $s6, -496($fp)
add $s6, $s7, $v1
sw $s7, -500($fp)
sw $v1, -504($fp)
move $s7, $s6
sw $s6, -508($fp)
move $s6, $s7
li $v1, 37
sw $s7, -512($fp)
add $s7, $s6, $v1
sw $s6, -516($fp)
sw $v1, -520($fp)
move $s6, $s7
sw $s7, -524($fp)
move $s7, $s6
li $v1, 38
sw $s6, -528($fp)
add $s6, $s7, $v1
sw $s7, -532($fp)
sw $v1, -536($fp)
move $s7, $s6
sw $s6, -540($fp)
move $s6, $s7
li $v1, 39
sw $s7, -544($fp)
add $s7, $s6, $v1
sw $s6, -548($fp)
sw $v1, -552($fp)
move $s6, $s7
sw $s7, -556($fp)
move $s7, $s6
li $v1, 40
sw $s6, -560($fp)
add $s6, $s7, $v1
sw $s7, -564($fp)
sw $v1, -568($fp)
move $s7, $s6
sw $s6, -572($fp)
move $s6, $s7
li $v1, 41
sw $s7, -576($fp)
add $s7, $s6, $v1
sw $s6, -580($fp)
sw $v1, -584($fp)
move $s6, $s7
sw $s7, -588($fp)
move $s7, $s6
li $v1, 42
sw $s6, -592($fp)
add $s6, $s7, $v1
sw $s7, -596($fp)
sw $v1, -600($fp)
move $s7, $s6
sw $s6, -604($fp)
move $s6, $s7
li $v1, 43
sw $s7, -608($fp)
add $s7, $s6, $v1
sw $s6, -612($fp)
sw $v1, -616($fp)
move $s6, $s7
sw $s7, -620($fp)
move $s7, $s6
li $v1, 44
sw $s6, -624($fp)
add $s6, $s7, $v1
sw $s7, -628($fp)
sw $v1, -632($fp)
move $s7, $s6
sw $s6, -636($fp)
move $s6, $s7
li $v1, 45
sw $s7, -640($fp)
add $s7, $s6, $v1
sw $s6, -644($fp)
sw $v1, -648($fp)
move $s6, $s7
sw $s7, -652($fp)
move $s7, $s6
li $v1, 46
sw $s6, -656($fp)
add $s6, $s7, $v1
sw $s7, -660($fp)
sw $v1, -664($fp)
move $s7, $s6
sw $s6, -668($fp)
move $s6, $s7
li $v1, 47
sw $s7, -672($fp)
add $s7, $s6, $v1
sw $s6, -676($fp)
sw $v1, -680($fp)
move $s6, $s7
sw $s7, -684($fp)
move $s7, $s6
li $v1, 48
sw $s6, -688($fp)
add $s6, $s7, $v1
sw $s7, -692($fp)
sw $v1, -696($fp)
move $s7, $s6
sw $s6, -700($fp)
move $s6, $s7
li $v1, 49
sw $s7, -704($fp)
add $s7, $s6, $v1
sw $s6, -708($fp)
sw $v1, -712($fp)
move $s6, $s7
sw $s7, -716($fp)
move $s7, $s6
li $v1, 50
sw $s6, -720($fp)
add $s6, $s7, $v1
sw $s7, -724($fp)
sw $v1, -728($fp)
move $s7, $s6
sw $s6, -732($fp)
move $s6, $s7
li $v1, 51
sw $s7, -736($fp)
add $s7, $s6, $v1
sw $s6, -740($fp)
sw $v1, -744($fp)
move $s6, $s7
sw $s7, -748($fp)
move $s7, $s6
li $v1, 52
sw $s6, -752($fp)
add $s6, $s7, $v1
sw $s7, -756($fp)
sw $v1, -760($fp)
move $s7, $s6
sw $s6, -764($fp)
move $s6, $s7
li $v1, 53
sw $s7, -768($fp)
add $s7, $s6, $v1
sw $s6, -772($fp)
sw $v1, -776($fp)
move $s6, $s7
sw $s7, -780($fp)
move $s7, $s6
li $v1, 54
sw $s6, -784($fp)
add $s6, $s7, $v1
sw $s7, -788($fp)
sw $v1, -792($fp)
move $s7, $s6
sw $s6, -796($fp)
move $s6, $s7
li $v1, 55
sw $s7, -800($fp)
add $s7, $s6, $v1
sw $s6, -804($fp)
sw $v1, -808($fp)
move $s6, $s7
sw $s7, -812($fp)
move $s7, $s6
li $v1, 56
sw $s6, -816($fp)
add $s6, $s7, $v1
sw $s7, -820($fp)
sw $v1, -824($fp)
move $s7, $s6
sw $s6, -828($fp)
move $s6, $s7
li $v1, 57
sw $s7, -832($fp)
add $s7, $s6, $v1
sw $s6, -836($fp)
sw $v1, -840($fp)
move $s6, $s7
sw $s7, -844($fp)
move $s7, $s6
li $v1, 58
sw $s6, -848($fp)
add $s6, $s7, $v1
sw $s7, -852($fp)
sw $v1, -856($fp)
move $s7, $s6
sw $s6, -860($fp)
move $s6, $s7
li $v1, 59
sw $s7, -864($fp)
add $s7, $s6, $v1
sw $s6, -868($fp)
sw $v1, -872($fp)
move $s6, $s7
sw $s7, -876($fp)
move $s7, $s6
li $v1, 60
sw $s6, -880($fp)
add $s6, $s7, $v1
sw $s7, -884($fp)
sw $v1, -888($fp)
move $s7, $s6
sw $s6, -892($fp)
move $s6, $s7
li $v1, 61
sw $s7, -896($fp)
add $s7, $s6, $v1
sw $s6, -900($fp)
sw $v1, -904($fp)
move $s6, $s7
sw $s7, -908($fp)
move $s7, $s6
li $v1, 62
sw $s6, -912($fp)
add $s6, $s7, $v1
sw $s7, -916($fp)
sw $v1, -920($fp)
move $s7, $s6
sw $s6, -924($fp)
move $s6, $s7
li $v1, 63
sw $s7, -928($fp)
add $s7, $s6, $v1
sw $s6, -932($fp)
sw $v1, -936($fp)
move $s6, $s7
sw $s7, -940($fp)
move $s7, $s6
li $v1, 64
sw $s6, -944($fp)
add $s6, $s7, $v1
sw $s7, -948($fp)
sw $v1, -952($fp)
move $s7, $s6
sw $s6, -956($fp)
move $s6, $s7
li $v1, 65
sw $s7, -960($fp)
add $s7, $s6, $v1
sw $s6, -964($fp)
sw $v1, -968($fp)
move $s6, $s7
sw $s7, -972($fp)
move $s7, $s6
li $v1, 66
sw $s6, -976($fp)
add $s6, $s7, $v1
sw $s7, -980($fp)
sw $v1, -984($fp)
move $s7, $s6
sw $s6, -988($fp)
move $s6, $s7
li $v1, 67
sw $s7, -992($fp)
add $s7, $s6, $v1
sw $s6, -996($fp)
sw $v1, -1000($fp)
move $s6, $s7
sw $s7, -1004($fp)
move $s7, $s6
li $v1, 68
sw $s6, -1008($fp)
add $s6, $s7, $v1
sw $s7, -1012($fp)
sw $v1, -1016($fp)
move $s7, $s6
sw $s6, -1020($fp)
move $s6, $s7
li $v1, 69
sw $s7, -1024($fp)
add $s7, $s6, $v1
sw $s6, -1028($fp)
sw $v1, -1032($fp)
move $s6, $s7
sw $s7, -1036($fp)
move $s7, $s6
li $v1, 70
sw $s6, -1040($fp)
add $s6, $s7, $v1
sw $s7, -1044($fp)
sw $v1, -1048($fp)
move $s7, $s6
sw $s6, -1052($fp)
move $s6, $s7
li $v1, 71
sw $s7, -1056($fp)
add $s7, $s6, $v1
sw $s6, -1060($fp)
sw $v1, -1064($fp)
move $s6, $s7
sw $s7, -1068($fp)
move $s7, $s6
li $v1, 72
sw $s6, -1072($fp)
add $s6, $s7, $v1
sw $s7, -1076($fp)
sw $v1, -1080($fp)
move $s7, $s6
sw $s6, -1084($fp)
move $s6, $s7
li $v1, 73
sw $s7, -1088($fp)
add $s7, $s6, $v1
sw $s6, -1092($fp)
sw $v1, -1096($fp)
move $s6, $s7
sw $s7, -1100($fp)
move $s7, $s6
li $v1, 74
sw $s6, -1104($fp)
add $s6, $s7, $v1
sw $s7, -1108($fp)
sw $v1, -1112($fp)
move $s7, $s6
sw $s6, -1116($fp)
move $s6, $s7
li $v1, 75
sw $s7, -1120($fp)
add $s7, $s6, $v1
sw $s6, -1124($fp)
sw $v1, -1128($fp)
move $s6, $s7
sw $s7, -1132($fp)
move $s7, $s6
li $v1, 76
sw $s6, -1136($fp)
add $s6, $s7, $v1
sw $s7, -1140($fp)
sw $v1, -1144($fp)
move $s7, $s6
sw $s6, -1148($fp)
move $s6, $s7
li $v1, 77
sw $s7, -1152($fp)
add $s7, $s6, $v1
sw $s6, -1156($fp)
sw $v1, -1160($fp)
move $s6, $s7
sw $s7, -1164($fp)
move $s7, $s6
li $v1, 78
sw $s6, -1168($fp)
add $s6, $s7, $v1
sw $s7, -1172($fp)
sw $v1, -1176($fp)
move $s7, $s6
sw $s6, -1180($fp)
move $s6, $s7
li $v1, 79
sw $s7, -1184($fp)
add $s7, $s6, $v1
sw $s6, -1188($fp)
sw $v1, -1192($fp)
move $s6, $s7
sw $s7, -1196($fp)
move $s7, $s6
li $v1, 80
sw $s6, -1200($fp)
add $s6, $s7, $v1
sw $s7, -1204($fp)
sw $v1, -1208($fp)
move $s7, $s6
sw $s6, -1212($fp)
move $s6, $s7
li $v1, 81
sw $s7, -1216($fp)
add $s7, $s6, $v1
sw $s6, -1220($fp)
sw $v1, -1224($fp)
move $s6, $s7
sw $s7, -1228($fp)
move $s7, $s6
li $v1, 82
sw $s6, -1232($fp)
add $s6, $s7, $v1
sw $s7, -1236($fp)
sw $v1, -1240($fp)
move $s7, $s6
sw $s6, -1244($fp)
move $s6, $s7
li $v1, 83
sw $s7, -1248($fp)
add $s7, $s6, $v1
sw $s6, -1252($fp)
sw $v1, -1256($fp)
move $s6, $s7
sw $s7, -1260($fp)
move $s7, $s6
li $v1, 84
sw $s6, -1264($fp)
add $s6, $s7, $v1
sw $s7, -1268($fp)
sw $v1, -1272($fp)
move $s7, $s6
sw $s6, -1276($fp)
move $s6, $s7
li $v1, 85
sw $s7, -1280($fp)
add $s7, $s6, $v1
sw $s6, -1284($fp)
sw $v1, -1288($fp)
move $s6, $s7
sw $s7, -1292($fp)
move $s7, $s6
li $v1, 86
sw $s6, -1296($fp)
add $s6, $s7, $v1
sw $s7, -1300($fp)
sw $v1, -1304($fp)
move $s7, $s6
sw $s6, -1308($fp)
move $s6, $s7
li $v1, 87
sw $s7, -1312($fp)
add $s7, $s6, $v1
sw $s6, -1316($fp)
sw $v1, -1320($fp)
move $s6, $s7
sw $s7, -1324($fp)
move $s7, $s6
li $v1, 88
sw $s6, -1328($fp)
add $s6, $s7, $v1
sw $s7, -1332($fp)
sw $v1, -1336($fp)
move $s7, $s6
sw $s6, -1340($fp)
move $s6, $s7
li $v1, 89
sw $s7, -1344($fp)
add $s7, $s6, $v1
sw $s6, -1348($fp)
sw $v1, -1352($fp)
move $s6, $s7
sw $s7, -1356($fp)
move $s7, $s6
li $v1, 90
sw $s6, -1360($fp)
add $s6, $s7, $v1
sw $s7, -1364($fp)
sw $v1, -1368($fp)
move $s7, $s6
sw $s6, -1372($fp)
move $s6, $s7
li $v1, 91
sw $s7, -1376($fp)
add $s7, $s6, $v1
sw $s6, -1380($fp)
sw $v1, -1384($fp)
move $s6, $s7
sw $s7, -1388($fp)
move $s7, $s6
li $v1, 92
sw $s6, -1392($fp)
add $s6, $s7, $v1
sw $s7, -1396($fp)
sw $v1, -1400($fp)
move $s7, $s6
sw $s6, -1404($fp)
move $s6, $s7
li $v1, 93
sw $s7, -1408($fp)
add $s7, $s6, $v1
sw $s6, -1412($fp)
sw $v1, -1416($fp)
move $s6, $s7
sw $s7, -1420($fp)
move $s7, $s6
li $v1, 94
sw $s6, -1424($fp)
add $s6, $s7, $v1
sw $s7, -1428($fp)
sw $v1, -1432($fp)
move $s7, $s6
sw $s6, -1436($fp)
move $s6, $s7
li $v1, 95
sw $s7, -1440($fp)
add $s7, $s6, $v1
sw $s6, -1444($fp)
sw $v1, -1448($fp)
move $s6, $s7
sw $s7, -1452($fp)
move $s7, $s6
li $v1, 96
sw $s6, -1456($fp)
add $s6, $s7, $v1
sw $s7, -1460($fp)
sw $v1, -1464($fp)
move $s7, $s6
sw $s6, -1468($fp)
move $s6, $s7
li $v1, 97
sw $s7, -1472($fp)
add $s7, $s6, $v1
sw $s6, -1476($fp)
sw $v1, -1480($fp)
move $s6, $s7
sw $s7, -1484($fp)
move $s7, $s6
li $v1, 98
sw $s6, -1488($fp)
add $s6, $s7, $v1
sw $s7, -1492($fp)
sw $v1, -1496($fp)
move $s7, $s6
sw $s6, -1500($fp)
move $s6, $s7
li $v1, 99
sw $s7, -1504($fp)
add $s7, $s6, $v1
sw $s6, -1508($fp)
sw $v1, -1512($fp)
move $s6, $s7
sw $s7, -1516($fp)
move $s7, $s6
li $v1, 100
sw $s6, -1520($fp)
add $s6, $s7, $v1
sw $s7, -1524($fp)
sw $v1, -1528($fp)
move $s7, $s6
sw $s6, -1532($fp)
move $s6, $t1
sw $t1, -1536($fp)
move $a0, $s6
jal write
sw $s6, -1540($fp)
move $t1, $t0
sw $t0, -1544($fp)
move $a0, $t1
jal write
sw $t1, -1548($fp)
move $t0, $t2
sw $t2, -1552($fp)
move $a0, $t0
jal write
sw $t0, -1556($fp)
move $t0, $t3
sw $t3, -1560($fp)
move $a0, $t0
jal write
sw $t0, -1564($fp)
move $t0, $t4
sw $t4, -1568($fp)
move $a0, $t0
jal write
sw $t0, -1572($fp)
move $t0, $t5
sw $t5, -1576($fp)
move $a0, $t0
jal write
sw $t0, -1580($fp)
move $t0, $t6
sw $t6, -1584($fp)
move $a0, $t0
jal write
sw $t0, -1588($fp)
move $t0, $t7
sw $t7, -1592($fp)
move $a0, $t0
jal write
sw $t0, -1596($fp)
move $t0, $t8
sw $t8, -1600($fp)
move $a0, $t0
jal write
sw $t0, -1604($fp)
move $t0, $t9
sw $t9, -1608($fp)
move $a0, $t0
jal write
sw $t0, -1612($fp)
move $t0, $s0
sw $s0, -1616($fp)
move $a0, $t0
jal write
sw $t0, -1620($fp)
move $t0, $s1
sw $s1, -1624($fp)
move $a0, $t0
jal write
sw $t0, -1628($fp)
move $t0, $s2
sw $s2, -1632($fp)
move $a0, $t0
jal write
sw $t0, -1636($fp)
move $t0, $s3
sw $s3, -1640($fp)
move $a0, $t0
jal write
sw $t0, -1644($fp)
move $t0, $s4
sw $s4, -1648($fp)
move $a0, $t0
jal write
sw $t0, -1652($fp)
move $t0, $s5
sw $s5, -1656($fp)
move $a0, $t0
jal write
sw $t0, -1660($fp)
lw $t0, -208($fp)
move $t1, $t0
sw $t0, -208($fp)
move $a0, $t1
jal write
sw $t1, -1664($fp)
lw $t0, -224($fp)
move $t1, $t0
sw $t0, -224($fp)
move $a0, $t1
jal write
sw $t1, -1668($fp)
lw $t0, -240($fp)
move $t1, $t0
sw $t0, -240($fp)
move $a0, $t1
jal write
sw $t1, -1672($fp)
lw $t0, -256($fp)
move $t1, $t0
sw $t0, -256($fp)
move $a0, $t1
jal write
sw $t1, -1676($fp)
lw $t0, -272($fp)
move $t1, $t0
sw $t0, -272($fp)
move $a0, $t1
jal write
sw $t1, -1680($fp)
lw $t0, -288($fp)
move $t1, $t0
sw $t0, -288($fp)
move $a0, $t1
jal write
sw $t1, -1684($fp)
lw $t0, -304($fp)
move $t1, $t0
sw $t0, -304($fp)
move $a0, $t1
jal write
sw $t1, -1688($fp)
lw $t0, -320($fp)
move $t1, $t0
sw $t0, -320($fp)
move $a0, $t1
jal write
sw $t1, -1692($fp)
lw $t0, -336($fp)
move $t1, $t0
sw $t0, -336($fp)
move $a0, $t1
jal write
sw $t1, -1696($fp)
lw $t0, -352($fp)
move $t1, $t0
sw $t0, -352($fp)
move $a0, $t1
jal write
sw $t1, -1700($fp)
lw $t0, -368($fp)
move $t1, $t0
sw $t0, -368($fp)
move $a0, $t1
jal write
sw $t1, -1704($fp)
lw $t0, -384($fp)
move $t1, $t0
sw $t0, -384($fp)
move $a0, $t1
jal write
sw $t1, -1708($fp)
lw $t0, -400($fp)
move $t1, $t0
sw $t0, -400($fp)
move $a0, $t1
jal write
sw $t1, -1712($fp)
lw $t0, -416($fp)
move $t1, $t0
sw $t0, -416($fp)
move $a0, $t1
jal write
sw $t1, -1716($fp)
lw $t0, -432($fp)
move $t1, $t0
sw $t0, -432($fp)
move $a0, $t1
jal write
sw $t1, -1720($fp)
lw $t0, -448($fp)
move $t1, $t0
sw $t0, -448($fp)
move $a0, $t1
jal write
sw $t1, -1724($fp)
lw $t0, -464($fp)
move $t1, $t0
sw $t0, -464($fp)
move $a0, $t1
jal write
sw $t1, -1728($fp)
lw $t0, -480($fp)
move $t1, $t0
sw $t0, -480($fp)
move $a0, $t1
jal write
sw $t1, -1732($fp)
lw $t0, -496($fp)
move $t1, $t0
sw $t0, -496($fp)
move $a0, $t1
jal write
sw $t1, -1736($fp)
lw $t0, -512($fp)
move $t1, $t0
sw $t0, -512($fp)
move $a0, $t1
jal write
sw $t1, -1740($fp)
lw $t0, -528($fp)
move $t1, $t0
sw $t0, -528($fp)
move $a0, $t1
jal write
sw $t1, -1744($fp)
lw $t0, -544($fp)
move $t1, $t0
sw $t0, -544($fp)
move $a0, $t1
jal write
sw $t1, -1748($fp)
lw $t0, -560($fp)
move $t1, $t0
sw $t0, -560($fp)
move $a0, $t1
jal write
sw $t1, -1752($fp)
lw $t0, -576($fp)
move $t1, $t0
sw $t0, -576($fp)
move $a0, $t1
jal write
sw $t1, -1756($fp)
lw $t0, -592($fp)
move $t1, $t0
sw $t0, -592($fp)
move $a0, $t1
jal write
sw $t1, -1760($fp)
lw $t0, -608($fp)
move $t1, $t0
sw $t0, -608($fp)
move $a0, $t1
jal write
sw $t1, -1764($fp)
lw $t0, -624($fp)
move $t1, $t0
sw $t0, -624($fp)
move $a0, $t1
jal write
sw $t1, -1768($fp)
lw $t0, -640($fp)
move $t1, $t0
sw $t0, -640($fp)
move $a0, $t1
jal write
sw $t1, -1772($fp)
lw $t0, -656($fp)
move $t1, $t0
sw $t0, -656($fp)
move $a0, $t1
jal write
sw $t1, -1776($fp)
lw $t0, -672($fp)
move $t1, $t0
sw $t0, -672($fp)
move $a0, $t1
jal write
sw $t1, -1780($fp)
lw $t0, -688($fp)
move $t1, $t0
sw $t0, -688($fp)
move $a0, $t1
jal write
sw $t1, -1784($fp)
lw $t0, -704($fp)
move $t1, $t0
sw $t0, -704($fp)
move $a0, $t1
jal write
sw $t1, -1788($fp)
lw $t0, -720($fp)
move $t1, $t0
sw $t0, -720($fp)
move $a0, $t1
jal write
sw $t1, -1792($fp)
lw $t0, -736($fp)
move $t1, $t0
sw $t0, -736($fp)
move $a0, $t1
jal write
sw $t1, -1796($fp)
lw $t0, -752($fp)
move $t1, $t0
sw $t0, -752($fp)
move $a0, $t1
jal write
sw $t1, -1800($fp)
lw $t0, -768($fp)
move $t1, $t0
sw $t0, -768($fp)
move $a0, $t1
jal write
sw $t1, -1804($fp)
lw $t0, -784($fp)
move $t1, $t0
sw $t0, -784($fp)
move $a0, $t1
jal write
sw $t1, -1808($fp)
lw $t0, -800($fp)
move $t1, $t0
sw $t0, -800($fp)
move $a0, $t1
jal write
sw $t1, -1812($fp)
lw $t0, -816($fp)
move $t1, $t0
sw $t0, -816($fp)
move $a0, $t1
jal write
sw $t1, -1816($fp)
lw $t0, -832($fp)
move $t1, $t0
sw $t0, -832($fp)
move $a0, $t1
jal write
sw $t1, -1820($fp)
lw $t0, -848($fp)
move $t1, $t0
sw $t0, -848($fp)
move $a0, $t1
jal write
sw $t1, -1824($fp)
lw $t0, -864($fp)
move $t1, $t0
sw $t0, -864($fp)
move $a0, $t1
jal write
sw $t1, -1828($fp)
lw $t0, -880($fp)
move $t1, $t0
sw $t0, -880($fp)
move $a0, $t1
jal write
sw $t1, -1832($fp)
lw $t0, -896($fp)
move $t1, $t0
sw $t0, -896($fp)
move $a0, $t1
jal write
sw $t1, -1836($fp)
lw $t0, -912($fp)
move $t1, $t0
sw $t0, -912($fp)
move $a0, $t1
jal write
sw $t1, -1840($fp)
lw $t0, -928($fp)
move $t1, $t0
sw $t0, -928($fp)
move $a0, $t1
jal write
sw $t1, -1844($fp)
lw $t0, -944($fp)
move $t1, $t0
sw $t0, -944($fp)
move $a0, $t1
jal write
sw $t1, -1848($fp)
lw $t0, -960($fp)
move $t1, $t0
sw $t0, -960($fp)
move $a0, $t1
jal write
sw $t1, -1852($fp)
lw $t0, -976($fp)
move $t1, $t0
sw $t0, -976($fp)
move $a0, $t1
jal write
sw $t1, -1856($fp)
lw $t0, -992($fp)
move $t1, $t0
sw $t0, -992($fp)
move $a0, $t1
jal write
sw $t1, -1860($fp)
lw $t0, -1008($fp)
move $t1, $t0
sw $t0, -1008($fp)
move $a0, $t1
jal write
sw $t1, -1864($fp)
lw $t0, -1024($fp)
move $t1, $t0
sw $t0, -1024($fp)
move $a0, $t1
jal write
sw $t1, -1868($fp)
lw $t0, -1040($fp)
move $t1, $t0
sw $t0, -1040($fp)
move $a0, $t1
jal write
sw $t1, -1872($fp)
lw $t0, -1056($fp)
move $t1, $t0
sw $t0, -1056($fp)
move $a0, $t1
jal write
sw $t1, -1876($fp)
lw $t0, -1072($fp)
move $t1, $t0
sw $t0, -1072($fp)
move $a0, $t1
jal write
sw $t1, -1880($fp)
lw $t0, -1088($fp)
move $t1, $t0
sw $t0, -1088($fp)
move $a0, $t1
jal write
sw $t1, -1884($fp)
lw $t0, -1104($fp)
move $t1, $t0
sw $t0, -1104($fp)
move $a0, $t1
jal write
sw $t1, -1888($fp)
lw $t0, -1120($fp)
move $t1, $t0
sw $t0, -1120($fp)
move $a0, $t1
jal write
sw $t1, -1892($fp)
lw $t0, -1136($fp)
move $t1, $t0
sw $t0, -1136($fp)
move $a0, $t1
jal write
sw $t1, -1896($fp)
lw $t0, -1152($fp)
move $t1, $t0
sw $t0, -1152($fp)
move $a0, $t1
jal write
sw $t1, -1900($fp)
lw $t0, -1168($fp)
move $t1, $t0
sw $t0, -1168($fp)
move $a0, $t1
jal write
sw $t1, -1904($fp)
lw $t0, -1184($fp)
move $t1, $t0
sw $t0, -1184($fp)
move $a0, $t1
jal write
sw $t1, -1908($fp)
lw $t0, -1200($fp)
move $t1, $t0
sw $t0, -1200($fp)
move $a0, $t1
jal write
sw $t1, -1912($fp)
lw $t0, -1216($fp)
move $t1, $t0
sw $t0, -1216($fp)
move $a0, $t1
jal write
sw $t1, -1916($fp)
lw $t0, -1232($fp)
move $t1, $t0
sw $t0, -1232($fp)
move $a0, $t1
jal write
sw $t1, -1920($fp)
lw $t0, -1248($fp)
move $t1, $t0
sw $t0, -1248($fp)
move $a0, $t1
jal write
sw $t1, -1924($fp)
lw $t0, -1264($fp)
move $t1, $t0
sw $t0, -1264($fp)
move $a0, $t1
jal write
sw $t1, -1928($fp)
lw $t0, -1280($fp)
move $t1, $t0
sw $t0, -1280($fp)
move $a0, $t1
jal write
sw $t1, -1932($fp)
lw $t0, -1296($fp)
move $t1, $t0
sw $t0, -1296($fp)
move $a0, $t1
jal write
sw $t1, -1936($fp)
lw $t0, -1312($fp)
move $t1, $t0
sw $t0, -1312($fp)
move $a0, $t1
jal write
sw $t1, -1940($fp)
lw $t0, -1328($fp)
move $t1, $t0
sw $t0, -1328($fp)
move $a0, $t1
jal write
sw $t1, -1944($fp)
lw $t0, -1344($fp)
move $t1, $t0
sw $t0, -1344($fp)
move $a0, $t1
jal write
sw $t1, -1948($fp)
lw $t0, -1360($fp)
move $t1, $t0
sw $t0, -1360($fp)
move $a0, $t1
jal write
sw $t1, -1952($fp)
lw $t0, -1376($fp)
move $t1, $t0
sw $t0, -1376($fp)
move $a0, $t1
jal write
sw $t1, -1956($fp)
lw $t0, -1392($fp)
move $t1, $t0
sw $t0, -1392($fp)
move $a0, $t1
jal write
sw $t1, -1960($fp)
lw $t0, -1408($fp)
move $t1, $t0
sw $t0, -1408($fp)
move $a0, $t1
jal write
sw $t1, -1964($fp)
lw $t0, -1424($fp)
move $t1, $t0
sw $t0, -1424($fp)
move $a0, $t1
jal write
sw $t1, -1968($fp)
lw $t0, -1440($fp)
move $t1, $t0
sw $t0, -1440($fp)
move $a0, $t1
jal write
sw $t1, -1972($fp)
lw $t0, -1456($fp)
move $t1, $t0
sw $t0, -1456($fp)
move $a0, $t1
jal write
sw $t1, -1976($fp)
lw $t0, -1472($fp)
move $t1, $t0
sw $t0, -1472($fp)
move $a0, $t1
jal write
sw $t1, -1980($fp)
lw $t0, -1488($fp)
move $t1, $t0
sw $t0, -1488($fp)
move $a0, $t1
jal write
sw $t1, -1984($fp)
lw $t0, -1504($fp)
move $t1, $t0
sw $t0, -1504($fp)
move $a0, $t1
jal write
sw $t1, -1988($fp)
lw $t0, -1520($fp)
move $t1, $t0
sw $t0, -1520($fp)
move $a0, $t1
jal write
sw $t1, -1992($fp)
move $t0, $s7
sw $s7, -1996($fp)
move $a0, $t0
jal write
sw $t0, -2000($fp)
li $t0, 0
sw $t0, -2004($fp)
lw $v0, -2004($fp)
j ret_main
ret_main:
lw $ra, -4($fp)
lw $fp, -8($fp)
addi $sp, $sp, 2004
jr $ra
