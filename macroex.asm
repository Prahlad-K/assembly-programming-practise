.model small
.stack 64

print macro message
     mov ah, 09h
     lea dx, message
     int 21h
     endm
.data
message1 db 'Hello world.$'
message2 db 0Ah, 0Dh, 'Sairam gadu thopu, dammunte aapu','$'
.code
main proc far
mov ax, @data
mov ds, ax

print message1
print message2

mov ax, 4c00h
int 21h
main endp
end main

