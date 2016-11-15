;将10个数(无符号数)中的奇数和偶数分别求和，保存到sum_odd和sum_even变量中。
.model small
.8086
.stack
.code
    mov  ax, @data
    mov  ds, ax 
    lea  si, array    ;设置原始数据指针
    mov  cx, 10       ;设置循环次数
lp: 
    mov  al, [si]
    test al, 1        ;是奇数？
    mov  ah, 0
    jnz  odd 
    add  sum_even, ax
    jmp  lp1 
odd:
    add  sum_odd, ax
lp1:
    loop lp
    mov  ah, 4ch
    int  21h        
.data
  array    dw 12h, 09h, 3fh, 43h, 0c5h, 37h, 0f1h, 9ah, 77h, 2ah
  sum_odd  dw 0    
  sum_even dw 0
end