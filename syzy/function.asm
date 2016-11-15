;本文件中包含4个子程序:
;1. BCD2BIN: 将2位ASCII码形式的十进制数转换为二进制数
;2. BIN2BCD: 将小于99的二进制数转换为ASCII码形式十进制数
;3. HEX2ASC: 将一字节16进制数转换为ASCII码形式
;4. BSORT: 对字节类型的数据进行冒泡排序
;使用前请认真阅读子程序前的说明。


;==================================================
;BCD2BIN: 将2位ASCII码形式的十进制数转换为二进制数
;
;入口：SI指向ASCII码形式的两位十进制数
;
;出口：AL中有转换后的二进制数
;
;举例：ASC_NUM  DB  '12'
;      ...
;      LEA   SI, BUFF
;      CALL  BCD2BIN 
;      调用后(AL)=0CH
;==================================================
BCD2BIN  PROC
         MOV  AH,[SI]
         MOV  AL,[SI+1]
         SUB  AX,3030H
         AAD
         RET
BCD2BIN  ENDP

;==================================================
;BIN2BCD: 将小于99的二进制数转换为ASCII码形式十进制数
;
;入口：AL中有要转换的二进制数（00H-63H）
;
;出口：AH和AL的内容分别为十进制结果的十位数和个位数（ASCII码形式）
;
;举例：MOV   AL, 0CH
;      CALL  BIN2BCD 
;      调用后(AH)='1', (AL)='2'
;==================================================
BIN2BCD  PROC
         AAM
         ADD  AX,3030H
         RET
BIN2BCD  ENDP

;==================================================
;HEX2ASC: 将一字节16进制数转换为ASCII码形式
;
;入口：AL中有要转换的16进制数（00H-FFH）
;
;出口：AH和AL的内容分别为ASCII码形式的16进制数
;
;举例：MOV   AL, 9AH
;      CALL  HEX2ASC 
;      调用后(AH)='9', (AL)='A'
;==================================================
HEX2ASC  PROC
         PUSH CX
         MOV  AH,AL
         AND  AL,0FH
         CMP  AL,9
         JBE  H1
         ADD  AL,7
H1:      ADD  AL,30H
         MOV  CL,4
         SHR  AH,CL
         CMP  AH,9
         JBE  H2
         ADD  AH,7
H2:      ADD  AH,30H
         POP  CX
         RET
HEX2ASC  ENDP

;==================================================
;BSORT: 对字节类型的无符号数进行冒泡排序
;
;入口：(DI)=要排序数据的首地址，(BL)=数据个数
;
;出口：所有寄存器内容均不改变
;
;举例：BUFF  DB  9,4,1,3,7
;      ... 
;      LEA   DI, BUFF
;      MOV   BL, 5
;      CALL  BSORT
;      结果： BUFF中的5个数据变为9,7,4,3,1 
;==================================================
BSORT    PROC
         PUSH SI
         PUSH BX
         PUSH CX 
         DEC  BL
NEXT1:   MOV  SI,DI
         MOV  CL,BL
NEXT2:   LODSB
         CMP  AL,[SI]
         JNC  NEXT3
         MOV  AH,[SI]
         MOV  [SI-1],AH
         MOV  [SI],AL
NEXT3:   DEC  CL
         JNZ  NEXT2
         DEC  BL
         JNZ  NEXT1
         POP  CX
         POP  BX
         POP  SI
         RET
BSORT    ENDP
