.model small
.stack 64
.data
str db '255','$'
len db $-str ; comes as 4
num db 0
array db 3 dup(0)
.code ; conversion of string to integer
main proc far
mov ax, @data
mov ds, ax ; initialization of data segment

lea si, str
mov cl, len
dec cl; finds the length of string

XXX:
mov al, [si]
sub al, 30h
mov [si], al
inc si
loop XXX

lea si, str
mov bl, 100
mov bh, 10
mov cl, len
YYY:
mov al, [si]
mul bl
add num, al
mov al, bl
div bh
mov bl, al; divides bl by 10, everytime.
inc si
loop YYY

mov al, num ; final result stored in al.

lea si, array
mov bl, 10
mov ch, 0
mov cl, len
dec cl

getnumber:
div bl
mov dl, ah
add dl, 30h
mov [si], dl
mov ah, 0
inc si
loop getnumber

mov ch, 0
mov cl, len
dec cl
dec si
printnumber:
mov dl, [si]
mov ah, 02h
int 21h
dec si
loop printnumber

mov ax, 4c00h
int 21h
main endp
end main
