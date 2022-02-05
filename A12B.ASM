.model small
.stack 64
.data
one dw 6532h
two dw 4024h
temp db ?
store dw ?
sum db 'Add:$'
diff db 'Sub:$'
multi db 'Mul:$'
divi db 'Div:$'
.code
main proc far
mov ax, @data
mov ds, ax ; initialization of data segment

mov ah, 09h
lea dx, sum
int 21h

mov ax, one
add ax, two
mov dx, 0
call printword
call reset
;addition completed

mov ah, 09h
lea dx, diff
int 21h

call reset ; resets all registers to original state
mov ax, one
sub ax, two
call printword
call reset

; subtraction completed

mov ah, 09h
lea dx, multi
int 21h

call reset
mov ax, one
mov bx, two
mul bx
mov bx, 0
mov store, dx
call printword
call reset
mov ax, store
call printword
call reset
; multiplication completed

mov ah, 09h
lea dx, divi
int 21h

call reset
mov ax, one
mov bx, two
div bx
mov store, dx
mov bx, 0
call printword
call reset; printing the quotient

mov ax, store
call printword
call reset; printing the remainder
; division completed

mov ax, 4c00h
int 21h

main endp

printword proc near
lea si, temp
mov dx, 0
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

mov dl, ' '
mov ah, 02h
int 21h; prints a space after the word

ret
printword endp

reset proc near
sub ax, ax
sub bx, bx
sub cx, cx
sub dx, dx
sub si, si
sub di, di
ret
reset endp

end main
