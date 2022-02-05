title a23resid (COM) Resident program: Beep if use Esc key

codeseg segment para
assume CS:codeseg
org 100h
begin: jmp B10init 
saveint9 DD ?
duration dw 100h
A10test:
push ax
push cx

in al, 60h
cmp al, 01h
jne A50exit
in al, 61h ; saving the state of port.
push ax

or al, 00000011b ; turns speaker on.
out 61h, al
mov cx, 512h
A20: loop A20

or al, 00000010b
mov cx, 512h

A30: loop A30
pop ax ; port status
and al, 11111100b ; turns speaker off
out 61h, al

A50exit:
pop cx
pop ax ; restore registers 
jmp cs:saveint9 ; resume int 09h


B10init:
cli ; prevents interrupts
mov ah, 35h
mov al, 09h
int 21h
 ; gets the address of 09h in es:bx

mov word ptr saveint9, BX ; and save it
mov word ptr saveint9+2, ES ; and save it

mov ah, 25h
mov al, 09h
mov dx, offset a10test
int 21h ; set new address for 09h in A10test

mov ah, 31h
mov dx, offset B10init
sti ; restore interrupts

int 21h
codeseg ends

end begin


