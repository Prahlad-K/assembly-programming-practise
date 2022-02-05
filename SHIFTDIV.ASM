
.model small
.stack 64
.code
main proc far
mov al, 10000000b
mov cl, 4
ror al, cl
mov dl, al
add dl, 30h
mov ah, 02
int 21h

mov ax, 4c00h
int 21h
main endp
end main

