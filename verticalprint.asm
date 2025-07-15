;ALP PROGRAM TO DISPLAY “HELLO WORLD” VERTICALLY 
%macro write 2
 pusha
 mov ecx,%1
 mov edx,%2
 mov ebx,1
 mov eax,4
 int 80h
 popa
%endmacro

%macro read 1
 pusha
 mov ecx,%1
 mov edx,1
 mov ebx,0
 mov eax,3
 int 80h
 popa
%endmacro

section .data
 msg db "Enter a string to display it vertically: "
 msglen equ $-msg
 omsg db 13,10,"Entered string is:",10
 omsglen equ $-omsg
 newline db 10
 
section .bss
 string resb 12
 
section .text
 global _start
_start:
    write msg,msglen
    mov edi,string
    mov ecx,12          
input_loop:
    read edi            
    cmp byte [edi], 10  
    je input_done      
    inc edi            
    loop input_loop    
   
input_done:
    mov esi, string
    sub edi, esi     
    write omsg,omsglen
  
    mov ecx, edi        
    mov esi, string
output_loop:
    write esi, 1        
    write newline,1    
    inc esi            
    loop output_loop
   
    mov eax,1
    int 80h
