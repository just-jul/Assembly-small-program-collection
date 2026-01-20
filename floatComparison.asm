.MODEL SMALL
.STACK 100h
.486
.487
.DATA
	liczba_a DD 6.5
	liczba_b DD 4.7
	tekst_a DB 'Wieksza: A$'
	tekst_b DB 'Wieksza: B$'
	tekst_rowne DB 'Liczby sa rowne$'
	status_fpu DW ?
	
.CODE
Start:
	MOV AX, @DATA
	MOV DS, AX
	FINIT
	; Zaladuj liczby
	FLD DWORD PTR [liczba_a] ; ST(0) = a
	FLD DWORD PTR [liczba_b] ; ST(0) = b, ST(1) = a
	
	; Porownaj ST(0) z ST(1)
	FCOM ST(1) ; b z a
	
	; Zapisz status FPU do pamieci 
	FSTSW [status_fpu] ; zmiana na FSTSW
	
	; Zaladuj status do AX
	MOV AX, [status_fpu]
	
	TEST AX, 4000h ; sprawdz C3 (rownosc)
	JNZ rowne 
	
	TEST AX, 0100h ; sprawdz C0 (bit 8)
	JNZ a_wieksza ; Jesli B < A, idz do a_wieksza
	JNZ a_mniejsza
	
a_wieksza:
	MOV AH, 09h
	MOV DX, OFFSET tekst_a
	INT 21h
	JMP koniec
	
a_mniejsza:
	MOV AH, 09h
	MOV DX, OFFSET tekst_b
	INT 21h
	JMP koniec
	
rowne:
	MOV AH, 09h
	MOV DX, OFFSET tekst_rowne
	INT 21h

koniec:
	; Posprzataj stos FPU
	FSTP ST(0)
	FSTP ST(0)
	MOV AX, 4C00h
	INT 21h
END Start