CODE SEGMENT
	ASSUME CS:CODE
START:

MOV AL,0B6H;方式3
MOV DX,06C6H
OUT DX,AL
MOV AX,1000
MOV DX,06C4H
OUT DX,AL
MOV AL,AH
OUT DX,AL

MOV DX,0602H;控制口
MOV AL,7EH
OUT DX,AL
MOV AL,35H
OUT DX,AL
MOV DI, 4000H
MOV SI, 3000H
MOV CX,10
X1:MOV DX,0602H
IN AL,DX
AND AL,01H
JZ X1

MOV DX,0600H;数据口
MOV AL,[SI]
OUT DX,AL

Y1:MOV DX,0602H
IN AL,DX
AND AL,02H
JZ Y1
MOV DX,0600H
IN AL,DX
MOV [DI],AL
INC SI
INC DI
LOOP X1
  
MOV AH,4CH
INT 21H
     
CODE ENDS
   END START    
