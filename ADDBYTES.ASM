.model small
.stack 64
.data
one db 1h
two db 2h
.code
main proc far
mov ax, @data
mov ds, ax

mov al, one
add al, two
mov dl, al
mov ah, 02
int 21h

mov ax, 4c00h
int 21h
main endp
end main

