.model small
.stack 64
.386
.data
one db 40h
two db 15h
store db 0
sum db 'Add:$'
diff db 'Sub:$'
multi db 'Mul:$'
divi db 'Div:$'
temp db ?
.code
main proc far
mov ax, @data
mov ds, ax ; initialization of data segment

mov ah, 09h
lea dx, sum
int 21h

mov al, one
add al, two
mov ah, 0
mov dx, 0
call printbyte
;addition completed

mov ah, 09h
lea dx, diff
int 21h

call reset ; resets all registers to original state
mov al, one
sub al, two
mov ah, 0
mov dx, 0
call printbyte
; subtraction completed


mov ah, 09h
lea dx, multi
int 21h

call reset
mov al, one
mov bl, two
mul bl
mov bl, 0
call printbyte
; multiplication completed

mov ah, 09h
lea dx, divi
int 21h

call reset
mov al, one
mov bl, two
div bl
mov store, dl
mov bl, 0
mov ah, 0
call printbyte; printing the quotient

mov al, store
mov ah, 0
call printbyte; printing the remainder
; division completed

mov ax, 4c00h
int 21h

main endp

printbyte proc near
pusha
lea si, temp
mov bl, 16
mov bh, '$'
mov cl, 0
; always remember, during printing the character is echoed to al! 
XXX:
div bl
mov dl, ah
cmp ah, 10
jge alpha
add dl, 30h
jmp notalpha
alpha: add dl, 55
notalpha: mov [si], dl
inc si
inc cl
mov ah, 0
cmp al, 0
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
int 21h; prints space after the word
popa
ret
printbyte endp

reset proc near
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
ret
reset endp

end main
