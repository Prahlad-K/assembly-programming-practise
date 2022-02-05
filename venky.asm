title shrinkmonitor 
page

.model small

.stack 64

.data
 cnt db ?
 row db ?
 col db ?
 val db ?
 char db ?
 value dw ?
 tr db ?
 fr db ?
 fd db ?
 count1 db ?
 counter db ?
 col1 dw ?
 temp1 db 80 dup(0)
 temp2 db 80 dup(0)

 filehandle dw ?
 
 word2 db 'Do you want to create or open file$'
 word1 db 'Do you want to save your file $'
 
 file1z db 'C:\f3.txt',00
 file2z db 'C:\f3.txt',00

.code
main proc far
mov ax,@data
mov ds,ax

mov col1,00
mov tr,00
mov counter,00

lea dx,word2
mov ah,09h
int 21h

mov ah,01h
int 21h
cmp al,'c'
jnz dast     

mov ah,3ch
lea  dx,file1z
mov cx,00                 ;creates a new file
int 21h
mov filehandle,ax         
jmp ven

dast:

mov ah,3dh
mov al,2
lea  dx,file1z           ;opens already existing file
int 21h
mov filehandle,ax        ;;;;;        
call editing
mov row,01
mov col,02
call setcursor
jmp kri

ven:
call clrscreen
mov row,01
call setnow
kri:
;----------------content with in box
mov value,1080
sad:
mov tr,00
mov ah,10h
int 16h
call checkvalue ;compares key pressed

uuu:
dec col
  ; steps checked when left key is pressed 
call prevrow    ;
call check      ;
call setcursor  ;
cmp tr,01       ;
jnz hdd         ;
mov tr,00       ;
inc col         ;
call setcursor  ;
jmp hdd         ;

iii:
call printvalue  ;prints char
inc col          ; and inc col
call setcursor   ;
jmp hdd

kkk:             ;checks when 
add col,1        ;space is pressed
call setcursor   ;
jmp hdd          ;

sss:            ; checks when enter is pressed
inc row         ;
call setnow     ; 
call verifyrow  ;verifies whether row is within box or not
cmp tr,00       ;
jnz fff
hdd:

call verifyrow  ;
cmp tr,00       ;
jnz fff         ;
call check      ;checks whether col is in box or not
cmp tr,00       ;
jnz fff         ;
dec value       ;
jnz sad         ;

fff:

call printsave
main endp

;-----------checks which key is pressed
checkvalue proc near
cmp ah,01h ;if esc is pressed
jz fff
cmp ah,1ch ;if enter is pressed
jz sss  
cmp ah,39h ; if space is pressed
jz kkk 
cmp ah,4bh ;if left arrow is pressed
jz uuu 
cmp ah,0eh ;if backspace is pressed
jz vvv
cmp ah,4dh ;if right arrow is pressed
jz www
jmp iii
vvv:
call backspace
call setcursor
jmp hdd
www:
inc col
cmp col,76
jb ihh
dec col
ihh:
call setcursor
jmp hdd
ret
checkvalue endp

;--------------to clear screen
clrscreen proc near
mov ah,06h
mov al,00
mov bh,70h
mov cx,0000h
mov dx,184fh
int 10h
ret
clrscreen endp

;--------------to set cursor
setcursor proc near
mov ah,02h
mov bh,00
mov dh,row
mov dl,col
int 10h
ret
setcursor endp

;----------------to print char given no of times
printchar proc near
mov ah,09h
mov al,char
mov bh,00
mov bl,70h
mov cl,cnt
int 10h
ret
printchar endp

;--------------to set cursor to new line

setnow proc near
mov col,02
call setcursor
ret
setnow endp

;----verifies whether cursor is with in box
verifyrow proc near
cmp row,24
jb sds
mov tr,01
sds:
ret
verifyrow endp


check proc near
cmp col,01  ;compares whether cursor is out of box or not
jbe kll
cmp col,76  ;compares whether cursor is out of box or not
jb lll
mov col,02
inc row
cmp row,24
jb llk
kll:
mov tr,01
jmp lll
llk:
call setcursor
lll:
ret
check endp

printsave proc near
mov row,23
mov col,00
call setcursor
lea dx,word1
mov ah,09h
int 21h

mov ah,01h
int 21h
cmp al,'s'
jnz fdfd
call read_data_into_file

mov ah,3eh
mov bx,filehandle
int 21h

fdfd:
mov ah,4ch
int 21h
ret
printsave endp

;-------to check whether present row is first row or not
prevrow proc near
cmp col,01
jne qq
cmp row,01
jbe qq
dec row
mov col,75
call setcursor
qq:
ret
prevrow endp

printvalue proc near
mov dl,al        ;prints char
mov ah,02h       ;
int 21h   
ret
printvalue endp

backspace proc near
mov al,col
mov fr,59
sub fr,al
mov al,fr
mov fd,al
fdd:
call setcursor
mov ah,08
mov bh,00
int 10h
push ax
inc col
dec fr
jnz fdd

dec col
fdda:
dec col
call setcursor
pop ax
mov ah,00
call printvalue
dec fd
jnz fdda

ret
backspace endp

read_data_into_file proc near
mov row,00
mov col,02
mov col1,00
mov count1,22
krish:

mov counter,74
lea si,temp1
mov col,02
inc row
lak:
call setcursor
inc col
mov ah,08h
mov bh,00
int 10h
mov [si],al

inc si
dec counter
jnz lak

mov ah,42h
mov al,00
mov bx,filehandle
mov cx,00
mov dx,col1
int 21h

mov ah,40h
mov bx,filehandle
mov cx,74
lea dx,temp1
int 21h
add col1,75
dec count1
jnz krish
ret
read_data_into_file endp

editing proc near

mov col1,00
mov row,01
mov count1,23
call clrscreen
cat:
mov ah,42h
mov al,00
mov bx,filehandle
mov cx,00
mov dx,col1
int 21h

add col1,74
mov ah,3fh
mov bx,filehandle
lea dx,temp2
mov cx,74
int 21h

mov col,02
mov counter,74

lea si,temp2
mana:
call setcursor
mov dl,[si]
inc si
mov ah,02h
int 21h
inc col
dec counter
jnz mana
inc row
dec count1
jnz cat
ret
editing endp

end main