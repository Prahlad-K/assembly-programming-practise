.model small
.stack 64
.386
.data
stri db 'string$'
n db 3
res db ?
char db 'i'
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax
comment @
call strcpy

lea dx, res
mov ah, 09h
int 21h

call strncpy

lea dx, res
mov ah, 09h
int 21h
@
;call revcpy

call strcmp
add dl, 30h
mov ah, 02h
int 21h

mov ax, 4c00h
int 21h

main endp

strcpy proc near
lea si, stri
lea di, res
mov cl, 7

rep movsb
ret
strcpy endp

strncpy proc near
lea si, stri
lea di, res

mov cl, n

rep movsb
mov dl, '$'
mov [di], dl
ret
strncpy endp

revcpy proc near
lea si, stri
mov cl, 7

silast:
inc si
loop silast

mov cl, 7
lea di, res
dilast:
inc di
loop dilast

mov dl, '$'
mov [di], dl

mov cl, 7
std
rep movsb
ret
revcpy endp

strcmp proc near
lea di, stri
mov bl, [si]
mov al, char
mov cl, 7
mov dl, 7

repne scasb
je found
ret

found: inc cl
sub dl, cl
ret 
strcmp endp

end main