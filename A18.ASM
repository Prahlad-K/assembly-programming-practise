.model huge
.stack 128
.data
str1 db 'aba$'
str2 db 'aab$'
str3 db 'aac$'
mx db 'zzz$'
temp1 dw ?
j db 0
temp2 dw ?
ptrm db ?
i db 0

.code
main proc far
mov ax, @data
mov ds, ax

lea si, ptrm

lea di, str1
mov ax, di
mov [si], ax
inc si
inc si

lea di, str2
mov ax, di
mov [si], ax
inc si
inc si

lea di, str3
mov ax, di
mov [si], ax
inc si
inc si
; successfully initialised the ptrm array

comment @
lea si, ptrm
mov dx, [si]
mov ah, 09h
int 21h
;Okay. Prints 'aaa', Nice!
@

; write a procedure which compares two strings having addresses in si and di. Returns 1 in dl if si>di, 2 ;if di>si and 0 if si=di
mov dl, 0
mov j, 0
printmins:
lea bx, ptrm
mov al, ptrm[0]
mov ah, ptrm[1]
; so now ax contains assumed minimum.

cont:
mov si, ax
mov di, [bx]
mov temp1, ax
mov temp2, bx
call compare
mov ax, temp1
mov bx, temp2
cmp dl, 1
jne dontswap
mov ax, [bx] ; swapping is done if si<di which means [bx]<ax, thus minimum is replaced. 
dontswap: add bx, 2
inc i
cmp i, 3
jl cont

mov dx, ax
mov ah, 09h
int 21h
mov ax, dx
; obtained minimum here!

lea si, ptrm
lea di, mx
mov cl, 3

markit:
mov bx, [si]
cmp ax, bx
jne dontmark
mov [si], di
dontmark: add si, 2
loop markit

mov dl, ' '
mov ah, 02h
int 21h

call reset

inc j
mov i, 0
cmp j, 3
jl printmins

mov ax, 4c00h
int 21h
main endp

compare proc near

mov cl, 3
XXX: 
mov al, [si]
mov bl, [di]
cmp al, bl
jg agb
cmp al, bl
jl alb
inc si
inc di
loop XXX
mov dl, 0
jmp finish

agb: mov dl, 1
jmp finish

alb : mov dl, 2

finish: ret
compare endp

reset proc near
sub ax, ax
sub bx, bx
sub cx, cx
sub dx, dx
sub si, si
sub di, di
ret
reset endp

end main
