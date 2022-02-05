.model small
.stack 64
.data
str db 20 dup('*')
res db 20 dup(' ')
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

cld
mov cx, 20
lea di, res
lea si, str
rep movsb

lea dx, res
mov ah, 09
int 21h

main endp
end main


