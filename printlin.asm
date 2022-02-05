.model small
.stack 64
.386
.code
main proc far
mov ax, @data
mov ds, ax

call setgra
call display

mov ax, 4c00h
int 21h
main endp

setgra proc near
mov ax, 0012h
int 10h
mov ah, 0bh
mov bx, 0000h
int 10h
ret
setgra endp

display proc near
mov cx, 40
mov dx, 100
mov bl, 1

line:
mov ah, 0Ch
mov al, bl
int 10h
inc cx 
inc bl
cmp cx, 600
jl line
ret
display endp

delay proc near
pusha
mov ah, 10h
int 16h
popa
ret
delay endp

end main