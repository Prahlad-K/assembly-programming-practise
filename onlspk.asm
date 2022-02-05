.model small
.stack 64
.code
main proc far

call startsound

mov ax, 4c00h
int 21h
main endp

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
CLI	;!!!
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