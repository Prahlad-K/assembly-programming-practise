.model small
.stack 64
.386
.data
x1 dw 0
x2 dw 0
y1 dw 0
y2 dw 0
x dw 0
y dw 0
.code
main proc far
mov ax, @data
mov ds, ax
 
call setgra

mov x1, 100
mov y1, 100
mov x2, 200
call dishorline

mov x1, 100
mov y1, 200
mov x2, 200
call dishorline

mov x1, 100
mov y1, 100
mov y2, 200
call disverline

mov x1, 200
mov y1, 100
mov y2, 200
call disverline
; printing square completed.

mov x1, 100
mov y1, 100
mov x2, 200
mov y2, 200
call disleftdiagline

mov x1, 200
mov y1, 100
mov x2, 100
mov y2, 200
call disrightdiagline
; printing diagonals of square.

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

disleftdiagline proc near
pusha
mov cx, x1 
mov dx, y1
mov bl, 1

leftdiagline:
mov ah, 0Ch
mov al, bl
int 10h
inc cx
inc dx 
inc bl
cmp cx, x2
jl leftdiagline ; as cx, dx are going to be same as x2, y2 with x2=y2, no need to check dx.
popa
ret
disleftdiagline endp

disrightdiagline proc near
pusha
mov cx, x1 
mov dx, y1
mov bl, 1

rightdiagline:
mov ah, 0Ch
mov al, bl
int 10h
dec cx
inc dx 
inc bl
cmp cx, x2
jg rightdiagline 
popa
ret
disrightdiagline endp

delay proc near
pusha
mov ah, 10h
int 16h
popa
ret
delay endp

end main