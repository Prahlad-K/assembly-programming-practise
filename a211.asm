.model small
.stack 64
.386
.data
flag db 0
x1 dw 0
x2 dw 0
y1 dw 0
y2 dw 0
x dw 0
y dw 0
avgx dw 0
avgy dw 0
a dw 0
b dw 0
c dw 0
d dw 0
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

call setgra
mov flag, 0
mov x1, 50
mov y1, 300
mov x2, 500
mov y2, 300
call display ; flag 0 indicates horizontal line. 


mov flag, 1
mov x1, 50
mov y1, 100
mov x2, 50
mov y2, 300
call display ; flag 1 indicates verical line.

mov a, 30
mov b, 100
mov c, 70
mov d, 300
call printsqr


mov x1, 50
mov y1, 100
mov x2, 500
mov y2, 300

call average

mov ax, x
mov avgx, ax
mov ax, y
mov avgy, ax

mov ax, x
mov x1, ax
mov ax, y
mov y1, ax
mov flag, 1
mov y2, 300
call display

mov a, 265
mov b, 200
mov c, 285
mov d, 300
call printsqr

mov x1, 50
mov y1, 100
mov ax, x
mov x2, ax
mov ax, y
mov y2, ax

call average

mov ax, x
mov x1, ax
mov ax, y
mov y1, ax
mov flag, 1
mov y2, 300
call display

mov a, 145
mov b, 150
mov c, 177
mov d, 300
call printsqr

mov x1, 500
mov y1, 300
mov ax, avgx
mov x2, ax
mov ax, avgy
mov y2, ax

call average

mov ax, x
mov x1, ax
mov ax, y
mov y1, ax
mov flag, 1
mov y2, 300
call display

mov a, 382
mov b, 250
mov c, 392
mov d, 300
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

display proc near
pusha
mov cx, x1
mov dx, y1
mov bl, 1

cmp flag, 0
jne vertiline
horiline:
mov ah, 0Ch
mov al, bl
int 10h
inc cx 
cmp cx, x2
jl horiline
jmp finish

vertiline:
mov ah, 0Ch
mov al, bl
int 10h
inc dx
cmp dx, y2
jl vertiline

finish:
popa
ret
display endp

average proc near
pusha
mov ax, x1
mov bx, x2
add ax, bx
mov dx, 0
mov bx, 2
div bx
mov x, ax

mov ax, y1
mov bx, y2
add ax, bx
mov dx, 0
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

end main