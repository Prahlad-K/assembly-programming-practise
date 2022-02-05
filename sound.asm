.model small
.stack 64
.data
.model small
.stack 64
.data
bell db 1000 dup(07h), '$'

.code
main proc far
mov ax, @data
mov ds, ax

mov ah, 0003h
int 10h

mov ah, 06h
mov al, 00
mov bh, 70h
mov cx, 0000h
mov dx, 184Fh
int 10h ; clearing screen

mov ah, 02h
mov bh, 0
mov dh, 00
mov dl, 00
int 10h

mov ah, 09h
mov al, 01h
mov cx, 100
mov bh, 0
mov bl, 35h
int 10h

mov ax, 4c00h
int 21h

main endp

end main