.model small
.stack 64
.386
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

call setgra
call display

mov ax, 4c00h
int 21h

main endp

setgra proc near
mov ax, 0012h
int 10h
mov ah, 0bh
mov bx, 0008h ; okay so bh 01 is used for choosing the color palette.
int 10h
ret
setgra endp

display proc near
mov bx, 0
mov cx, 0
mov dx, 0

repeat:
mov ah, 0ch
mov al, bl
int 10h
inc cx
cmp cx, 639
jne repeat
mov cx, 0
inc bl
inc dx
cmp dx, 479
jne repeat
ret
display endp

end main


