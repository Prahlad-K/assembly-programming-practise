page 60, 132
stack segment para stack 'stack'
db 64 dup(0)
stack ends

dataseg segment para 'data'
one dw 12
two dw 12
temp db ?
rem db ?
dataseg ends

codeseg segment para 'code'
main proc far
assume CS:codeseg, DS: dataseg, SS: stack
mov ax, dataseg
mov ds, ax

mov ax, one
add ax, two
mov temp, ah
mov ah, 0
mov bx, 0Ah 
div bx
mov rem, ah
mov dl, al
add dl, 30h
mov ah, 02
int 21h

mov dl, rem
add dl, 30h
mov ah, 02
int 21h

mov ax, 4c00h
int 21h

main endp
codeseg ends
end main



