.model small
.stack 64
.data
str1 db 'Computer$'
str2 db ?
.code
main proc far
mov ax, @data
mov ds, ax; initialization of data segment

mov cl, 0
lea si, str1

mov bl, '$'
XXX: inc si
inc cl
cmp [si], bl
jne XXX

dec si
lea di, str2
YYY: mov al, [si]
mov [di], al
dec si
inc di
dec cl
jnz YYY

mov [di], bl
lea dx, str2
mov ah, 09
int 21h

mov ax, 4c00h
int 21h

main endp
end main
