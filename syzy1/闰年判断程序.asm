data  segment ;�������ݶ� 
infon db 0dh,0ah,'Please input a year: $' 
Y     db 0dh,0ah,'This is a leap year! $' 
N     db 0dh,0ah,'This is not a leap year! $' 
w     dw 0 
buf   db 8 
      db ? 
      db 8 dup(?) 
data  ends 

stack segment stack 
      db 100 dup("stack") 
stack ends 

code  segment 
      assume ds:data,ss:stack,cs:code 
start:
      mov ax,data 
      mov ds,ax 

      lea dx,infon     ;����Ļ����ʾ��ʾ��Ϣ 
      mov ah,9 
      int 21h 

      lea dx,buf       ;�Ӽ�����������ַ��� 
      mov ah,10 
      int 21h 

      mov cl, [buf+1]  ;ȡ������ַ����� 
      lea di,buf+2     ;DIָ����������ַ���
      call datacate    ;���ת���ɶ�������
      call ifyears     ;�ж��Ƿ����꣬�˳�ʱCF=1��ʾ������
      jc disp_y             
disp_n:
      lea dx,n         ;��ʾ�������ꡱ
      mov ah,9 
      int 21h 
      jmp exit 
disp_y: 
      lea dx,y         ;��ʾ�����ꡱ
      mov ah,9 
      int 21h 

      ;������������˳�
exit: 
      mov ah,1 
      int 21h 
      mov ah,4ch 
      int 21h 
;;;;;;;;;���������;;;;;;;;;;;

;;;;;;;;�����Ǻ����ӳ���;;;;;;;;;;

;=========================================;
;�������������ַ���ת������ݵĶ������� ;
;=========================================;
datacate proc near 
;��ν�SIָ����������ַ��������һ���ַ�
;�������Ϊ��1980������ʹSIָ��0������ַ�
      push cx          ;��������ַ�����    
      dec cx 
      lea si,buf+2 
tt1: 
      inc si 
      loop tt1 
      pop cx           ;�ָ�����ַ�����

;��ν����ת��Ϊ��������
;�Ӹ�λ��ʼ�ö����Ƽ��㣺ǧλ*1000+��λ*100+ʮλ*10+��λ
;���Ľ����w��
      mov dh,30h 
      mov bl,10 
      mov ax,1 
l1: 
      push ax 
      sub byte ptr [si],dh 
      mul byte ptr [si] 
      add w,ax 
      pop ax 
      mul bl 
      dec si 
      loop l1
      ret 
datacate endp 

;=========================================;
;������������ж�����Ƿ����꣬�������£� ;
;����YΪ���꣬��Ӧ������������������      ; 
;   1) Y�ܱ�100��400����                  ; 
;   2) Y���ܱ�100���������ɱ�4����        ; 
;=========================================;
ifyears proc near 
;�����Ĵ�������
      push bx
      push cx
      push dx
 
      mov ax,w         ;ȡ����ݣ�����������
      mov cx,ax        ;�ݴ浽CX 

;��������ж�����ܷ�4����
      mov dx,0     
      mov bx,4 
      div bx           ;��ݳ�4�����������Ĳ�������
      cmp dx,0         ;�ж������Ƿ�Ϊ0
      jnz lab1         ;������Ϊ0����������
      mov ax,cx        ;��CX�лָ���ݵĶ�������

;ͨ��������жϣ���֪����ܱ�4������
;��������жϣ�����ܱ�4���������ܷ�100������
      mov bx,100     
      div bx           ;��ݳ�100
      cmp dx,0         ;�ж������Ƿ�Ϊ0
      jnz lab2         ;������Ϊ0���ܱ�4���������ܱ�100������Ҳ������

;ͨ��������жϣ���֪����ܱ�100����
;��������ж�����ܷ�Ҳ��400����
      mov ax,cx        ;��CX�лָ���ݵĶ�������
      mov bx,400
      div bx           ;��ݳ�400�����������ļ�������
      cmp dx,0         ;�ж������Ƿ�Ϊ0 
      jz lab2          ;����Ϊ0�������� 

;�������꣬��CF��0
lab1: 
      clc 
      jmp lab3

;�������꣬��CF��1 
lab2: 
      stc 

;�˳���CF=0�����꣬CF=1����
lab3: 
      pop dx 
      pop cx 
      pop bx 
      ret 
ifyears endp 

code  ends 
      end start