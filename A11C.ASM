.model small
.stack 64
.data
str db 'Hello' ; indexing starts from 0
len db $-str
char db 'e'
index db 0
.code
main proc far
mov ax, @data
mov ds, ax

lea si, str
mov cl, len
repeat:
mov al, [si]
mov bl, char
cmp al, bl
je found
inc si
inc index
loop repeat

found: mov dl, index
add dl, 30h
mov ah, 02
int 21h

mov ax, 4c00h
int 21h

main endp
end main

