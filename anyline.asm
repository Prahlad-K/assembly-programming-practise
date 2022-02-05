.model small
.stack 64
.386
.data
x1 dw 0
x2 dw 120
y1 dw 0
y2 dw 233
x dw 0
y dw 0
i dw 0
.code
main proc far
mov ax, @data
mov ds, ax

call setgra


mov ax, x1
mov x, ax
mov ax, y1
mov y, ax
call display

mov ax, x2
mov x, ax
mov ax, y2
mov y, ax
call display

call average
call display

repeat1:
mov ax, x
mov x2, ax
mov ax, y
mov y2, ax
call average
call display
inc i
cmp i, 100
jl repeat1

mov x2, 120
mov y2, 233
call average 
mov i, 0
repeat2:
mov ax, x
mov x1, ax
mov ax, y
mov y1, ax
call average
call display
inc i
cmp i, 100
jl repeat2

mov ax, 4c00h
int 21h
main endp

setgra proc near
pusha
mov ax, 0012h
int 10h
mov ah, 0bh
mov bx, 0000h
int 10h
popa
ret
setgra endp

display proc near
pusha
mov cx, x
mov dx, y
mov bh, 0

mov ah, 0Ch
mov al, 1
int 10h
popa  
ret
display endp

average proc near
pusha
mov dx, 0
mov ax, x1
mov bx, x2
add ax, bx
mov bx, 2
div bx
mov x, ax

mov dx, 0
mov ax, y1
mov bx, y2
add ax, bx
mov bx, 2
div bx
mov y, ax
popa
ret
average endp

delay proc near
pusha
mov ah, 10h
int 16h
popa
ret
delay endp

end main