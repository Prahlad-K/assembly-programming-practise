.model small
.stack 64
initz macro
mov ax, @data
mov ds, ax
mov es, ax
endm

finish macro
mov ax, 4c00h
int 21h
endm

.data
.code
main proc far
initz

mov ah, 02h
mov dl, '1'
int 21h

finish
main endp
end main