.model small
.stack 64
initz macro
mov ax, @data
mov ds, ax
mov es, ax
endm

finish macro
mov ax, 4c00h
int 21h
endm

setmode macro mode
mov ah, 00
mov al, mode
int 10h
endm 

setcursor macro row, col, pageno
mov ah, 02h
mov bh, pageno
mov dh, row
mov dl, col
int 10h
endm

clearscr macro point1, point2, attribute
mov ax, 0600h
mov bh, attribute
mov cx, point1
mov dx, point2
int 10h
endm

printchar macro char, pageno, count, attribute
mov ah, 09h
mov al, char
mov bh, pageno
mov bl, attribute
mov cx, count
int 10h
endm

.data
.code
main proc far
initz

setmode 12h
setcursor 10, 10, 0
clearscr 0h, 184Fh, 74h
printchar '*', 0, 10, 4Fh 

finish
main endp
end main