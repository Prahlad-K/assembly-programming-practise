.model small
.stack 64
.386
.data
string db 'Prahlad'
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

call setgra
call reqpal
call scroll
call printstring
call display

mov ax, 4c00h
int 21h
main endp

setgra proc near
mov ah, 00h
mov al, 12h
int 10h
ret
setgra endp

reqpal proc near
mov ah, 0bh
mov bh, 0 ; background
mov bl, 07h ; gray
int 10h
ret
reqpal endp

scroll proc near ; for scrolling/clearing the screen, we never need the page number!
pusha
mov ah, 06
mov al, 05
mov bh, 0Eh 
mov cx, 0000h
mov dx, 044Fh
int 10h; sets the attribute of white background and blue foreground.
popa
ret
scroll endp

printstring proc near
pusha
mov ah, 13h
mov al, 01h
mov bh, 00h
mov bl, 21h
lea bp, string
mov cx, 7
mov dx, 0815h
int 10h
popa
ret
printstring endp

display proc near
pusha
mov ax, 0A01h
mov bh, 0
mov bl, 0100b
mov cx, 10
int 10h
popa
ret
display endp

end main



