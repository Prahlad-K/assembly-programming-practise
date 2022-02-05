.model small
.stack 72
.data
str db 'Hello$'
strsiz db 0
.code
main proc far
mov ax, @data
mov ds, ax

lea si, str
strsiz equ ($-str)
mov dl, strsiz
add dl, 30h
mov ah, 02
int 21h

mov ax, 4c00h
int 21h

main endp
end main
