.model small
.stack 256
.data
	tablica dw 100, 200, 50, 75, 25 ; Suma = 450
	suma dw 0
	komunikat db 'Suma elementow tablicy: $'
	
.code
main proc
	mov ax, @data
	mov ds, ax
	
	; Oblicz sumę
	mov cx, 5 ; 5 elementów
	mov si, 0 ; Indeks
	
petla:
	mov ax, tablica[si]
	add suma, ax
	add si, 2 ; Następny element -> slowo == 2 bajty
	loop petla 
	
	; Wyświetl komunikat
	lea dx, komunikat
	mov ah, 09h
	int 21h
	
	; Wyświetl sumę (zakładamy < 1000, 3 cyfry)
	mov ax, suma
	
	; Setki
	mov bl, 100
	div bl  ; AL = setki, AH = reszta (dziesiątki*10 + jedności)
	mov bh, ah ; zachowujemy reszte w bh
	
	add al, '0'
	mov dl, al
	mov ah, 02h  
	int 21h
	
	mov ah, bh ; przywracamy reszte do ah 
	
	; Dziesiątki i jedności
	mov al, ah  
	xor ah, ah
	mov bl, 10
	div bl  ; AL = dziesiątki, AH = jedności
	
	; Zachowaj jedności
	mov bh, ah
	
	; Wyświetl dziesiątki
	add al, '0'
	mov dl, al
	mov ah, 02h
	int 21h
	
	; Wyświetl jedności
	mov al, bh
	add al, '0'
	mov dl, al
	mov ah, 02h
	int 21h
	
	
	mov ax, 4C00h
	int 21h
main endp
end main