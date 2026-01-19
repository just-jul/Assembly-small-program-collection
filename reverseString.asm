.model small
.stack 256
.data
	bufor db 21 dup(0) ; Bufor na 20 znaków + Enter
	komunikat db 'Wpisz tekst (max 20 znakow): $'
	wynik db 0Dh, 0Ah, 'Odwrocony tekst: $'

.code
main proc
	mov ax, @data
	mov ds, ax
	
	; Wyświetl komunikat
	lea dx, komunikat
	mov ah, 09h
	int 21h
	
	; Wczytaj znaki do bufora
	mov si, 0
	
wczytuj:
	mov ah, 01h
	int 21h
	
	cmp al, 0Dh ; Enter?
	je zakoncz_wczytywanie
	
	mov bufor[si], al
	inc si
	cmp si, 20 ;Max 20 znakow
	jl wczytuj
	
zakoncz_wczytywanie:
	; SI zawiera długość
	; Teraz wyświetl w odwrotnej kolejności
	
	lea dx, wynik
	mov ah, 09h
	int 21h
	
	; Wyświetl od końca
	mov cx, si ; CX = długość
	cmp si, 0 ; jesli si = 0, jump do koniec
	je koniec
	
wyswietl:
	dec si
	mov dl, bufor[si]
	mov ah, 02h
	int 21h
	loop wyswietl
	
koniec:
	mov ax, 4C00h
	int 21h
	
main endp
end main 