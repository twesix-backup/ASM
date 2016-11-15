CODE  SEGMENT
      ASSUME CS:CODE
MAIN  PROC  FAR
L:    CLI
      MOV   DX,020H
      MOV   AL,00011011B
      OUT   DX,AL
      
      MOV   DX,021H
      MOV   AL,77H
      OUT   DX,AL
      
      MOV   AL,01H
      OUT   DX,AL
      
      MOV   AL,3FH
      OUT   DX,AL
      STI
      
      CLI
      MOV   AX,0
      MOV   ES,AX
      MOV   DI,1DCH
      MOV   AX,OFFSET   LEFT
      CLD
      STOSW
      MOV  AX,SEG  LEFT
      STOSW
      STI
      
      CLI
      MOV  AX,0
      MOV  ES,AX
      MOV  DI,1D8H
      MOV  AX,OFFSET  RIGHT
      CLD
      STOSW
      MOV  AX,SEG  RIGHT
      STOSW 
      STI
      
      MOV  AL,10010000B
      MOV  DX,0646H
      OUT  DX,AL
      
      STI
      MOV  DX,0642H
      MOV  AL,0FFH
      OUT  DX,AL
      JMP  L
      MOV  DX,0642H
      MOV  AL,0H
      OUT  DX,AL
      MOV  AH,4CH
      INT  21H
 
DELAY  PROC  NEAR
      MOV  CX,0FFF0H
D:    INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      INC  CX
      DEC  CX
      LOOP D
      RET
DELAY ENDP

LEFT  PROC  FAR
      MOV  DX,0642H
      MOV  AL,0F0H
      OUT  DX,AL
      CALL DELAY
      RET
LEFT  ENDP

RIGHT PROC FAR
      MOV  DX,0642H
      MOV  AL,0FH
      OUT  DX,AL
      CALL DELAY
      RET
RIGHT ENDP
CODE  ENDS
      END MAIN
