.model small
.stack 64
.386
.data
process db 0
array db 4 dup(0)
temp db ?
.code
main proc far
mov ax, @data
mov ds, ax

mov ah, 10h
int 16h ; takes character input.

cmp al, 39h
jg alpha1
sub al, 30h
shl al, 4
jmp done1
alpha1:
sub al, 55
shl al, 4 ; stores first hex bit of the byte.

done1:
mov process, al

mov ah, 10h
int 16h ; takes character input.

cmp al, 39h
jg alpha2
sub al, 30h
jmp done2
alpha2:
sub al, 55
; stores second hex bit of the byte.

done2:
and ax, 00001111b
add al, process
mov ah, 0
call printbyte
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
end main