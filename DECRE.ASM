.model small
.stack 64
.data
one db 11111111b
.code
main proc far
mov ax, @data
mov ds, ax

mov al, '&'
mov cl, 0
mov bl, 0
XXX:
mov dl, al
mov ah, 02
int 21h
inc bl
dec cl
jnz XXX

mov ax, bx



YYY: mov ax, 4c00h
int 21h

main endp
end main
