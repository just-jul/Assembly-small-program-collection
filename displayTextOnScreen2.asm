MODEL SMALL
.STACK 100h

.DATA
	tekst DB 'TEST'
	dlugosc EQU 4
.CODE
Start:
	MOV AX, @DATA
	MOV DS, AX
	
	; Ustaw segmenty
	MOV AX, 0B800h
	MOV ES, AX

	; Oblicz pozycję: wiersz 12, kolumna 30
	MOV DI, (12 * 80 + 30) * 2
	MOV AH, 1Fh ; zmiana atrybutu na 1Fh - bit 7 ustawiamy na 0 zeby nie migało
	
	; Kopiuj tekst
	MOV SI, OFFSET tekst
	MOV CX, dlugosc
	
kopiuj:
	LODSB  ; AL = [DS:SI], SI++
	STOSW  ; [ES:DI] = AX, DI += 2
	LOOP kopiuj
	
	; Poczekaj na klawisz
	MOV AH, 00h
	INT 16h
	
	MOV AX, 4C00h
	INT 21h
END Start