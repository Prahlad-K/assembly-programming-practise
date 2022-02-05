.model small
.stack 64
.data
beep db 07h
.code
main proc far
mov ax, @data
mov ds, ax

mov dl, beep
mov ah, 02
int 21h

mov ax, 4c00h
int 21h

main endp
end main