.model small
.stack 64
.data
num db 213
str db ? 
temp db ?
ans db ?
.code  ; conversion of integer to string
main proc far
mov ax, @data
mov ds, ax    ; initialization of data segment.

lea di, str  ; loading addresses into pointer registers.
mov cx, di   ; storing base address for future. 

mov al, num
mov bl, 10
XXX: mov ah, 0
div bl
add ah, 30h
mov [di], ah
inc di
cmp al, 0
jg XXX       ; finding str.

dec di
lea si, ans
ZZZ:mov al, [di]
mov [si], al
dec di
inc si
cmp di, cx
jge ZZZ      ; reversing str to get answer.
                                          
mov bl, '$'
mov [si], bl
lea dx, ans
mov ah, 09
int 21h      ; printing answer in string.

;YYY:  dec di
;mov dl, [di]
;add dl, 30h
;mov ah, 02
;int 21h
;cmp di, si 
;jg YYY

mov ax, 4c00h
int 21h

main endp
end main

