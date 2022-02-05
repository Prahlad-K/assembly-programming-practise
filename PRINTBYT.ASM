.model small
.stack 64
.data
one dw 00FFh
temp db ?
.code
main proc far
mov ax, @data
mov ds, ax

lea si, temp

mov ax, one
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
notalpha:
mov [si], dl
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

mov ax, 4c00h
int 21h

main endp
end main
; this program effectively prints bytes!!


