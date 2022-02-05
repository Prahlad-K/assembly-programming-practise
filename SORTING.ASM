.model small
.stack 64
.data
array db 1, 5, 2, 3, 4
array2 db 5 dup(0)
temp db ?
.code
main proc far
mov ax, @data
mov ds, ax

lea si, array
lea di, array2
mov cl, 5
mov ch, 5
cmp 
jl XXX
mov [si+1], 

