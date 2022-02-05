.model small
.stack 64
.data
str db 'Hello$'
i db ?
j db ?
.code
main proc far
mov ax, @data
mov ds, ax

;mov cl, 0
;lea si, str
;mov bl, '$'
;XXX: inc si
;inc cl
;cmp [si], bl
;jne XXX

mov cl, SIZE str

;mov i, cl
;mov j, cl

;lea si, str
;lea di, str

mov dl, cl
add dl, 30h
mov ah, 02
int 21h


;WWW: mov al, [si]
;ZZZ: mov bl, [di]
;cmp al, bl
;jne YYY
;cmp si, di
;je YYY
;mov dl, [si]
;mov ah, 02
;int 21h
;YYY: inc di
;dec j
;jnz ZZZ
;lea di, str
;inc si
;dec i
;jnz WWW
;
mov ax, 4c00h
int 21h
main endp
end main
