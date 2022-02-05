.386
.model small
.stack 64
.data
one dd 00002F18h
temp db ?
.code
main proc far
mov ax, @data
mov ds, ax

lea si, temp

mov eax, one
mov edx, 0
mov ebx, 16
mov cl, 0
; always remember, during printing the character is echoed to ax! 
XXX:
div ebx
cmp edx, 10
jge alpha

add dl, 30h
jmp notalpha

alpha: add dl, 55
notalpha:
mov [si], dl
inc si
inc cl
mov edx, 0
cmp eax, 0
jg XXX
dec si

YYY:
mov dl, [si]
mov ah, 02
int 21h
dec si
loop YYY

mov ax, 4c00h
int 21h

main endp
end main
; this program effectively prints double words!!


