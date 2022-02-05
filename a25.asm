.model small
.stack 64
.386
.data
toprow equ 08
botrow equ 20
lefcol equ 20
count db 0
box db 0C9h, 27 dup(0CDh), 0BBh
    db 0BAh, 'C:\>', 23 dup(' '), 0BAh
    db 0BAh, 27 dup(' '), 0BAh
    db 0BAh, 27 dup(' '), 0BAh
    db 0BAh, 27 dup(' '), 0BAh
    db 0BAh, 27 dup(' '), 0BAh
    db 0BAh, 27 dup(' '), 0BAh
    db 0BAh, 27 dup(' '), 0BAh
    db 0BAh, 27 dup(' '), 0BAh
    db 0BAh, 27 dup(' '), 0BAh
    db 0BAh, 27 dup(' '), 0BAh
    db 0BAh, 27 dup(' '), 0BAh
    db 0C8h, 27 dup(0CDH), 0BCh

.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

mov ah, 06h
mov al, 00
mov bh, 07h
mov cx, 0000h
mov dx, 184Fh
int 10h ; clearing the screen

mov ax, 1300h
mov bx, 0007h
lea bp, box
mov cx, 29
mov dh, toprow
mov dl, lefcol

printbox:
int 10h
add bp, 29
inc dh
cmp dh, botrow+1
jne printbox
mov dl, 25
mov dh, 9
takeinput:
mov ah, 02h
mov bh, 00
int 10h

mov ah, 10h
int 16h

call checkinput

inc count
cmp count, 200
jne takeinput

mov ax, 4c00h
int 21h

main endp

checkinput proc near

cmp al, 0E0h
jne notex

cmp ah, 47h
jne nothome
mov dl, lefcol+1
jmp finish 

nothome:
cmp ah, 4Fh
jne finish
mov dl, lefcol+27
jmp finish

notex:
cmp al, 08h
jne notbksp

cmp dl, lefcol+1
jne normalbksp
mov dl, lefcol+27
dec dh
jmp contbksp


normalbksp:
dec dl

contbksp:
mov ah, 02h
mov bh, 00
int 10h

mov ah, 0Ah
mov bh, 0
mov al, 0
mov cx, 1
int 10h
jmp finish

notbksp:
cmp al, 1Bh
jne notesc
mov ax, 4c00h
int 21h

notesc:
cmp al, 0Dh
jne notenter

inc dh
mov dl, lefcol+1

jmp finish

notenter:

cmp dl, lefcol+27
jne notlast
mov dl, lefcol
inc dh

notlast:
mov ah, 0Ah
mov bh, 0
mov cx, 1
int 10h
inc dl

finish:

ret
checkinput endp
end main

