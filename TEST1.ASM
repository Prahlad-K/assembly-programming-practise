.model small
.stack 64
.data
one db 1, 2, 3
two db ?
.code
main proc far
mov ax, @data
mov ds, ax

lea si, one
lea di, two

mov cl, 3
XXX:mov dl, [si]
add dl, 30h
mov ah, 02
int 21h
inc si
loop XXX

mov dl, [si]
add dl, 30h
mov ah, 02
int 21h

mov ax, 4c00h
int 21h
main endp
end main
