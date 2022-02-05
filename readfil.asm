.model small
.stack 64
.data
pathname db 'c:\firstfil.dat', 0
recarea db 100 dup(0)
string db '1234567'
filehand dw ?
.code
main proc far
mov ax, @data
mov ds, ax

mov ah, 03Dh
mov al, 02 ; read only purpose
lea dx, pathname
int 21h
mov filehand, ax

mov ah, 42h
mov al, 01
mov bx, filehand
mov cx, 00
mov dx, 07
int 21h ; set the cursor to one record extra

mov ah, 40h
mov bx, filehand
mov cx, 07
lea dx, string
int 21h ; writing 1234567

mov ah, 42h
mov al, 00
mov bx, filehand
mov cx, 00
mov dx, 00
int 21h ; set the cursor to starting

mov ah, 03Fh
mov bx, filehand
mov cx, 14
lea dx, recarea
int 21h

mov recarea[14], '$'

mov ah, 09h
lea dx, recarea
int 21h

mov ax, 4c00h
int 21h


main endp
end main

