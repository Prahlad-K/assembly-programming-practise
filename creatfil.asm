.model small
.stack 64
.386
.data
namepar label byte
maxlen db 30
actlen db ?
namerec db 30 dup(' '), 0Dh, 0Ah
filehandle dw ?
pathname db 'c:\firstfile.dat', 0
prompt db 'Give me the name.'
row db 0
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

mov ax, 0003h
int 10h ; setting video mode

call createfile
call promptinput
call closefile

mov ax, 4c00h
int 21h
main endp

createfile proc near
pusha
mov ah, 03Ch
mov cx, 00
lea dx, pathname
int 21h

mov filehandle, ax
popa
ret
createfile endp

promptinput proc near
pusha
mov cx, 17
lea bp, prompt
call display

mov ah, 0Ah
lea dx, namepar
int 21h

mov al, 20h ; blank space.
movzx cx, actlen
lea di, namerec
add di, cx
neg cx
movzx dx, maxlen
add cx, dx
rep stosb
call writefile
popa
ret
promptinput endp

writefile proc near
pusha
mov ah, 40h
mov bx, filehandle
movzx cx, maxlen
add cx, 2
lea dx, namerec
int 21h
popa
ret
writefile endp

closefile proc near
pusha
mov ah, 3Eh
mov bx, filehandle
int 21h
popa
ret
closefile endp

display proc near
pusha
mov ah, 13h
mov al, 01h
mov bx, 0016h
mov dh, row
mov dl, 00
inc row
popa
ret
display endp

end main
