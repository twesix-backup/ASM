code segment
assume cs:code

start proc far

on:
;;;;;;;;;;;;;;;;;;; init 8259
cli

;icw1
mov dx,020h
mov al,00011011b
out dx,al

;icw2
mov dx,021h
mov al,01110111b
out dx,al

;icw3
mov al,00000001b
out dx,al

;icw4
mov al,00111111b
out dx,al

sti

;;;;;;;;;;;;;;;;;;;; set interrupt programs

cli
mov ax,0000h
mov es,ax
mov di,1dch
mov ax,offset kk1
cld
stosw
mov ax,seg kk1
stosw
sti

cli
mov ax,0000h
mov es,ax
mov di,1d8h
mov ax,offset kk2
cld
stosw
mov ax,seg kk2
stosw
sti

;;;;;;;;;;;;;;;;;;; init 8255
mov dx,0646h
mov al,10000000b
out dx,al

;;;;;;;;;;;;;;;;;;;; main program
mov dx,0642h
mov al,11111111b
out dx,al
jmp on

start endp

;;;;;;;;;;;;;;;;;;;;; green
kk2 proc near
;call endi
push ax
push dx
mov dx,0642h
mov al,00001111b
out dx,al
mov ah,02h
mov dl,45h
int 21h
pop dx
pop ax
call delay
call delay
call delay
call delay
ret
kk2 endp

;;;;;;;;;;;;;;;;;;;;; red
kk1 proc near
;call endi
push ax
push dx
mov dx,0642h
mov al,11110000b
out dx,al
mov ah,02h
mov dl,46h
int 21h
pop dx
pop ax
call delay
call delay
call delay
call delay
ret
kk1 endp

endi proc near
mov ah,02h
mov dl,44h
int 21h
push ax
push dx
mov dx,0021h
mov al,11111111b
out dx,al
mov al,00100000b
out dx,al
pop dx
pop ax
ret
endi endp

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

code ends

end start