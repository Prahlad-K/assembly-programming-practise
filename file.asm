.model small
.stack 64
.data
pathnam1 db 'c:\accounts.dat', 00h
filehand1 dw ?
dskarea db 256 dup('*')
.code
main proc far
mov ax, @data
mov ds, ax

mov ah, 3ch
mov cx, 00
lea dx, pathnam1
int 21h
jc error
mov filehand1, ax
jmp opened
error:
mov ah, 02h
mov dl, 'o'
int 21h
jmp finish

opened:
mov ah, 40h
mov bx, filehand1
mov cx, 256
lea dx, dskarea
int 21h
jc error1
cmp ax, 256
jne error2
jmp written
error1:
mov ah, 02h
mov dl, 'a'
int 21h
jmp finish

error2:
mov ah, 02h
mov dl, 'b'
int 21h
jmp finish

written:
mov ah, 3Eh
mov bx, filehand1
int 21h

finish:
mov ax, 4c00h
int 21h

main endp
end main