.model small
.stack 64
.data
str1 db 'Hello$'
len1 db $-str1
str2 db 'Hello$'
len2 db $-str2
y db 'Same$'
n db 'Different$'
.code
main proc far
mov ax, @data
mov ds, ax

lea si, str1
lea di, str2

mov al, len1
mov bl, len2
cmp al, bl
jne notsame
mov cl, len1 
XXX: 
mov al, [si]
mov bl, [di]
cmp al, bl
jne notsame
inc si
inc di
loop XXX

lea dx, y
mov ah, 09
int 21h
jmp finish

notsame: lea dx, n
mov ah, 09
int 21h

finish: mov ax, 4c00h
int 21h
main endp
end main

