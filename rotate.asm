title car
page 
.model small
.stack 64
.data
x db 200
y  db 70
x1 db 200
y1 db  180
g db ?
e dw ?
ext db ?
ext1 db ?
centx dw ?
centy dw ?  
row1 db ?
col1 db ?
row dw ?
col dw ?
dist db ?
rad db ?
flg db 00
flg1 db ?
flg2 db ?
tr db ?
val db ?
xcv db ?
flg3 db ?

.code
main proc far
mov ax,@data
mov ds,ax
mov rad,30
mov row1,0
mov ext,0
mov al,rad
mov col1,al
mov ext1,al
mov g,al
mov dist,al
mov al,g
add al,y
mov g,al

call setgraphics
call setbackground
call setpalette

mov flg,14
mov flg1,00
mov flg2,00

jkl:
call clrscreen
mov ah,00
mov bh,00
mov al,x
mov ah,00
mov centx,ax
mov bh,00
mov bl,y
mov centy,bx
mov bl,ext
mov row1,bl
mov al,rad
mov dist,al
mov al,ext1
mov col1,al
; -------------calling procedure to draw first circle
call circle
add y,05
mov al,flg1
mov flg3,al
mov tr,20
;-------------calling line prcedure
call line
inc flg1

call drawline
;-----------------calling second line
call initialize
mov al,flg2
mov flg3,al
mov tr,20
call line
inc flg2

mov tr,90
call drawtop
call slant
mov ah,10h
int 16h
dec flg
jnz jkl

mov ah,4ch
int 21h
main endp
;-------------------------to draw top part of car
drawtop proc near
mov centx,100
mov bl,y
mov bh,00
mov centy,bx
mov flg3,02
call line
ret
drawtop endp
;---------------------- to draw slanting lines
slant proc near
mov e,00
mov flg3,05
call drawslant
add centx,35
mov tr,23
mov flg3,02
call line
mov e,90
mov flg3,03
call drawslant
add centx,35
mov tr,13
mov flg3,06
call line
ret
slant endp
;-------------------to draw slope
drawslant proc near
mov tr,60
mov centx,100
mov bl,y
mov bh,00
mov centy,bx
mov ax,e
add centy,ax
call line
mov ax,row
mov centx,ax
mov bx,col
mov centy,bx
mov tr,35
mov flg3,04
call line
ret
drawslant endp
;---------------------- to draw line between two circles
drawline proc near
mov tr,42
add g,05
mov centx,200
mov al,g
mov ah,00
mov centy,ax
mov flg3,02
call line
ret
drawline endp
;-------------to initialize second circle
initialize proc near
mov ah,00
mov al,x1
mov centx,ax
mov ah,00
mov al,y1
mov centy,ax
mov bl,ext
mov row1,bl
mov al,rad
mov dist,al
mov al,ext1
mov col1,al
call circle
add y1,05
ret
initialize endp
;-------------to setgraphics
setgraphics proc near
mov ah,00
mov al,12h
int 10h
ret
setgraphics endp
;-----------to setbackgrounds
setbackground proc near
mov ah,0bh
mov bh,00
mov bl,00h
int 10h
ret
setbackground endp
;----------------to setpalette
setpalette proc near
mov ah,0bh
mov al,01
mov bh,01
int 10h
ret
setpalette endp

;------------------to draw circle
circle proc near
c00:
call drawcircle
mov al,dist
mov bl,row1
sub al,bl
inc row1
sub al,row1
jg c01
mov al,dist
add al,col1
mov dist,al
dec col1
mov al,dist
add al,col1
mov dist,al
jmp c02
c01:
mov dist,al
c02:
mov al,row1
mov bl,col1
cmp bl,al
jae c00
ret
circle endp
;-----------to point in 8 octants
drawcircle proc near
mov ax,centx
call cali
add ax,bx
mov row,ax
mov ax,centy
call callin
add ax,bx
mov col,ax
call printpixel

mov ax,centx
call cali
sub ax,bx
mov row,ax
mov ax,centy
call callin
sub ax,bx
mov col,ax
call printpixel

mov ax,centx
call cali
sub ax,bx
mov row,ax
mov ax,centy
call callin
add ax,bx
mov col,ax
call printpixel

mov ax,centx
call cali
add ax,bx
mov row,ax
mov ax,centy
call callin
sub ax,bx
mov col,ax
call printpixel

mov ax,centx
call callin
add ax,bx
mov row,ax
mov ax,centy
call cali
add ax,bx
mov col,ax
call printpixel

mov ax,centx
call callin
sub ax,bx
mov row,ax
mov ax,centy
call cali
add ax,bx
mov col,ax
call printpixel

mov ax,centx
call callin
add ax,bx
mov row,ax
mov ax,centy
call cali
sub ax,bx
mov col,ax
call printpixel

mov ax,centx
call callin
sub ax,bx
mov row,ax
mov ax,centy
call cali
sub ax,bx
mov col,ax
call printpixel
ret
drawcircle endp
;------------------procedure to draw line
line proc near
mov ax,centx
mov row,ax
mov ax,centy
mov col,ax
qwe:
call printpixel
call rotate
dec tr
jnz qwe
ret
line endp
;------------------to indicate the inclination line in circle
rotate proc near
mov al,flg3
mov ah,00
mov bl,08
div bl
mov val,ah
mov al,val
cmp al,00
jnz ba
dec row
jmp hgf
ba:
cmp al,01
jnz ab
inc col
dec row
jmp hgf
ab:
cmp al,02
jnz ace
inc col
jmp hgf
ace:
cmp al,03
jnz ac
inc row
inc col
jmp hgf
ac:
cmp al,04
jnz ad
inc row
jmp hgf
ad:
cmp al,05
jnz ae
inc row
dec col
jmp hgf
ae:
cmp al,06
jnz af
dec col
jmp hgf
af:
cmp al,07
jnz hgf
dec row
dec col
hgf:
ret
rotate endp
;-----------------------to print pixel
printpixel proc near
mov ah,0ch
mov al,05h
mov bh,00
mov cx,col
mov dx,row
int 10h
ret
printpixel endp

clrscreen proc near
mov ah,06h
mov al,00
mov bh,10h
mov cx,0000
mov dx,184fh
int 10h
ret
clrscreen endp

cali proc near
mov bl,row1
mov bh,00
ret
cali endp

callin proc near
mov bl,col1
mov bh,00
ret
callin endp

end main