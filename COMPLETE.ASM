.model small
.stack 64
.data
one db 60
two db 63
.code
main proc far
mov ax,@data
mov ds, ax

mov al,one
add al,two

mov cl,3
XXX mov ah,0
mov bl,10
div bl
mov dl,ah
add dl,30h
mov ah,02
int 21h
dec cl
jnz XXX

mov ax,4c00h
int 21h
main endp
end main

