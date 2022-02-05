.model small
.stack 64
.data
one dw 8857h
temp db ?
.code
main proc far
mov ax, @data
mov ds, ax

lea si, temp

mov ax, one
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

mov ax, 4c00h
int 21h

main endp
end main
; this program effectively prints words!!


