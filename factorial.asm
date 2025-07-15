;ALP to calculate and display the factorial of a number using macros
section .data
m1 db "Enter a Number: ",10,13
m1_len equ $-m1
fact_msg db "Factorial is: ",10,13
fact_len equ $-fact_msg
newline db 10,13
newline_len equ $-newline

section .bss
num1 resb 3
num2 resw 1
dispbuffer resb 10 

%macro write 2
   mov eax,4
   mov ebx,1
   mov ecx,%1
   mov edx,%2
   int 80h
%endmacro

%macro read 2
   mov eax,3
   mov ebx,0
   mov ecx,%1
   mov edx,%2
   int 80h
%endmacro

section .text
global _start
_start:
    write m1, m1_len
    read num1, 2
    XOR EAX, EAX
    XOR EBX, EBX
    XOR ECX, ECX
    XOR EDX, EDX

    CALL CONVERT  
    MOV [num2], BX

    write fact_msg, fact_len 

    XOR EAX, EAX
    XOR EBX, EBX
    XOR ECX, ECX
    XOR EDX, EDX
    MOV BX, [num2]  
    MOV AX, 1       
    CALL proc_fact 
    MOV EBX, EAX   
    CALL DISPLAY   

    MOV EAX, 1
    MOV EBX, 0
    INT 80H

CONVERT:
    MOV ESI, num1
    MOV BX, 0         
    MOV AL, [ESI]
    SUB AL, '0'      
    MOV AH, 10
    MUL AH           
    MOV BX, AX        
    INC ESI
    MOV AL, [ESI]
    SUB AL, '0'       
    ADD BX, AX      
    RET
proc_fact:
    CMP BX, 1
    JG factorial_calc
    RET 

factorial_calc:
    MUL BX  
    DEC BX
    CALL proc_fact
    RET

DISPLAY:
    MOV ECX, 10         
    MOV EDI, dispbuffer  
    ADD EDI, 9         
    MOV BYTE [EDI], 0  
    DEC EDI

convert_loop:
    XOR EDX, EDX
    DIV ECX              
    ADD DL, '0'          
    MOV [EDI], DL        
    DEC EDI
    TEST EAX, EAX        
    JNZ convert_loop

    INC EDI             
    write EDI, 10      

    write newline, newline_len
    RET
