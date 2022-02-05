.model small
.stack 64
.data
char db 0
.code
main proc far
mov ax, @data
mov ds, ax

mov cl, 128
XXX:
mov dl, char
mov ah, 02
int 21h

mov dl, ' '
mov ah, 02
int 21h

inc char
loop XXX

mov ax, 4c00h
int 21h

main endp
end main
