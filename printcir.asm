.model small
.stack 64
.386
.data
x1 dw 110
x2 dw 140
y1 dw 200
y2 dw 230
x dw 0
y dw 0
centx dw 0
centy dw 0
xsqr dw 0
ysqr dw 0
lhs dw 0
rhs dw 0
.code
main proc far
mov ax, @data
mov ds, ax
 
call setgra

call printcir

mov ax, 4c00h
int 21h
main endp

printcir proc near
pusha

mov ax, x1
add ax, x2
mov bl, 2
div bl
mov ah, 0
mov centx, ax

mov ax, y1
add ax, y2
mov bl, 2
div bl
mov ah, 0
mov centy, ax

mov ax, centx
sub ax, x1
mul ax
mov rhs, ax

mov ax, x1
mov x, ax
mov ax, y1
mov y, ax

dox:
doy:
call getsumsqr
mov ax, rhs
cmp lhs, ax
jg notsat

mov ah, 0Ch
mov al, 1
mov cx, x
mov dx, y
int 10h

notsat:
inc y
mov ax, y2
cmp y, ax
jl doy

mov ax, y1
mov y, ax
inc x
mov ax, x2
cmp x, ax
jl dox
popa
ret
printcir endp

setgra proc near
mov ax, 0012h
int 10h
mov ah, 0bh
mov bx, 0000h
int 10h
ret
setgra endp

delay proc near
pusha
mov ah, 10h
int 16h
popa
ret
delay endp

getsumsqr proc near
pusha

mov ax, x
cmp ax, centx
jle smallerx
sub ax, centx
jmp proceedx

smallerx:
mov ax, centx
mov bx, x
sub ax, bx

proceedx:
mul ax
mov xsqr, ax

mov ax, y
cmp ax, centy
jle smallery
sub ax, centy
jmp proceedy

smallery:
mov ax, centy
mov bx, y
sub ax, bx

proceedy:
mul ax
mov ysqr, ax

mov ax, xsqr
add ax, ysqr
mov lhs, ax ; complete.
popa
ret
getsumsqr endp



end main