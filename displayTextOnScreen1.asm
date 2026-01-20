MODEL SMALL
.STACK 100h
.DATA
	tekst DB 'HELLO'
	dlugosc EQU 5
.CODE
Start:
	MOV AX, @DATA
	MOV DS, AX
	
	; Ustaw segment pamięci ekranu
	MOV AX, 0B800h ; pamiec ekranu 
	MOV ES, AX  ; ES zamiast DS
	
	; Oblicz pozycję: wiersz 10, kolumna 35
	; offset = (wiersz * 80 + kolumna) * 2
	MOV AX, 10
	MOV BX, 80
	MUL BX   ; AX = 10 * 80 = 800
	ADD AX, 35   ; AX = 800 + 35 = 835
	
	MOV BX, 2
	MUL BX ; AX * 2 bo 2 bajty 
	
	MOV DI, AX
	
	; Atrybut: zielony tekst (02h) na czarnym tle (00h)
	MOV AH, 02h ; poprawiony blad
	
	; Skopiuj tekst do pamieci ekranu
	MOV SI, OFFSET tekst
	MOV CX, dlugosc
	
kopiuj:
	MOV AL, DS:[SI] ; poprawione 
	MOV ES:[DI], AX  ; poprawione - znak AL i kolor AH do ES:DI
	INC SI
	ADD DI, 2
	LOOP kopiuj
	
	; Poczekaj na klawisz
	MOV AH, 00h
	INT 16h
	
	MOV AX, 4C00h
	INT 21h
END Start
