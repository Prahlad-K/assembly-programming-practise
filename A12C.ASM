.model small
.stack 64
.386
.data
one dd 54321234h
two dd 34251468h
temp dd 0
store dd 0
bytstore db ?
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

mov eax, one
add eax, two
mov temp, eax
mov cl, 16
shr eax, cl
call printword
call reset
mov eax, temp
and eax, 0000FFFFh
call printword
;addition completed

mov ah, 09h
lea dx, diff
int 21h

call reset; resets all registers to original state
mov eax, one
sub eax, two
mov temp, eax
mov cl, 16
shr eax, cl
call printword
call reset
mov eax, temp
;and eax, 0000FFFFh
call printword
; subtraction completed

mov ah, 09h
lea dx, multi
int 21h

call reset
mov eax, one
mov ebx, two
mul ebx
mov ebx, 0
mov store, eax

; printing edx first
mov eax, edx
mov temp, eax
mov cl, 16
shr eax, cl
call printword
call reset
mov eax, temp
call printword

; printing edx now
mov eax, store
mov temp, eax
mov cl, 16
shr eax, cl
call printword
call reset
mov eax, temp
call printword
; multiplication completed

mov ah, 09h
lea dx, divi
int 21h

call reset 
mov eax, one
mov ebx, two
div ebx
mov ebx, 0
mov temp, eax
mov store, edx
mov cl, 16
shr eax, cl
call printword
call reset
mov eax, temp
call printword; printing the quotient

mov eax, store
mov temp, eax
mov cl, 16
shr eax, cl
call printword
call reset
mov eax, temp
call printword; printing the remainder

; division completed

mov ax, 4c00h
int 21h

main endp

printword proc near
pusha
lea si, bytstore
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
popa
ret
printword endp

reset proc near
sub eax, eax
sub ebx, ebx
sub ecx, ecx
sub edx, edx
sub si, si
sub di, di
ret
reset endp

end main
