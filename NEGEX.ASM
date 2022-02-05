.model small
.stack 64
.386
.data
one db 10h
two db 0FFh
temp db ?
.code
main proc far
mov ax, @data
mov ds, ax

mov ah, 0
mov al, one
mov bl, two
cmp ax, bx
jl negative
sub al, bl
call printbyte
jmp finish

negative:
sub al, bl
call printminus
neg al ; apparently produces 2s complement directly!
call printbyte
jmp finish

finish:
mov ax,4c00h
int 21h
main endp

printbyte proc near
pusha
mov ah, 0
lea si, temp
mov bl, 16
mov cx, 0
XXX:
div bl
mov dl, ah
cmp ah, 10
jge alpha
add dl, 30h
jmp notalpha
alpha: add dl, 55
notalpha:
mov [si], dl
inc si
inc cx
mov ah, 0
cmp al, 0
jg XXX
dec si

YYY:
mov dl, [si]
mov ah, 02h
int 21h
dec si
loop YYY

popa
ret
printbyte endp

printminus proc near
pusha
mov dl, '-'
mov ah, 02
int 21h
popa
ret
printminus endp
end main

