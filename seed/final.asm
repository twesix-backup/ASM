DATA    SEGMENT

DELAYT  EQU 0FFFFH

;8255������������ӿ�
CON8255 EQU 0646H
PA8255  EQU 0640H
PB8255  EQU 0642H
PC8255  EQU 0644H
CONWD8255   EQU 00001001B

;ADC0809
CONADC  EQU 0600H
;�������ַд����ѡ��ĳ��������ת����
;ת�����֮�������ڶ�ȡ����

;DAC0832
CONDAC  EQU 0600H
;ʹ��ʱֱ����������������������

;8253/8254��ʱ������
CON8254 EQU 0606H
CH08254 EQU 0600H
CH18254 EQU 0602H
CH28254 EQU 0604H

;�����
LEDTAB:DB  3FH	;0�Ķ���
       DB  06H	;1
       DB  5BH	;2
       DB  4FH	;3
       DB  66H	;4
       DB  6DH	;5
       DB  7DH	;6
       DB  07H	;7
       DB  7FH	;8
       DB  6FH	;9
       DB  77H	;A
       DB  7CH  ;B
       DB  39H	;C
       DB  5EH	;D
       DB  79H	;E
       DB  71H	;F
       
LEDDAT: DB   3FH;
        DB   3FH;
        DB   3FH;
        DB   3FH;
        DB   3FH;
        DB   3FH;

DATA    ENDS

CODE    SEGMENT

    ASSUME CS:CODE,DS:DATA
    
START:
    MOV AX,DATA
    MOV DS,AX
    
    
    MOV AH,4CH
    INT 21H
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;8255���нӿ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_8255   PROC NEAR
    
    MOV AL,CONWD8255 ;8255������������ӿڳ�ʼ��������
    MOV DX,CON8255
    OUT DX,AL
    RET
    
INIT_8255   ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;A�����
OUTA    PROC
    PUSH    DX
    MOV DX,PA8255
    OUT DX,AL
    POP DX
    RET
OUTA    ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;B�����
OUTB    PROC
    PUSH    DX
    MOV DX,PB8255
    OUT DX,AL
    POP DX
    RET
OUTB    ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;C�����
OUTC    PROC
    PUSH    DX
    MOV DX,PC8255
    OUT DX,AL
    POP DX
    RET
OUTC    ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;C������
INPC    PROC
    PUSH    DX
    MOV DX,PC8255
    IN  DX,AL
    POP DX
    RET
OUTC    ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;��ʱ����
DELAY   PROC
    PUSH    CX
    MOV CX,DELAYT
    LOOP    $
    POP CX
DELAY   ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;LED��ʾ����
LED1    PROC


END     START