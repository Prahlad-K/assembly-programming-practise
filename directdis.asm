.model small
.stack 64
video_seg segment at 0B900h ; page 1 of video area
vid_area db 1000h dup(?)
video_seg ends
.286
.code
main proc far
mov ax, video_seg
mov es, ax

assume es:video_seg
mov ax, 0003h
int 10h ; graphics mode

mov ax, 0501h
int 10h ; select page 1

call display
mov ah, 10h
int 16h ; waiting for keyboard response

mov ax, 4c00h
int 21h
main endp

display proc near
pusha
mov al, 41h; character to display
mov ah, 01h; attribute 
mov di, 820
mov cx, 60
repeat:
mov cx, 60
keepdoing:
mov es:word ptr[di], ax ; character to display
add di, 2
loop keepdoing

inc ah
inc al
add di, 40 ; indent for next row
cmp al, 51h
jne repeat
popa
ret
display endp

end main


