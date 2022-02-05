page 60, 132
stack segment para stack 'stack'
db 64 dup(0)
stack ends
dataseg segment para 'data'
one db 101b
two db 101b
dataseg ends
codeseg segment para 'code'
main proc far
assume CS:codeseg, SS:stack, DS: dataseg
mov ax, dataseg
mov ds, ax ;initialization of data segment

mov al, one
mov ah, 0
mul two
mov dl, al
add dl, 30h
mov ah, 02
int 21h ;multiplication and printing

mov ax, 4c00h
int 21h
main endp
codeseg ends
end main



