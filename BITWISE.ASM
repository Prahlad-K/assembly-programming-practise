.model small
.stack 30
.data
one db 11111010b
two db ?
.code
main proc far
mov ax, @data
mov ds, ax

mov al, one
not al
mov two, al

mov dl, al
mov ah, 02
add dl, 30h
int 21h

mov ax, 4c00h
int 21h
main endp
end main

