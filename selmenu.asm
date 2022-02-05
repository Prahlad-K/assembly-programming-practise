.model small
.stack 64
.386
.data
toprow equ 08
botrow equ 15
lefcol equ 26
attrib db ?
row db 00
shadow db 19 dup(0DBh)
menu db 0C9h, 17 dup(0CDh), 0BBh
     db 0BAh, 'Add records ', 0BAh
     db 0BAh, 'Delete records ', 0BAh
     db 0BAh, 'Enter orders ', 0BAh
     db 0BAh, 'Print report ', 0BAh
     db 0BAh, 'Update accounts ', 0BAh
     db 0BAh, 'View records', 0BAh
     db 0C8h, 17 dup(0CDh), 0BCh
prompt db 'To select an item, use <Up/down Arrow>'
       db ' and press <Enter>.'
       db 13, 10, 'Press <Esc> to exit.'

.code
A10main proc far
mov ax, @data
mov ds, ax
mov es, ax

call Q10clear
mov row, botrow+4
A20:
call B10menu
mov row, toprow+1
mov attrib, 16h
call D10display
call C10input
cmp al, 1Bh
jne A20
mov ax, 0600h
call Q10clear
mov ax, 4c00h
int 21h
A10main endp

B10menu proc near
pusha
mov ax, 1301h
mov bx, 0060h
lea bp, shadow
mov cx, 19
mov dh, toprow+1
mov dl, lefcol+1
B20:
int 10h
inc dh
cmp dh, botrow+2
jne B20
mov attrib, 71h
mov ax, 1300h
movzx  bx, attrib
lea bp, menu
mov cx, 19
mov dh, toprow
mov dl, lefcol
B30:
int 10h
add bp, 19
inc dh
cmp dh, botrow+1
jne B30

mov ax, 1301h
movzx bx, attrib
lea bp, prompt
mov cx, 79
mov dh, botrow+4
mov dl, 00
int 10h
popa
ret
B10menu endp

C10input proc near
pusha
C20:
mov ah, 10h
int 16h
cmp ah, 50h
je C30
cmp ah, 48h
je C40
cmp ah, 0Dh
je C90
cmp ah, 1Bh
je C90
jmp C20

C30:
mov attrib, 71h
call D10display
inc row
cmp row, botrow-1
jbe C50
mov row, toprow+1
jmp C50

C40:
mov attrib, 71h
call D10display
dec row
cmp row, toprow+1
jae C50
mov row, botrow-1

C50:
mov attrib, 17h
call D10display
jmp C20

C90:
popa
ret
C10input endp

D10display proc near
pusha
movzx ax, row
sub ax, toprow
imul ax, 19
lea si, menu+1
add si, ax

mov ax, 1300h
movzx bx, attrib
mov bp, si
mov cx, 17
mov dh, row
mov dl, lefcol+1
int 10h
popa
ret
D10display endp

Q10clear proc near
pusha
mov ax, 0600h
mov bh, 61h
mov cx, 0000
mov dx, 184Fh
int 10h
popa
ret
Q10clear endp
end A10main







     


