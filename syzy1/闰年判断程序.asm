data  segment ;定义数据段 
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

      lea dx,infon     ;在屏幕上显示提示信息 
      mov ah,9 
      int 21h 

      lea dx,buf       ;从键盘输入年份字符串 
      mov ah,10 
      int 21h 

      mov cl, [buf+1]  ;取出年份字符个数 
      lea di,buf+2     ;DI指向年份数字字符串
      call datacate    ;年份转换成二进制数
      call ifyears     ;判断是否闰年，退出时CF=1表示是闰年
      jc disp_y             
disp_n:
      lea dx,n         ;显示“非闰年”
      mov ah,9 
      int 21h 
      jmp exit 
disp_y: 
      lea dx,y         ;显示“闰年”
      mov ah,9 
      int 21h 

      ;按任意键即可退出
exit: 
      mov ah,1 
      int 21h 
      mov ah,4ch 
      int 21h 
;;;;;;;;;主程序结束;;;;;;;;;;;

;;;;;;;;下面是函数子程序;;;;;;;;;;

;=========================================;
;这个函数将年份字符串转换成年份的二进制数 ;
;=========================================;
datacate proc near 
;这段将SI指向年份数字字符串的最后一个字符
;例如年份为‘1980’，则使SI指向‘0’这个字符
      push cx          ;保存年份字符个数    
      dec cx 
      lea si,buf+2 
tt1: 
      inc si 
      loop tt1 
      pop cx           ;恢复年份字符个数

;这段将年份转换为二进制数
;从个位开始用二进制计算：千位*1000+百位*100+十位*10+个位
;最后的结果在w中
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
;这个函数用以判断年份是否闰年，方法如下： ;
;假如Y为闰年，则应满足以下两个条件：      ; 
;   1) Y能被100和400整除                  ; 
;   2) Y不能被100除尽，但可被4整除        ; 
;=========================================;
ifyears proc near 
;保护寄存器内容
      push bx
      push cx
      push dx
 
      mov ax,w         ;取出年份（二进制数）
      mov cx,ax        ;暂存到CX 

;以下这段判断年份能否被4整除
      mov dx,0     
      mov bx,4 
      div bx           ;年份除4，不能整除的不是闰年
      cmp dx,0         ;判断余数是否为0
      jnz lab1         ;余数不为0—不是闰年
      mov ax,cx        ;从CX中恢复年份的二进制数

;通过上面的判断，已知年份能被4整除。
;以下这段判断：年份能被4整除，但能否被100整除？
      mov bx,100     
      div bx           ;年份除100
      cmp dx,0         ;判断余数是否为0
      jnz lab2         ;余数不为0—能被4整除但不能被100整除的也是闰年

;通过上面的判断，已知年份能被100整除
;以下这段判断年份能否也被400整除
      mov ax,cx        ;从CX中恢复年份的二进制数
      mov bx,400
      div bx           ;年份除400，若能整除的即是闰年
      cmp dx,0         ;判断余数是否为0 
      jz lab2          ;余数为0—是闰年 

;若非闰年，将CF置0
lab1: 
      clc 
      jmp lab3

;若是闰年，将CF置1 
lab2: 
      stc 

;退出后，CF=0非闰年，CF=1闰年
lab3: 
      pop dx 
      pop cx 
      pop bx 
      ret 
ifyears endp 

code  ends 
      end start