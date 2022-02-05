dosseg
.model small
.stack 64
.data
.code
main proc far

mov ah, 1
int 21h  ; input is taken from the user
mov dl, al
mov ah, 2
int 21h  ; output is observed by the user

mov ax, 4c00h
int 21h

main endp
end main




