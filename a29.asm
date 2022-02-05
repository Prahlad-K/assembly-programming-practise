.model small
.stack 64
.286
video_seg segment at 0B900h ; page 1 of video area
vid_area db 1000h dup(?)
video_seg ends
.data
n db 'Prahlad$'
.code
main proc far
mov ax, video_seg
mov es, ax
mov ax, @data
mov ds, ax

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
lea si, n
mov di, 1994
mov cx, 7
mov ah, 01h
repeat:
mov al, [si]
mov es:word ptr[di], ax
inc si
inc ah
add di, 2
loop repeat
popa
ret
display endp

end main


