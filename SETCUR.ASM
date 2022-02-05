.model small
.stack 64
.386
.data
n db 'Prahlad$'
.code
main proc far
mov ax, @data
mov ds, ax

mov al, 0 ; clearing the screen
call scroll

mov bh, 0 ; specifying the page number 0 is default anyway
call setcur

mov ah, 09h
lea dx, n
int 21h
call delay
mov al, 23
call scroll

mov ax, 4c00h
int 21h
main endp

setcur proc near
pusha
mov ah, 02
mov dx, 1310h
int 10h; sets the cursor
popa
ret
setcur endp

scroll proc near ; for scrolling/clearing the screen, we never need the page number!
pusha
mov ah, 06
mov bh, 27h ; 7- white background and 1-blue foreground.
mov cx, 0000h
mov dx, 184Fh
int 10h; sets the attribute of white background and blue foreground.
popa
ret
scroll endp

delay proc near
pusha
mov ah, 10h
int 16h
popa
ret
delay endp

end main