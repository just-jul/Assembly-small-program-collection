.model small
.stack 256
.data
	; Tablica liczb bez znaku (unsigned byte)
	tablica db 45, 120, 33, 255, 67, 200, 15, 89, 178, 50
	maksimum db 0
	komunikat db 'Maksimum: $'
	
.code
main proc
	mov ax, @data
	mov ds, ax
	
	mov cx, 9 ; 9 porownan bo tablica[0] ustawiona jest jako aktualny max
	mov si, 1
	mov al, tablica[0]  ; Aktualne maksimum
	
petla:
	mov bl, tablica[si]
	cmp bl, al
	jb nie_wieksze ; jb zamiast jl (unsigned) 
	mov al, bl ; nowe maksimum
	
nie_wieksze:
	inc si
	loop petla

	mov maksimum, al
	
	; Wyświetl komunikat
	lea dx, komunikat
	mov ah, 09h
	int 21h
	
	mov al, maksimum
	xor ah, ah
	
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
