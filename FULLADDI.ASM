.model small
.stack 64
.data
one db 1
two db 2
rem db ?
.code
main proc far
mov ax,@data
mov ds,ax ;initialisation of data segment

mov al,one
add al,two
mov ah,0
mov bl,10 ;assuming the precision is 2 digit
div bl

add al,30h
mov dl,al
mov rem,ah ;storing the remainder
mov ah,02
int 21h ;quotient is printed

mov al,rem
add al,30h
mov dl,al
int 21h ;remainder is printed

mov ax,4c00h
int 21h
main endp
end main
