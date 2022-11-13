DATAS SEGMENT
OUTPUT1 DB "please input a number(0-9999)  :",'$'
OUTPUT2 DB "TURE!",'$'
OUTPUT3 DB "FALSE!",'$'
BUF    DB  10				    ;预定义10字节的空间
       DB  ?				    ;待输入完成后，自动获得输入的字符个数
       DB  10  DUP(0)    
CRLF   DB  0AH, 0DH,'$'         ;换行符
    
DATAS ENDS
 
STACKS SEGMENT
    DB  10  DUP(0)               ;此处输入堆栈段代码  
STACKS ENDS
 
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV AX,STACKS
    MOV SS,AX
    MOV SP,9
    LEA DX, OUTPUT1                  ;输出提示字符串
    MOV AH, 09H							 
    INT 21H
    
    LEA DX,BUF                    ;接收字符串
    MOV AH, 0AH
    INT 21H
    
    LEA DX, CRLF                 ;换行
    MOV AH, 09H							 
    INT 21H
    
   

    CMP BYTE PTR BUF[1],1
    JNZ C2
    CALL HUIWEN1
C2: CMP BYTE PTR BUF[1],2
    JNZ C3
    CALL HUIWEN2
C3: CMP BYTE PTR BUF[1],3
    JNZ C4
    CALL HUIWEN3
C4: CMP BYTE PTR BUF[1],4
    JNZ OK
    CALL HUIWEN4
    JMP OK
OUTTURE:
    LEA DX, OUTPUT2                  ;输出结果为真字符串
    MOV AH, 09H							 
    INT 21H
    RET

OUTFALSE:
    LEA DX, OUTPUT3                  ;输出结果为假字符串
    MOV AH, 09H							 
    INT 21H
    RET


HUIWEN1:
    CALL OUTTURE
    RET

HUIWEN2:
    MOV AL,BYTE PTR BUF[2]
    CMP AL,BYTE PTR BUF[3]
    JZ TU2
    CALL OUTFALSE
    RET
TU2: CALL OUTTURE
    RET

HUIWEN3:
    MOV AL,BYTE PTR BUF[2]
    CMP AL,BYTE PTR BUF[4]
    JZ TU3
    CALL OUTFALSE
    RET
TU3: CALL OUTTURE
    RET

HUIWEN4:
    MOV AL,BYTE PTR BUF[2]
    CMP AL,BYTE PTR BUF[5]
    JZ TU41
    CALL OUTFALSE
    RET
TU41: 
    MOV AL,BYTE PTR BUF[3]
    CMP AL,BYTE PTR BUF[4]
    JZ TU42
    CALL OUTFALSE
    RET
TU42: 
    CALL OUTTURE
    RET
   

    
    
OK: MOV AH,4CH
    INT 21H
CODES ENDS
    END START