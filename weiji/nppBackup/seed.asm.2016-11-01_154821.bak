data segment

data ends

code segment

assume cs:code,ds:data

start:
mov ax,data
mov ds,ax

mov ax,8000h
mov ds,ax

;ruled write in
mov ax,0000h
mov bx,0000h
ruled:
mov [bx],ax
inc ah
inc bx
inc bx
cmp ah,010h
jnz ruled

;jmp bye

;unruled weite in
inc bx
;now bx==0011h
mov ax,0000h
unruled:
mov [bx],ax
inc ah
inc bx
inc bx
cmp ah,010h
jnz unruled

;jmp bye


;byte weite in
mov al,00h
byted:
mov [bx],ax
inc al
inc bx
cmp al,010h
jnz byted

bye:


code ends

end start