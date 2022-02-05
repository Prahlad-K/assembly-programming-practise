.model small
.stack 64
.data
asciiz db 'C:\prahlad', 0
.code
main proc near
mov ax, @data
mov ds, ax

mov ah, 3Ah
lea dx, asciiz
int 21h

mov ax, 4c00h
int 21h

main endp
end main