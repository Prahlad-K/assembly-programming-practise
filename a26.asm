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

mov ah, 0Fh
int 10h
push ax

mov ah, 10h
int 16h

cmp al, 1Bh ; esc key
jne finish

mov ah, 05h
mov al, 0
int 10h

mov ah, 06h
mov al, 0 ; clearing screen
mov bh, 65h
mov cx, 0000h
mov dx, 184Fh
int 10h
; clearing screen with beautiful attribute.

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

finish:

pop ax
mov ah, 00h
int 10h

mov ax, 4c00h
int 21h
main endp

printbyt proc near
pusha
lea si, temp

mov bl, 16
mov bh, '$'
mov cl, 0
; always remember, during printing the character is echoed to al! 
XXX:
div bl
mov dl, ah
cmp ah, 10
jge alpha

add dl, 30h
jmp notalpha

alpha: add dl, 55
notalpha:
mov [si], dl
inc si
inc cl
mov ah, 0
cmp al, 0
jg XXX
dec si

YYY:
mov dl, [si]
mov ah, 02
int 21h
dec si
loop YYY
popa
ret
printbyt endp
end main
