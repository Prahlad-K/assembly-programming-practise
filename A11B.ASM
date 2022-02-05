.model small
.stack 64
.data
str1 db 'SystemsProgramming$' ; has 19 letters
num db 7 
str2 db ?
error db 'Num greater than str1!$'
.code
main proc far
mov ax, @data
mov ds, ax

lea si, str1
mov bl, '$'

mov cl, 0
YYY: inc si
inc cl
mov al, [si]
cmp al, bl
jne YYY ; finding length of string-excluding dollar

cmp num, cl 
jg XXX  ; comparing with n, to find error. 
mov cl, num
lea si, str1
lea di, str2
ZZZ: mov al, [si]
mov [di], al
inc si
inc di
dec cl
jnz ZZZ

mov [di], bl
lea dx, str2
mov ah, 09
int 21h
jmp WWW  ; copied string printed

XXX: lea dx, error
mov ah, 09
int 21h  ; error printed

WWW: mov ax, 4c00h
int 21h

main endp
end main
