.model small
.stack 64
.data
one db 10
two db 20
rem db ?
.code
main proc far
mov ax, @data
mov ds, ax

mov al,one
add al,two
mov ah,0
mov bl,10
div bl

add al,30h
mov dl,al
mov rem,ah ;the remainder is stored
mov ah,02
int 21h    ;the quotient is printed

mov al,rem
add al,30h
mov dl,al
int 21h    ;the remainder is printed


mov ax,4c00h
int 21h
main endp
end main
