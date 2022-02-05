.model small
.stack 64
.386
.data
x dw 100
y dw 100
xsqr dw 0
ysqr dw 0
lhs dw 0
rhs dw 2500
temp db 100 dup(0)
.code
main proc far
mov ax, @data
mov ds, ax

call getsumsqr
mov ax, lhs
mov dx, 0
call printwor

mov ax, 4c00h
int 21h
main endp

getsumsqr proc near
pusha

mov ax, x
cmp ax, 150
jle smallerx
sub ax, 150
jmp proceedx

smallerx:
mov ax, 150
mov bx, x
sub ax, bx

proceedx:
mul ax
mov xsqr, ax

mov ax, y
cmp ax, 150
jle smallery
sub ax, 150
jmp proceedy

smallery:
mov ax, 150
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

printwor proc near
pusha
lea si, temp
mov bx, 16
mov cl, 0
; always remember, during printing the character is echoed to ax! 
XXX:
div bx
cmp dx, 10
jge alpha

add dl, 30h
jmp notalpha

alpha: add dl, 55
notalpha:
mov [si], dl
inc si
inc cl
mov dx, 0
cmp ax, 0
jg XXX
dec si

YYY:
mov dl, [si]
mov ah, 02
int 21h
dec si
loop YYY
ret
popa
printwor endp


end main