
.model small
.stack 64
.386
.data
one dd 12h
.code
main proc far
mov ax, @data
mov ds, ax

mov eax, one
and eax, 0000FFFFh

mov ax, 4c00h
int 21h
main endp
end main
