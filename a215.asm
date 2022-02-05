title a23resid (COM) Resident program: Change characters

codeseg segment para
assume CS:codeseg
org 100h
begin: jmp B10init 
saveint9 DD ?
duration dw 100h
A10test:
push ax
    push cx
    in al,60h
    cmp al,02h
    jne exit1
        in al,61h
        push ax
        mov al,'a'
        mov ah,0eh
        int 10h
        mov cx,512h
        jmp exit2
    exit1:
    cmp al,03h
    jne exit3
        in al,61h
        push ax
        mov al,'b'
        mov ah,0eh
        int 10h
        exit2:
        mov cx,512h
        jmp exit4
    exit3:
    cmp al,04h
    jne exit
        in al,61h
        push ax
        mov al,'c'
        mov ah,0eh
        int 10h
        exit4:
        mov cx,512h    
a20:
    loop a20
    or al,00000010b
    mov cx,512h
 a30:
    loop a30
    pop ax
    and al,11111100b
    out 61h,al
 exit:
    pop cx
    pop ax
    jmp cs:saveint9

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


