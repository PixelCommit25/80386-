;ALP to implement linear search
%macro read 2
pusha
mov eax, 3
mov ebx, 0
mov ecx, %1
mov edx, %2
int 80h
popa
%endmacro

%macro write 2
 pusha
 mov ecx,%1
 mov edx,%2
 mov ebx,1
 mov eax,4
 int 80h
 popa
%endmacro

section .data
 msg db "Enter the size of the Array: "
 len equ $-msg
 msg1 db "Enter the array elements: ",10
 len1 equ $-msg1
 msg2 db "Enter the element to be searched: "
 msg2_len equ $-msg2
 msg3 db "Element found at position: "
 msg3_len equ $-msg3
 msg4 db "Element not found", 10
 msg4_len equ $-msg4
 newline db 10
 
section .bss
 digit resb 1
 array resb 10
 key resb 1
 pos resb 1
 size resb 1

section .text
 global _start
_start:
   
    write msg, len

    read size, 2
    mov al, [size]
    sub al, "0"
    mov [size], al

   
    write msg1, len1
    mov cl, [size]
    mov edi, array
    input_loop:
        read digit, 1
        mov al, [digit]
        sub al, "0"
        mov [edi], al
        read digit, 1  
        inc edi
        dec cl
        jnz input_loop

   
    write msg2, msg2_len
    read key, 1
    read digit, 1  
    mov al, [key]
    sub al, "0"
    mov [key], al

   
    mov esi, array
    mov byte [pos], 0  
    mov cl, [size]
   
    search_loop:
        mov al, [esi]
        cmp al, [key]
        je found
        inc esi
        inc byte [pos]
        dec cl
        jnz search_loop
   
   
    write msg4, msg4_len
    jmp exit

    found:
        write msg3, msg3_len
        mov al, [pos]
        add al, '0'
        inc al
        mov [pos], al
        write pos, 1
        write newline, 1
    exit:
        mov eax, 1
        int 80h
