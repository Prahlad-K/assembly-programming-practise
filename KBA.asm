.model small
.386
.stack 64
.data

datakb segment at 40h
org 17h ; contains the address of head of KBA
kbstate db ? 
datakb ends

temp db 10 dup(0)
c db 61h
shiftstr db 'You pressed left shift, LOL!$'
.code
main proc far
mov ax, datakb
mov es, ax

mov ah, 10h
int 16h 
; wait for it!

mov bl, es:kbstate
; literally
test bl, 00000011b
jz finish
print:
lea dx, shiftstr
mov ah, 09h
int 21h
jmp finish


comment @
mov al, 0
mov ah, 0Ch
int 21h ; clears the keyboard buffer area

mov di, 1Ch
mov dx, es:[di]
mov di, dx
mov al, c
mov es:[di], al 

mov di, 1Ch
mov dx, es:[di]
mov di, dx
inc di
inc di
mov al, 62h
mov es:[di], al

mov cx, 0
mov di, 1Ah
mov dx, es:[di]
mov di, dx ; storing address into di
mov dl, es:[di] ; getting character from KBA

mov ah, 02h
int 21h ; prints ascii value of KBA character stored.

mov dl, ' '
mov ah, 02h
int 21h ; prints space


mov di, 1Ah
mov dx, es:[di]
mov di, dx ; storing address into di

inc di
inc di

mov dl, es:[di]
mov ah, 02h
int 21h ; prints ascii value of KBA character stored.

mov ah, 02h
int 21h ; prints ascii value of KBA character stored.
@
finish:
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

mov dl, ' '
mov ah, 02h
int 21h

popa
ret
printbyt endp

end main
