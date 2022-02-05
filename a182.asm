.model small
.stack 64
.386
.data
one db 'aaaa$'
two db 'abba$'
three db 'acca$'
i db 0
j db 0
temp dw 0
flag db 0
len db 4
num db 3
array db 10 dup(0)
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

lea si, array

lea di, one
mov [si], di
inc si
inc si

lea di, two
mov [si], di
inc si
inc si

lea di, three
mov [si], di

lea si, array
loop2:
lea di, array
loop1:
call cmpstrs ; should compare two strings in si and di and return the greater value in flag.
cmp flag, 2
jne continue
mov ax, [si]
mov bx, [di]
mov [si], bx
mov [di], ax
continue: inc di
inc di
inc j 
mov cl, len
cmp j, cl
jl loop1
mov j, 0
inc si
inc si
inc i
mov cl, num
cmp i, cl
jl loop2

lea si, array
mov ch, 0
mov cl, num
printing:
mov dx, [si]
mov ah, 09h
int 21h
inc si
inc si
call printspace
loop printing

mov ax, 4c00h
int 21h

main endp

cmpstrs proc near
pusha
mov ax, [si]
mov dx, [di]

mov si, ax
mov di, dx

mov ch, 0
mov cl, len

repe cmpsb
jg silarge
cmp cx, 0
je same
jmp dilarge

silarge: 
mov flag, 1
jmp done

same:
mov flag, 0
jmp done

dilarge:
mov flag, 2
jmp done

done:     
popa
ret
cmpstrs endp

printspace proc near
pusha
mov dl, ' '
mov ah, 02
int 21h
popa
ret
printspace endp

end main

