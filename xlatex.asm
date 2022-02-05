; this program effectively translates characters to numbers. //strings to decimal numbers.
.model small
.stack 64
.data
xlat_table db 49 dup(0h)
           db 1h, 2h, 3h, 4h, 5h, 6h, 7h, 8h, 9h

characters db '1234', '$'
len dw $-characters ; actually gives 5. Must reduce one to get correct.
.code
main proc far
mov ax, @data
mov ds, ax
lea si, characters
mov cx, len
dec cx
lea bx, xlat_table

print:
lodsb
xlat
mov ah, 02h
mov dl, al
add dl, 30h
int 21h
loop print

mov ax, 4c00h
int 21h
main endp
end main
