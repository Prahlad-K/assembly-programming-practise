.model small ; this algorithm uses selection sort.
.stack 64
.data
array db 4, 5, 2, 3, 1
min db ?
.code
main proc far
mov ax, @data
mov ds, ax

lea si, array
mov bx, 5

doagain:
lea si, array
mov cl, 5
mov al, [si]
mov min, al
inc si
dec cl

XXX:
mov al, [si]
cmp al, min
jg dontswap
xchg al, min
dontswap: inc si
dec cl
jnz XXX
;now min contains minimum element.

lea si, array
mov cl, 5
YYY:
mov al, [si]
cmp al, min
jne notmin
mov al, 10
mov [si], al
notmin: inc si
dec cl
jnz YYY
;increasing minimum value in array to a large value.

mov dl, min
add dl, 30h
mov ah, 02h
int 21h; printing minimum

mov dl, ' '
int 21h ; printing minimum

dec bx
jnz doagain

mov ax, 4c00h
int 21h

main endp
end main


