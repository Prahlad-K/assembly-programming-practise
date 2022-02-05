.model small
.stack 64
.386
.data
row equ 10
pathname db 'C:\*.*', 00h 
diskarea db 43 dup(20h)
.code
main proc far
mov ax, @data
mov ds, ax
mov es, ax

mov ax, 0003h
int 10h

; setting DTA
mov ah, 1Ah
lea dx, diskarea
int 21h

mov ah, 4Eh
mov cx, 0
lea dx, pathname
int 21h
; searching

cmp ax, 00h
jne done

lea di, diskarea+30
mov cx, 13
repne scasb

neg cx
add cx, 13

lea bp, diskarea+30
call print

done:
mov ax, 4c00h
int 21h
main endp

print proc near
pusha

mov ah, 13h
mov al, 01h
mov bx, 0016h
mov cx, row
mov dx, 00h
int 10h


popa
print endp
end main
