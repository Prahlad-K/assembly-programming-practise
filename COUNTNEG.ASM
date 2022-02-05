.model small
.stack 64
.data
array db 4, -4
n db 0
.code
main proc far
mov ax, @data
mov ds, ax

lea si, array
mov cl, 2
YYY: mov al, [si]
cmp al, 0
jg XXX
dec n
XXX:inc n
inc si
dec cl
jnz YYY

mov dl, n
add dl, 30h
mov ah, 02
int 21h

mov ax, 4c00h
int 21h

main endp
end main

