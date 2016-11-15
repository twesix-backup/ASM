;延时1个单位时间的子程序
DELAY   PROC
        PUSH AX
        PUSH CX
D0:     MOV  CX, 200H
D1:     MOV  AX, 0FFFFH
D2:     DEC  AX 
        JNZ  D2
        LOOP D1
        POP  CX
        POP  AX     
        RET                                
DELAY   ENDP                               

;延时N个单位时间的子程序 (入口：DL=N)
DELAY_N  PROC
DN:      CALL DELAY   ;延迟1个时间单位
         DEC  DL      ;时间单位个数减1 
         JNZ  DN      ;若不为0，继续延迟 
         RET          ;否则结束，返回主程序 
DELAY_N  ENDP  