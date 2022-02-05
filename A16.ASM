.model small
.stack 64
.386
.data
one db 24h, 33h, 22h
two db 50h, 40h
len1 db 3
len2 db 2
sum db 'Add:$'
diff db 'Sub:$'
multi db 'Mul:$'
divi db 'Div:$'
prevbyt db 0
i db 0
store db 0
rem db 0
res db 6 dup(0)
quo db 3 dup(0)
flag db 0
temp db ?
.code
main proc far
mov ax, @data
mov ds, ax

call fillsmaller  ;fills the remaining bits of the smaller array with zeros.

mov ah, 09
 lea dx, sum
int 21h

mov cx, 3
lea si, one
lea di, two
lea bx, res
addition:
mov al, [si]
adc al, [di]
mov [bx], al
inc si
inc di
inc bx
loop addition
dec bx

mov cx, 3
inorderadd:
mov al, [bx]
mov ah, 0
call printbyte
dec bx
loop inorderadd

mov ah, 09
lea dx, diff
int 21h

mov cx, 3
lea si, one
lea di, two
lea bx, res
subtraction:
mov al, [si]
sbb al, [di]
mov [bx], al
inc si
inc di
inc bx
loop subtraction
dec bx

mov cx, 3
inordersub:
mov al, [bx]
mov ah, 0
call printbyte
inc si
dec bx
loop inordersub

mov ah, 09
lea dx, multi
int 21h

mov cx, 6
lea bx, res
makereszero:
mov al, 0
mov [bx], al
inc bx
loop makereszero 

mov cx, 3
lea si, one
lea di, two
lea bx, res

keepmulti:
mov cx, 3
lea si, one
mov prevbyt, 0

multiplication:
mov al, [si]
mov dl, [di]
mul dl
clc
adc al, prevbyt
mov prevbyt, ah
adc [bx], al
inc bx
inc si
loop multiplication

mov al, prevbyt
mov [bx], al

inc di
inc i
mov ch, 0
mov cl, i
lea bx, res

shiftplease:
inc bx
loop shiftplease

cmp i, 2
jl keepmulti

mov cx, 6
lea bx, res
travtoend:
inc bx
loop travtoend
dec bx

mov cx, 6
inordermul:
mov al, [bx]
mov ah, 0
call printbyte
dec bx
loop inordermul

lea dx, divi
mov ah, 09h
int 21h

comment @
lea si, one
lea di, one
mov cx, 3
traverseone:
inc si
loop traverseone
dec si

reverseone:
mov bl, [di]
mov al, [si]
mov [di], al
mov [si], bl

lea si, one
lea di, two

mov bl, [di]
lea di, quo
mov cx, 3

division:
mov ah, rem
mov al, [si]
div bl
mov rem, ah
mov [di], al
inc si
inc di
loop division

lea di, quo
mov cx, 3

inorderdiv:
mov al, [di]
mov ah, 0
call printbyte
inc di
loop inorderdiv
; okay so this clearly works only for a single divisor. Let's make this stronger.
@
keepdoing:
mov cx, 3
lea si, one
lea di, two
clc
repeatedsub:
mov al, [si]
sbb al, [di]
mov [si], al
inc si
inc di
loop repeatedsub
call incquotient
call checkend
cmp flag, 1
jne keepdoing
; repeated subtraction!

dec si
mov cx, 3
printrem:
mov al, [si]
mov ah, 0
call printbyte
dec si
loop printrem

lea si, quo
mov cx, 3

printquo:
mov al, [si]
mov ah, 0
call printbyte
inc si
loop printquo 

mov ax, 4c00h
int 21h

main endp

fillsmaller proc near
pusha
mov al, len1
mov bl, len2

lea si, one
lea di, two

cmp al, bl
je finish
cmp al, bl
jl filla

mov cl, len2
inctolastb:
inc di
loop inctolastb

mov cl, len1
sub cl, len2
addzerosb:
mov al, 0
mov [di], al
inc di
loop addzerosb
jmp finish
; seems to work in theory
filla: 
mov cl, len1
inctolasta:
inc si
loop inctolasta

mov cl, len2
sub cl, len1
addzerosa:
mov al, 0
mov [si], al
inc si
loop addzerosa
jmp finish

finish: 
popa
ret
fillsmaller endp

printbyte proc near
pusha
lea si, temp
mov bl, 16
mov bh, '$'
mov cx, 0
; always remember, during printing the character is echoed to al! 
XXX:
div bl
mov dl, ah
cmp ah, 10
jge alpha

add dl, 30h
jmp notalpha

alpha: add dl, 55
notalpha:
mov [si], dl
inc si
inc cl
mov ah, 0
cmp al, 0
jg XXX
dec si

YYY:
mov dl, [si]
mov ah, 02
int 21h
dec si
loop YYY

mov ah, 02
mov dl, ' '
int 21h

popa
ret
printbyte endp

checkend proc near
pusha
lea si, one
lea di, two

mov ah, 0
mov bh, 0
mov cx, 3
travone:
inc si
loop travone
dec si

mov cx, 3
travtwo:
inc di
loop travtwo
dec di

mov cx, 3
checkthis:
mov al, [si]
mov bl, [di]
cmp ax, bx
je cont
cmp ax, bx
jg endthis
mov flag, 1
jmp endthis

cont:
dec si
dec di
loop checkthis

endthis:
popa
ret
checkend endp

incquotient proc near
pusha
mov cx, 3
lea si, quo

addtoquo:
mov al, [si]
cmp cx, 3
clc
jne proceed
adc al, 1
mov [si], al
inc si
loop addtoquo
proceed: 
adc al, 0
mov [si], al
inc si
loop addtoquo

popa
ret
incquotient endp

end main
