.model small
.stack 64

keybuf segment at 40h
org 1Ah
headchar db 0
keybuf ends

.code
main proc far

mov cx, 10
printchar:
mov ah, 10h
int 16h

mov ax, keybuf
mov es, ax
mov di, 1Ah

mov dx, es:[di]
mov di, dx
dec di
dec di
mov al, es:[di]


inc al

mov ah, 02h
mov dl, al
int 21h
loop printchar
mov ax, 4c00h
int 21h

main endp
end main 