.model small
.stack 64
.data
i db 5
j db 6
char db 0
row db 21
col db 77
.code
main proc far
mov ax, @data
mov ds, ax

call clrscr

mov dx, 0505h
call setcur
call print1


mov dx, 054Dh
call setcur
call print2

mov dx, 1505h
call setcur
call print3

mov dx, 154Dh
call setcur
call print4

first:
mov dh, 5
mov dl, j ; j starts from 11, already char there at 10.
call setcur
call horprint
inc j
cmp j, 76
jle first

mov j, 6
last:
mov dh, 21
mov dl, j ; j starts from 11 again
call setcur
call horprint
inc j
cmp j, 76
jle last

; i must be looped from 6 to 20, and || must be printed at beginning and end 
mov i, 6

continue:
mov j, 5
repeat:
cmp j, 5
jne checklast
mov dh, i
mov dl, j
call setcur
call verprint

checklast:
cmp j, 77
jne dontprint
mov dh, i
mov dl, j
call setcur
call verprint

dontprint:
inc j
cmp j, 77
jle repeat
inc i
cmp i, 20
jle continue

; the box is printed.
; printing all ASCII characters.
; box contents start from 6, 6 and end at 20, 76;because the remaining is border
mov cl, 128
mov i, 6
rep2:
mov j, 6
rep1:
mov dh, i
mov dl, j
call setcur
mov dl, char
inc char
mov ah, 02
int 21h
call reset ; prints ascii
inc j
cmp j, 76
jle rep1
inc i
cmp i, 20
jle rep2

mov ax, 4c00h
int 21h
main endp

clrscr proc near
mov ax, 0600h
mov bh, 07
mov cx, 0000h
mov dx, 184Fh
int 10h ; clears the screen.
call reset
ret
clrscr endp

setcur proc near
mov ah, 02h
mov bh, 0
int 10h; sets cursor to i row, j column position of page-0.
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

print1 proc near ; for 0, 0
mov dl, 11001001b; don't know why hex doesn't work
mov ah, 02
int 21h
call reset
ret
print1 endp

print2 proc near ; for 0, 1
mov dl, 10111011b; don't know why hex doesn't work  BB
mov ah, 02
int 21h
call reset
ret
print2 endp

print3 proc near ; for 1, 0
mov dl, 11001000b; don't know why hex doesn't work   C8
mov ah, 02
int 21h
call reset
ret
print3 endp

print4 proc near ; for 1, 1
mov dl, 10111100b; don't know why hex doesn't work  BC
mov ah, 02
int 21h
call reset
ret
print4 endp

horprint proc near
mov dl, 11001101b
mov ah, 02
int 21h
call reset
ret
horprint endp

verprint proc near
mov dl, 10111010b
mov ah, 02
int 21h
call reset
ret
verprint endp

printspace proc near
mov dl, ' '
mov ah, 02
int 21h
call reset
ret
printspace endp

end main
