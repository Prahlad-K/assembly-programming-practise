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
x dw 0
y dw 0
centx dw 0
centy dw 0
xsqr dw 0
ysqr dw 0
lhs dw 0
rhs dw 0
currx1 dw 110
currx2 dw 140
currx3 dw 160
currx4 dw 190
count db 100
pix db 1
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

mov x1, 110
mov y1, 200
mov x2, 140
mov y2, 230
call printcir

mov x1, 160
mov y1, 200
mov x2, 190
mov y2, 230
call printcir


move:
mov ah, 10h
int 16h

cmp al, 0E0h
jne finish
cmp ah, 4Bh
je moveleft
cmp ah, 4Dh
je moveright
jmp finish
moveleft:
inc pix
call clrscr

sub a, 10
sub c, 10
call printsqr

sub currx1, 10
sub currx2, 10
sub currx3, 10
sub currx4, 10

mov ax, currx1
mov x1, ax
mov y1, 200
mov ax, currx2
mov x2, ax
mov y2, 230
call printcir

mov ax, currx3
mov x1, ax
mov y1, 200
mov ax, currx4
mov x2, ax
mov y2, 230
call printcir
dec count

cmp count, 0
jge move

moveright:
inc pix
call clrscr

add a, 10
add c, 10
call printsqr

add currx1, 10
add currx2, 10
add currx3, 10
add currx4, 10

mov ax, currx1
mov x1, ax
mov y1, 200
mov ax, currx2
mov x2, ax
mov y2, 230
call printcir

mov ax, currx3
mov x1, ax
mov y1, 200
mov ax, currx4
mov x2, ax
mov y2, 230
call printcir
dec count

cmp count, 0
jge move

finish:
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

clrscr proc near
pusha
mov ah, 06
mov al, 0 ; clearing the screen
mov bh, 70h
mov cx, 0000h
mov dx, 184Fh
int 10h
popa
ret
clrscr endp

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
mov al, pix
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


end main