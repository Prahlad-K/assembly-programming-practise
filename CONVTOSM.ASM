.model small
.stack 64
.data
str db 'INDIA is love','$'
.code
main proc far
mov ax, @data
mov ds, ax; initialization of data segment

lea si, str
mov cl, 13
YYY: mov al, [si]
cmp al, 41
jb XXX
cmp al, 5
ja XXX
xor al, 00100000b
mov [si], al
XXX: inc si
loop YYY

mov ah, 09
lea dx, str
int 21h

mov ax, 4c00h
int 21h
main endp
end main




