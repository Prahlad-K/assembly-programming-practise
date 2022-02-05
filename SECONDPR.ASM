.model small
.stack 64
.data
one db 5
two db 4
.code
main proc far
mov AX, @data
mov DS, AX

mov AL, one
add AL, two
add AL, 30h
mov AH, 02
mov DL, AL
int 21h
mov AX, 4c00h
int 21h
main endp
end main
