PUBLIC BUF
EXTRN HUIWEN1,HUIWEN2,HUIWEN3,HUIWEN4
DATAS SEGMENT 'A1'
OUTPUT1 DB "please input a number(0-9999)  :",'$'
BUF    DB  10				    ;预定义10字节的空间
       DB  ?				    ;待输入完成后，自动获得输入的字符个数
       DB  10  DUP(0)    
CRLF   DB  0AH, 0DH,'$'         ;换行符
    
DATAS ENDS
 
STACKS SEGMENT STACK 'B2'
    DB  10  DUP(0)               ;此处输入堆栈段代码  
STACKS ENDS
 
CODES SEGMENT 'C3'
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
    JNZ CL2
    CALL HUIWEN1
CL2: CMP BYTE PTR BUF[1],2
    JNZ CL3
    CALL HUIWEN2
CL3: CMP BYTE PTR BUF[1],3
    JNZ CL4
    CALL HUIWEN3
CL4: CMP BYTE PTR BUF[1],4
    JNZ OK
    CALL HUIWEN4
 
OK: MOV AH,4CH
    INT 21H
CODES ENDS
    END START