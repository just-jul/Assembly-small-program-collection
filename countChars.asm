.model small
.stack 256
.data
komunikat db 'Wprowadz tekst: $'
wynik db 0Dh, 0Ah, 'Liczba znakow: $'

.code
main proc 
	mov ax, @data 
	mov ds, ax
	
	lea dx, komunikat
	mov ah, 09h
	int 21h 
	
	mov cx, 0 
	
	wczytuj:
		mov ah, 01h 
		int 21h ; Funkcja 01h - czytaj znak z echo
		
		cmp al, 0Dh ; Czy to Enter?
		je wyswietl ; Jeśli tak - jump do wyswietl
		
		inc cx ; Zwiększ licznik
		jmp wczytuj ; jesli nie - wroc do wczytuj 
		
	wyswietl:
	  ; Wyświetl wynik
    lea dx, wynik
    mov ah, 09h
    int 21h
    
    ; wyswietl liczbe 
		mov ax, cx
		add al, '0'
		mov dl, al
		mov ah, 02h
		int 21h
		
		mov ax, 4C00h
		int 21h
	
main endp
end main