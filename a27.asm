.model small
.386
.stack 64
.data
temp db 100 dup(0)
esckey db 'You have pressed esc key.$'
cmin db 0
csec db 0
nmin db 0
nsec db 0
.code
main proc far
mov ax, @data
mov ds, ax

mov ah, 05h
mov al, 0
int 10h

mov ah, 2Ch
int 21h

mov nmin, cl
mov nsec, dh

add dh, 5
mov al, dh
mov ah, 0
mov bl, 60
div bl

cmp al, 0
je didntcross

add nmin, al
mov nsec, ah
jmp is20secpast

didntcross:
mov nsec, ah

is20secpast:
mov ah, 2Ch
int 21h

cmp nmin, cl
jne is20secpast

cmp nsec, dh
jne is20secpast
; after 5 seconds, comes here.

mov ah, 06h
mov al, 0 ; clearing screen
mov bh, 70h
mov cx, 0000h
mov dx, 184Fh
int 10h
; clearing screen with beautiful attribute.

enterchar:
mov ah, 10h
int 16h

inc al

mov ah, 02h
mov bh, 0
mov dh, 12
mov dl, 40
int 10h ; sets cursor

mov ah, 09h
mov bh, 0
mov bl, 07h
mov cx, 1
int 10h ; prints

cmp al, 1Ch
jne enterchar

finish:
mov ax, 4c00h
int 21h
main endp
end main