dosseg
.model small
.stack 64
.data
one db 1
two db 21
three db 3
four db 14
space db ' '
dot db '.'
sum db ?
rem db ?
.code
main proc far
mov ax, @data
mov ds, ax

mov al, one
add al, two
add al, three
add al, four
mov sum, al
mov ah, 0
mov bl, 10
div bl     ; Multi digit number, so divide with 10.
mov bl, ah ; Storing remainder into bl, anyway work done with bl.
add al, 30h
mov dl, al  ; Printing quotient first
mov ah, 02
int 21h
add bl, 30h ; Printing remainder (bl) next.
mov dl, bl
int 21h    ; Thus, sum is printed.

mov dl, space
int 21h    ; Seperation between sum and avg.

mov cl, 2  ; Precision of average is 2 digits.
mov al, sum
mov ah, 0
mov bl, 4
div bl     ; Sum is divided by number of numbers.
mov dl, al ;  Quotient is printed.
mov rem, ah
add dl, 30h
mov ah, 02
int 21h

mov dl, dot
int 21h ; Decimal printed

XXX:
mov al, rem
mov bh, 10
mov ah, 0
mul bh
mov ah, 0
div bl
mov rem, ah ; The next remainder is stored.
mov dl, al
mov ah, 02
add dl, 30h ; Quotient is printed.
int 21h
dec cl
jnz XXX

mov ax,4c00h
int 21h
main endp
end main
