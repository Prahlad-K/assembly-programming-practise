.model small
.stack 64
.data
str1 db 'assembly$'
len1 db $-str1
str2 db ?
.code
main proc far
mov ax, @data
mov ds, ax

lea si, str1
lea di, str2

mov cl, len1

lea si, str1

XXX: mov al, [si]
mov [di], al
inc si
inc di
dec cl
jnz XXX  ; copying string1 into string2.

lea dx, str2
mov ah, 09
int 21h  ; printing string2.

mov ax, 4c00h
int 21h

main endp
end main
