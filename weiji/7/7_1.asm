CODE SEGMENT
ASSUME CS:CODE

START:   
		 MOV DI,3000H
		 MOV AL,'a'
		 MOV [DI],AL
X0:      
		 INC DI
		 INC AL	
		 MOV [DI],AL	 
		 CMP AL,'z'
		 JNZ X0
		 
X1:      MOV AL,0B6H
         MOV DX,06C6H
         OUT DX,AL
         MOV AX,1000
         MOV DX,06C4H
         OUT DX,AL
         MOV AL,AH
         OUT DX,AL
         
X2:      MOV AL,7EH
         MOV DX,0602H
         OUT DX,AL
         MOV AL,35H
         OUT DX,AL
         
         MOV DI,4000H
         MOV SI,3000H
         MOV CX,26
         
X3:     
         
X4:      MOV DX,0602H
         IN  AL,DX
         AND AL,01H
         JZ  X4 
         
         MOV AL,[SI]
         MOV DX,0600H
         OUT DX,AL
       
X6:
         MOV DX,0600H
         IN  AL,DX
         MOV [DI],AL
         
         INC DI
         INC SI
         LOOP X3
         
         CODE ENDS
         END START