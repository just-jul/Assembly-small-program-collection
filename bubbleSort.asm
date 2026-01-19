.model small
.stack 256
.data
	tablica db 64, 34, 25, 12, 22, 11, 90, 88
	n dw 8
	komunikat db 'Posortowana tablica: $'
	
.code
main proc
	mov ax, @data
	mov ds, ax
	
	; Sortowanie bąbelkowe
	; Zewnętrzna pętla (i = 0 to n-1)
	mov cx, n
	dec cx ; CX = n-1 (liczba przejść)
	
petla_zewnetrzna:
	push cx ; Zapisz licznik zewnętrzny
		
	; Wewnętrzna pętla (j = 0 to n-i-1)
	mov bx, 0 ; BX = indeks j
	
	mov di, cx ; licznik wewnetrzny (n-1-i)
	
petla_wewnetrzna:
	; Porównaj tablica[j] z tablica[j+1]
	mov al, tablica[bx]
	mov dl, tablica[bx+1]
	
	
	cmp al, dl
	jbe nie_zamieniaj ; Jump if Below or Equal (al <= dl)
	
	; Zamień miejscami
	mov tablica[bx], dl
	mov tablica[bx+1], al
	
nie_zamieniaj:
	inc bx
	dec di ; zmniejszami licznik wewnetrzny 
	jnz petla_wewnetrzna ; skocz dopoki dx != 0

	pop cx  	; Przywróć licznik zewnętrzny
	loop petla_zewnetrzna

	; Wyświetl posortowaną tablicę
	lea dx, komunikat
	mov ah, 09h
	int 21h
	
	mov cx, 8
	mov si, 0
	
	
wyswietl:
	mov al, tablica[si]
	xor ah, ah
	mov bl, 10
	div bl ; AL = dziesiatki, AH = reszta (jedności)
	mov bh, ah ; zachowujemy reszte w bh
	
	add al, '0'  ; Konwersja na ASCII (dla cyfr < 10)
	mov dl, al
	mov ah, 02h  
	int 21h
	
	; Wyświetl jedności
	mov al, bh
	add al, '0'
	mov dl, al
	mov ah, 02h
	int 21h
	
	
	mov dl, ' '  ; spacja
	mov ah, 02h
	int 21h
	
	inc si
	loop wyswietl
	
	mov ax, 4C00h
	int 21h
main endp
end main