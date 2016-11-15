shift_reg  MACRO reg1,reg2
LOCAL  QUIT, ONE
;reg1和reg2联合循环移位
;将reg2的最高位移至reg1的最低位
;将reg1的最高位移至reg2的最低位
;其他位均左移1位
OR  reg2,reg2
JS  ONE
SHL reg1,1
RCL reg2,1
JMP QUIT
ONE:
STC
RCL reg1,1
RCL reg2,1
QUIT:
ENDM

shift_reg  MACRO reg1,reg2
LOCAL  SHIFT, ONE
;reg1和reg2联合循环移位（8位或16位寄存器均可）
;将reg2的最高位移至reg1的最低位
;将reg1的最高位移至reg2的最低位
;其他位均左移1位
       OR  reg1,reg1
       JS  ONE
       JMP SHIFT
ONE:
       STC
SHIFT:
       RCL reg2,1
       RCL reg1,1
       ENDM