.text

lw x1, 0(x0)   # 17 (0)
lw x2, 4(x0)   # 9  (4)
lw x3, 8(x0)   # 25 (8)

or x4, x1, x2  # 25  (12)
beq x4, x3, jumb  # yes --> goto 24  (16)
add x3, x3, x2 # 34 should be skipped ,so x3 = 25 (20) --> NOP

jumb:
sub x5, x3, x2 # 17 (24) --> stalling the pc for one cycle 
sw x5, 12(x0)  #    (28)  // 16 in mem

jal loop   	#   (32) goto 44 from 32 // x1 = 40 
addi x4,x0,10  #    (36) 35 skipped
sub  x3,x3,x0   #   (40) 25 skipped

loop:           #   (44) 
lw x6, 12(x0)  #    (48) 16
bne x6,x5,exit #    (52) continue
and x7, x6, x1 #    (56)   0
sub x8, x1, x2 #    (60)   31
auipc x10,100  #    (64)  x10 = pc + 20upper = current pc = 60 --> 409664
lui   x11,1000000 # (68)  -198967296 = 
blt x10,x11,store # (72)   no
or x30,x3,x2  	#   (76)   25

store :
sb x11,12(x0)  	#   (80)     
sh x11,16(x0)  	#   (84)     

bge x3,x2,load 	#   (88)  yes --> load
addi x4,x0,10  #    (92)  35 skipped NOP
sub  x3,x3,x0  #    (96)  28 skipped NOP

load:
lb  x20,16(x0)      (100) 
lh  x21,16(x0)      (104) 
lbu x22,16(x0)      (108)
lhu x23,16(x0)      (112)
bgeu x20,x21,exit   (116) exit
bltu x20,x21,store  (120)
exit:
ebreak              (124) NOP
ecall               (128) 
