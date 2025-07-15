;Write a procedure to implement bubble sort algorithm

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
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 80h
popa
%endmacro

section .data
msg db "Enter the size of the Array: "
len equ $-msg
msg1 db "Enter the array elements: ",10,13
len1 equ $-msg1
msg2 db "Sorted array: "
len2 equ $-msg2

spc db ' '
spcSize equ $-spc

section .bss
digit resb 1
arr resb 10
num resb 1
nl resb 1
size resb 1

section .text
global _start
_start:

write msg, len
read size, 2
mov eax,[size]
sub eax, '0'
mov [size], eax

write msg1, len1

mov cl, [size]
mov edi, arr
l1: ;input
read num, 1
mov eax, [num]
sub eax, '0'
mov [edi], eax
read nl, 1
inc edi
loop l1

mov ecx, [size]

l2: ;bubble sort
mov dl, [size]
mov edi, arr
loop2:
mov al, [edi]
mov bl, [edi + 1]

cmp al, bl
jbe noSwap
mov [edi], bl
mov [edi + 1], al

noSwap:
inc edi
dec dl ;
jnz loop2
loop l2 ;

mov cl, [size]
mov esi, arr

write msg2, len2
output:
mov al, [esi]
add al, '0'
mov [digit], al
write digit, 1
write spc, spcSize
inc esi
loop output

exit:
mov eax, 1
int 80h
