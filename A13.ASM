.model small
.stack 64
.data
array db 1, 5, 3, 6, 8
min db ?
max db ?
.code
main proc far
mov ax, @data
mov ds, ax

lea si, array
mov cl, 5

mov al, [si]
mov min, al
inc si
dec cl
findmin:
mov al, [si]
cmp al, min
jg dontswap1
xchg al, min
dontswap1: inc si
dec cl
jnz findmin

lea si, array
mov cl, 5

mov al, [si]
mov max, al
inc si
dec cl
findmax:
mov al, [si]
cmp al, max
jl dontswap2
xchg al, max
dontswap2: inc si
dec cl
jnz findmax

mov ah, 02h

mov dl, min
add dl, 30h
int 21h

mov dl, ' '
int 21h

mov dl, max
add dl, 30h
int 21h

mov ax, 4c00h
int 21h

main endp
end main

