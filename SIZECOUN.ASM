.model small
.stack 60
.data
uWord dw 10, 20, 30, 40, 50, 60, 70, 80
uWord_Siz = ($-uWord)/2 ; divide by 2 to get the number of words in word list
.data? ; Data to be created on program initialization
.code
main PROC  far
mov ax, @data
mov ds, ax

mov dl, uWord_Siz
add dl, 30h
int 21h

mov ax, 4c00h
int 21h
main endp
end main
