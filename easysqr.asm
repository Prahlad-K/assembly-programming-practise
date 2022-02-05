.model small
.stack 64
.386
.data
x1 dw 0
x2 dw 0
y1 dw 0
y2 dw 0
a dw 0
b dw 0
c dw 0
d dw 0
.code
main proc far
mov ax, @data
mov ds, ax
 
call setgra

mov a, 100
mov b, 100
mov c, 200
mov d, 200
call printsqr

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

dishorline proc near
pusha
mov cx, x1 
mov dx, y1
mov bl, 1

horline:
mov ah, 0Ch
mov al, bl
int 10h
inc cx 
inc bl
cmp cx, x2
jl horline
popa
ret
dishorline endp

disverline proc near
pusha
mov cx, x1 
mov dx, y1
mov bl, 1

verline:
mov ah, 0Ch
mov al, bl
int 10h
inc dx 
inc bl
cmp dx, y2
jl verline
popa
ret
disverline endp


printsqr proc near
pusha

mov ax, a
mov x1, ax
mov ax, b
mov y1, ax
mov ax, c
mov x2, ax
call dishorline

mov ax, a
mov x1, ax
mov ax, d
mov y1, ax
mov ax, c
mov x2, ax
call dishorline

mov ax, a
mov x1, ax
mov ax, b
mov y1, ax
mov ax, d
mov y2, ax
call disverline

mov ax, c
mov x1, ax
mov ax, b
mov y1, ax
mov ax, d
mov y2, ax
call disverline
; printing square completed.
popa
ret
printsqr endp

delay proc near
pusha
mov ah, 10h
int 16h
popa
ret
delay endp

end main