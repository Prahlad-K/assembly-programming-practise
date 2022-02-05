.model small
.stack 64
.data
array db 1, 2, 3, 4, 7
pres db 2
sum db ?
avg db ?
rem db ?
space db ' '
dot db '.'
.code
main proc far
mov ax, @data
mov ds, ax

lea si, array
mov cl, 4
mov al, [si]
inc si
XXX:
add al, [si]
inc si
dec cl
jnz XXX
mov sum, al
; sum is calculated-assuming sum is of 2 digits
mov ah, 0
mov bl, 10 
; printing sum
div bl
mov rem, ah
mov dl, al
add dl, 30h
mov ah, 02h
int 21h
; quotient is printed, and remainder is stored.
mov dl, rem
add dl, 30h
int 21h
; sum successfully printed

mov dl, space
int 21h ; printing a space

; printing average.
mov al, sum
mov bl, 5
mov ah, 0
div bl
mov avg, al ; quotient is average
mov rem, ah ; storing remainder
mov ah, 02
mov dl, avg
add dl, 30h
int 21h
cmp rem, 0
je nodec

mov dl, dot
int 21h ; printing the decimal point

mov cl, pres ; depending on a defined precision
precision:
mov al, rem
mov bl, 10
mul bl
mov bl, 5
mov ah, 0
div bl
mov rem, ah
mov avg, al
mov dl, avg
add dl, 30h
mov ah, 02h
int 21h
cmp rem, 0
je nodec
loop precision
; average successfully printed.
nodec:mov ax, 4c00h
int 21h
main endp
end main
