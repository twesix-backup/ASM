;��10����(�޷�����)�е�������ż���ֱ���ͣ����浽sum_odd��sum_even�����С�
.model small
.8086
.stack
.code
    mov  ax, @data
    mov  ds, ax 
    lea  si, array    ;����ԭʼ����ָ��
    mov  cx, 10       ;����ѭ������
lp: 
    mov  al, [si]
    test al, 1        ;��������
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