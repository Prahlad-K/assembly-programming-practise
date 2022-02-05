.model small
.stack 64
.386
.data
filepath db 'c:\data.txt', 0
row db 0
cr equ 0Ah
lf equ 0Dh
menu db 'File  Edit'
     db 70 dup(20h) 
file db 'New  ', cr, lf
     db 'Save '
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

mov ax, 0003h
int 10h

mov ah, 06h
mov al, 00h
mov bh, 10h
mov cx, 00
mov dx, 184Fh
int 10h

mov ah, 3Ch
mov cx, 00
lea dx, filepath
int 21h

mov ax, 1301h
mov cx, 80
mov bx, 0070h
mov dh, row
mov dl, 0
lea bp, menu
int 10h

mov ah, 10h
int 16h

cmp al, 'f'
jne finish
inc row
mov ax, 1301h
mov cx, 12
mov bx, 0070h
mov dh, row
mov dl, 0
lea bp, file
int 10h


finish:
mov ax, 4c00h
int 21h

main endp
end main

