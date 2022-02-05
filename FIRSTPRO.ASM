stack segment para stack 'stack'
db 64 dup(0)
stack ends
dataseg segment para 'data'
one db 1
two db 2
dataseg ends
codeseg segment para 'code'
main proc far
assume SS:stack,CS:codeseg,DS:dataseg
mov AX, dataseg
mov DS, AX
mov AL, one
add AL, two
add AL, 30h
mov AH, 02
mov DL, AL
int 21h
mov AX,4c00h
int 21h
main endp
codeseg ends
end main
