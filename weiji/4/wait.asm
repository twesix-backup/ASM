CODE	SEGMENT

ASSUME	CS:CODE

START:

    ;;;;;;;;;;;;;;;;;;; init 8255
	MOV 	DX,0646H
	MOV		AL,10000000B
	OUT		DX,AL
	
	P1:
	MOV		AL,00H
	MOV		DX,0600H
	OUT		DX,AL
	
	CALL	delay
	MOV		DX,0600H
	IN		AL,DX

	MOV		DX,0642H
	OUT		DX,AL
	
	JMP		P1

delay proc near
push cx
mov cx,0ffffh
blocking:
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
inc cx
dec cx
loop blocking
pop cx
ret
delay endp

CODE	ENDS

END 	START