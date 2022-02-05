.model small
.stack 64
.data
array db 5, 4, 3, 2, 1, 7, 8
odd db 0
eve db 0
.code
main proc far
mov ax, @data
mov ds, ax

lea si, array
mov cl, 7
YYY:
mov al, [si]
mov ah, 0
mov bl, 2
div bl
cmp ah, 0
JNE XXX
dec odd
inc eve
XXX:inc odd
inc si
dec cl
JNZ YYY

mov dl, odd
add dl, 30h
mov ah, 02
int 21h

mov dl, eve
add dl, 30h
mov ah, 02
int 21h

mov ax, 4c00h
int 21h
main endp
end main

