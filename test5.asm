.model small
.stack 64
.data
flag db 0
.code
main proc far
mov ax, @data
mov ds, ax

mov ax, 80h
mov bx, 40h

cmp ax, bx
je cont
cmp ax, bx
jg finish
mov flag, 1
mov dl, '1'
mov ah, 02h
int 21h
jmp finish
cont: mov dl, '0'
mov ah, 02h
int 21h

finish: mov ax, 4c00h
int 21h
main endp
end main