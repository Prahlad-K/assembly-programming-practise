.model small
.stack 64
.386
.data
string db '1234567890'
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

call setgra
call reqpal
mov ah, 10h
int 16h
call scroll
mov ah, 10h
int 16h
call printstr

mov ax, 4c00h
int 21h

main endp

setgra proc near
pusha
mov ah, 00
mov al, 12h
int 10h
popa
ret
setgra endp

reqpal proc near
pusha
mov ah, 0Bh
mov bh, 00
mov bl, 08h
int 10h
popa
ret
reqpal endp

scroll proc near
pusha
mov ah, 07h
mov al, 05h
mov bh, 1110b
mov cx, 0000h
mov dx, 044Fh
int 10h
popa
ret
scroll endp

printstr proc near
pusha
mov ax, 1301h
mov bx, 0021h
lea bp, string
mov cx, 10
mov dx, 0815h
int 10h
popa
ret
printstr endp

end main