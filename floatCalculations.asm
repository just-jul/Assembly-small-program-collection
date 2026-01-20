.MODEL SMALL
.STACK 100h
.486
.487
.DATA
	nowa_linia DB 0Dh, 0Ah, '$'
	
	a    DD  3.0
	b    DD  4.5
	c    DD  10.0
	d    DD  4.0
	
	wynik_int DW ?
	
	tekst DB 'Wynik: $'
	
.CODE
Start:
	MOV AX, @DATA
	MOV DS, AX
	
	FINIT ; inicjalizacja FPU
	
	; oblicz a*b
	FLD a  ; ST(0) = a (3.0)
	FLD b  ; ST(0) = b (4.5), ST(1) = a (3.0)
	FMULP ; poprawa, ST(0) = a*b = 13.5
	
	; Oblicz c/d
	FLD c ; ST(0) = c (10.0), ST(1) = a*b = 13.5
	FLD d ; ST(0) = d (4.0), ST(1) = c, ST(2) = a*b
	FDIVP ; poprawa, ST(0) = c/d = 2.5
	
	; Dodaj wyniki
	FADDP ST(1), ST(0)  ; ST(1) = a*b + (c/d) = 13.5 + 2.5 = 16
	
	; Zapisz wynik
	FISTP WORD PTR [wynik_int]
	
	; Wyswietl tekst
	MOV AH, 09h
	MOV DX, OFFSET tekst
	INT 21h
	
	; wyswietl wynik 
	MOV AX, [wynik_int]
	XOR AH, AH
	MOV BL, 10
	DIV BL        
	
	MOV CX, AX

	MOV DL, CL
	ADD DL, '0'
	MOV AH, 02h   
	INT 21h

	MOV DL, CH    
	ADD DL, '0'
	MOV AH, 02h
	INT 21h

koniec:
	MOV AX, 4C00h
	INT 21h
END Start	