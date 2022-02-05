.model small
.stack 64
.386
.data
n db 'Prahlad$'
temp db 0
store db 100 dup(0)
count db 0
row db 0
curpage db 0
nextpage db 1
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

startagain:
call clrscr

mov bh, 0
mov dx, 0000h
call setcur
write0:
mov ah, 09h
mov al, '0'
mov bl, 07h
mov cx, 79
int 10h
inc dh
call setcur
cmp dh, 25
jl write0

mov bh, 1
mov dx, 0000h
call setcur
write1:
mov ah, 09h
mov al, '1'
mov bl, 07h
mov cx, 79
int 10h
inc dh
call setcur
cmp dh, 25
jl write1

mov bh, 2
mov dx, 0000h
call setcur
write2:
mov ah, 09h
mov al, '2'
mov bl, 07h
mov cx, 79
int 10h
inc dh
call setcur
cmp dh, 25
jl write2

mov bh, 3
mov dx, 0000h
call setcur
write3:
mov ah, 09h
mov al, '3'
mov bl, 07h
mov cx, 79
int 10h
inc dh
call setcur
cmp dh, 25
jl write3

; writing to the files completed.

; cyclic scrolling starts

changepage:
mov ah, 05h
mov al, curpage
int 10h

call delay
scroll01:
call scroll

mov ah, 02h
mov bh, nextpage
mov dh, row
mov dl, 0
int 10h

lea si, store
mov cx, 79

storetemp:
mov ah, 08h
mov bh, nextpage
int 10h

mov [si], al
inc si

mov ah, 02h
mov bh, nextpage
inc dx
int 10h ; sets the cursor one col at a time.

loop storetemp
; reads the character in the 1st page.

mov ah, 13h
mov al, 00
mov bh, curpage
mov bl, 07h
lea bp, store
mov cx, 79
mov dh, 24
mov dl, 0 ; prints to the end of the first page.
int 10h
call delay

inc row
cmp row, 25
jl scroll01

inc count
inc curpage
inc nextpage
mov row, 0

cmp count, 3
jl changepage
cmp count, 3
je change3to0
mov curpage, 0
mov nextpage, 1
mov count, 0
mov row, 0

jmp startagain

change3to0:
mov curpage, 3
mov nextpage, 0
mov row, 0

mov bh, 0
mov dx, 0000h
call setcur
writeagain:
mov ah, 09h
mov al, '0'
mov bl, 07h
mov cx, 79
int 10h
inc dh
call setcur
cmp dh, 25
jl writeagain

jmp changepage


mov ax, 4c00h
int 21h
main endp

setcur proc near
mov ah, 02h
int 10h; sets the cursor
ret
setcur endp

clrscr proc near
mov ah, 06
mov al, 0 ; clearing the screen
mov bh, 21h
mov cx, 0000h
mov dx, 184Fh
int 10h
ret
clrscr endp

scroll proc near
mov ah, 06
mov al, 01 ; scrolling the screen by one line
mov bh, 07h
mov cx, 0000h
mov dx, 184Fh
int 10h
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



