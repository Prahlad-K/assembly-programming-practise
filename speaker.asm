.model small
.stack 64 
.data
duration dw 10000
tone dw 512h

.code
main proc far
mov ax, @data
mov ds, ax

in al, 61h
push ax

A20: mov dx, duration

A30: 
or al, 00000011b
out 61h, al ; now the speaker is on
mov cx, tone

A40:
loop A40

or al, 00000010b
out 61h, al
mov cx, tone

A50:
loop A50

dec dx
jnz A30
shl duration, 1
shr tone, 1
jnz A20

pop ax
and al, 11111100b
out 61h, al

mov ax, 4c00h
int 21h

main endp
end main
