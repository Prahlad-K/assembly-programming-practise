.model small
.stack 64
.data
str db 'Prahlad$'
i db 0
cnt db 80
c dw 1000
.code
main proc far
mov ax, @data
mov ds, ax

XXX:
mov ah, 06
mov bh, 71h
mov cx, 0000h
mov dx, 184Fh
int 10h
;clearing the screen

mov ah, 02
mov bh, 0
mov dh, 8
mov dl, i
int 10h
;setting the cursor

mov dl, 'A'
mov ah, 02
int 21h
;printing str on screen ;)

YYY:
dec c
jnz YYY
mov c, 1000

inc i
dec cnt
jnz XXX

mov ax, 4c00h
int 21h

main endp
end main
