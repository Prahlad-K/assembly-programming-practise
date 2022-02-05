.model small
.stack 64
.data
str db 'P$'
ctr db 80
k db 0
i db 250
j db 250
.code
main proc far
mov ax, @data
mov ds, ax

XXX:
call clrscr
call reset

mov dh, k
inc k
call setcur

lea dx, str
mov ah, 09h
int 21h ; prints the string

call delayloop

dec ctr
cmp ctr, 0
jnz XXX

mov  ax, 4c00h
int 21h

main endp

delayloop proc near
YYY:
dec j 
ZZZ: dec i
cmp i, 0
jne ZZZ
cmp j, 0
jne YYY
call reset
ret
delayloop endp

clrscr proc near
mov ax, 0600h
mov bh, 07
mov cx, 0000h
mov dx, 184Fh
int 10h ; clears the screen.
ret
clrscr endp

setcur proc near
mov ah, 02h
mov bh, 0
mov dl, 08
int 10h; sets cursor to 8 row, ctr column position of page-0.
call reset
ret
setcur endp

reset proc near
mov ax, 0
mov bx, 0
mov cx, 0
mov dx, 0
ret
reset endp

end main
