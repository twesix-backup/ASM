shift_reg  MACRO reg1,reg2
LOCAL  QUIT, ONE
;reg1��reg2����ѭ����λ
;��reg2�����λ����reg1�����λ
;��reg1�����λ����reg2�����λ
;����λ������1λ
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
;reg1��reg2����ѭ����λ��8λ��16λ�Ĵ������ɣ�
;��reg2�����λ����reg1�����λ
;��reg1�����λ����reg2�����λ
;����λ������1λ
       OR  reg1,reg1
       JS  ONE
       JMP SHIFT
ONE:
       STC
SHIFT:
       RCL reg2,1
       RCL reg1,1
       ENDM