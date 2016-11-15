;���ļ��а���4���ӳ���:
;1. BCD2BIN: ��2λASCII����ʽ��ʮ������ת��Ϊ��������
;2. BIN2BCD: ��С��99�Ķ�������ת��ΪASCII����ʽʮ������
;3. HEX2ASC: ��һ�ֽ�16������ת��ΪASCII����ʽ
;4. BSORT: ���ֽ����͵����ݽ���ð������
;ʹ��ǰ�������Ķ��ӳ���ǰ��˵����


;==================================================
;BCD2BIN: ��2λASCII����ʽ��ʮ������ת��Ϊ��������
;
;��ڣ�SIָ��ASCII����ʽ����λʮ������
;
;���ڣ�AL����ת����Ķ�������
;
;������ASC_NUM  DB  '12'
;      ...
;      LEA   SI, BUFF
;      CALL  BCD2BIN 
;      ���ú�(AL)=0CH
;==================================================
BCD2BIN  PROC
         MOV  AH,[SI]
         MOV  AL,[SI+1]
         SUB  AX,3030H
         AAD
         RET
BCD2BIN  ENDP

;==================================================
;BIN2BCD: ��С��99�Ķ�������ת��ΪASCII����ʽʮ������
;
;��ڣ�AL����Ҫת���Ķ���������00H-63H��
;
;���ڣ�AH��AL�����ݷֱ�Ϊʮ���ƽ����ʮλ���͸�λ����ASCII����ʽ��
;
;������MOV   AL, 0CH
;      CALL  BIN2BCD 
;      ���ú�(AH)='1', (AL)='2'
;==================================================
BIN2BCD  PROC
         AAM
         ADD  AX,3030H
         RET
BIN2BCD  ENDP

;==================================================
;HEX2ASC: ��һ�ֽ�16������ת��ΪASCII����ʽ
;
;��ڣ�AL����Ҫת����16��������00H-FFH��
;
;���ڣ�AH��AL�����ݷֱ�ΪASCII����ʽ��16������
;
;������MOV   AL, 9AH
;      CALL  HEX2ASC 
;      ���ú�(AH)='9', (AL)='A'
;==================================================
HEX2ASC  PROC
         PUSH CX
         MOV  AH,AL
         AND  AL,0FH
         CMP  AL,9
         JBE  H1
         ADD  AL,7
H1:      ADD  AL,30H
         MOV  CL,4
         SHR  AH,CL
         CMP  AH,9
         JBE  H2
         ADD  AH,7
H2:      ADD  AH,30H
         POP  CX
         RET
HEX2ASC  ENDP

;==================================================
;BSORT: ���ֽ����͵��޷���������ð������
;
;��ڣ�(DI)=Ҫ�������ݵ��׵�ַ��(BL)=���ݸ���
;
;���ڣ����мĴ������ݾ����ı�
;
;������BUFF  DB  9,4,1,3,7
;      ... 
;      LEA   DI, BUFF
;      MOV   BL, 5
;      CALL  BSORT
;      ����� BUFF�е�5�����ݱ�Ϊ9,7,4,3,1 
;==================================================
BSORT    PROC
         PUSH SI
         PUSH BX
         PUSH CX 
         DEC  BL
NEXT1:   MOV  SI,DI
         MOV  CL,BL
NEXT2:   LODSB
         CMP  AL,[SI]
         JNC  NEXT3
         MOV  AH,[SI]
         MOV  [SI-1],AH
         MOV  [SI],AL
NEXT3:   DEC  CL
         JNZ  NEXT2
         DEC  BL
         JNZ  NEXT1
         POP  CX
         POP  BX
         POP  SI
         RET
BSORT    ENDP