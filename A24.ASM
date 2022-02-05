.model small
.stack 64
.data
n db 'Prahlad blinks!$'
l db $-n
i db 10
count dw 10000
.code
main proc far
mov ax, @data
mov ds, ax

dec l
lea si, n

call clrscr
XXX:

call startsound

mov dl,i 
call setcur
mov ah, 09h
mov al, [si] 
mov bh, 0
mov bl, 8Ah
mov cx, 1
int 10h
inc i
inc si
dec l
cmp l, 0
jne XXX

mov ax, 4c00h
int 21h

main endp

setcur proc near
mov ah, 02
mov bh, 0
mov dh, 10
int 10h; sets the cursor
ret
setcur endp

clrscr proc near
mov ah, 06
mov al, 0 ; clearing the screen
mov bh, 07h
mov cx, 0000h
mov dx, 184Fh
int 10h; sets the attribute of white background and blue foreground.
ret
clrscr endp

scroll proc near
mov ah, 06
mov al, 20 ; scrolling the screen
mov bh, 71
mov cx, 0000h
mov dx, 184Fh
int 10h; scrolls three lines up
ret
scroll endp


STARTSOUND proc near	;CX=FREQUENCY IN HERTZ. DESTROYS AX & DX
CMP CX, 014H
JB STARTSOUND_DONE
CALL STOPSOUND
IN AL, 061H
;AND AL, 0FEH
;OR AL, 002H
OR AL, 003H
DEC AX
OUT 061H, AL	;TURN AND GATE ON; TURN TIMER OFF
MOV DX, 00012H	;HIGH WORD OF 1193180
MOV AX, 034DCH	;LOW WORD OF 1193180
DIV CX
MOV DX, AX
MOV AL, 0B6H
PUSHF
CLI	
OUT 043H, AL
MOV AL, DL
OUT 042H, AL
MOV AL, DH
OUT 042H, AL
POPF
IN AL, 061H
OR AL, 003H
OUT 061H, AL
	STARTSOUND_DONE:
ret
	STOPSOUND:	;DESTROYS AL
IN AL, 061H
AND AL, 0FCH
OUT 061H, AL
RET
startsound endp

end main
