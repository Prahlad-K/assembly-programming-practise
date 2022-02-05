.model small
.stack 64
.data
one db 11h, 22h, 33h
temp db ?
.code
main proc far
mov ax, @data
mov ds, ax

lea si, one
lea di, temp
mov ax, [si]

mov [di], ax

mov ax, [di]

mov ax, 4c00h
int 21h
main endp
end main