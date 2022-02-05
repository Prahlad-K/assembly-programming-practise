
.model small
.stack 64
.386
.data
n db 0
array1 db 100 dup(0)
array2 db 100 dup(0)
node db 100 dup(0)
free db 1
current db 0
curleft db 0
curright db 0
curadd dw 0
i db 0
nhalf db 0
.code
main proc far
mov ax, @data
mov ds, ax

mov ah, 10h
int 16h

sub al, 30h
mov n, al

lea si, array1
lea di, array2
mov ch, 0
mov cl, n
shr cl, 1
mov nhalf, cl
input1:
mov ah, 10h
int 16h

sub al, 30h
mov [si], al
inc si
loop input1

mov ch, 0
mov cl, n
shr cl, 1
input2:
mov ah, 10h
int 16h

sub al, 30h
mov [di], al
inc di
loop input2

lea si, array1
lea di, array2

mov ch, 0
mov cl, nhalf

gotolast:
inc si
loop gotolast

mov ch, 0
mov cl, nhalf

fillarray1:
mov al, [di]
mov [si], al
inc si
inc di
loop fillarray1

lea si, array1
mov ch, 0
mov cl, n

lea si, array1
mov al, [si]
mov node[1], al ; the root is set!

inc si

continue:
mov i, 0

makebt:
call getcurrent
mov dl, current
mov bx, curadd
mov al, [si]

cmp al, dl
jl goleft
mov ch, curright
cmp ch, 0
je putinright
mov i, ch
call makebt

putinright:
inc bx
mov dl, free
mov [bx], dl
jmp complete

goleft:
mov ch, curleft
cmp ch, 0
je putinleft
mov i, ch
call makebt

putinleft:
dec bx
mov dl, free
mov [bx], dl
jmp complete

complete:
mov i, dl
inc free
call getcurrent
mov bx, curadd
mov al, [si]
mov [bx], al
inc si

mov al, n
cmp free, al
jl continue

; printing the node array
lea si, node
mov cx, 18
output1:
mov al, [si]
add al, 30h
mov dl, al
mov ah, 02h
int 21h

mov dl, ' '
mov ah, 02h
int 21h
inc si
loop output1

mov ax, 4c00h
int 21h
main endp

getcurrent proc near
pusha
lea bx, node
inc bx
cmp i, 0
je selectcurrent

mov ch, 0
mov cl, i

gotocurrent:
add bx, 3
loop gotocurrent

selectcurrent:
mov dl, [bx]
mov current, dl
mov curadd, bx
inc bx
mov dl, [bx]
mov curright, dl
dec bx
dec bx
mov dl, [bx]
mov curleft, dl
popa
ret
getcurrent endp

end main
