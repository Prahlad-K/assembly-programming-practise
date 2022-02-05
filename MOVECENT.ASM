.model small
.stack 64
.386
.data
r1 db 1
r2 db 1
r3 db 24
r4 db 24
c1 db 0
c2 db 79
c3 db 0
c4 db 79
.code
main proc far
mov ax, @data
mov ds, ax

repeat:
call clrscr

mov bh, 0
mov dh, r1
mov dl, c1
call setcur
mov al, 'a'
call printcharattr
cmp r1, 12
je gotoc1
inc r1
gotoc1:
cmp c1, 38
je done 
inc c1

mov bh, 0
mov dh, r2
mov dl, c2
call setcur
mov al, 'a'
call printcharattr
cmp r2, 12
je gotoc2
inc r2
gotoc2:
cmp c2, 38
je done 
dec c2

mov bh, 0
mov dh, r3
mov dl, c3
call setcur
mov al, 'a'
call printcharattr
cmp r3, 12
je gotoc3
dec r3
gotoc3:
cmp c3, 38
je done 
inc c3

mov bh, 0
mov dh, r4
mov dl, c4
call setcur
mov al, 'a'
call printcharattr
cmp r1, 12
je gotoc4
dec r4
gotoc4:
cmp c4, 38
je done 
dec c4

call delayloop

jmp repeat

done:
mov ax, 4c00h
int 21h
main endp

setcur proc near ; set pageno-bh and rowcol-dx before calling this method.
mov ah, 02h
int 10h
ret
setcur endp

clrscr proc near 
mov ah, 06h
mov al, 00
mov bh, 12h
mov cx, 0000h
mov dx, 184Fh
int 10h
ret
clrscr endp

scroll proc near ; 
mov ah, 06h
int 10h
ret
scroll endp

printcharattr proc near ; 
mov ah, 09h
mov bh, 0
mov bl, 01h
mov cx, 1
int 10h
ret
printcharattr endp

delayloop proc near
pusha
mov ah, 10h
int 16h
popa
ret
delayloop endp
end main