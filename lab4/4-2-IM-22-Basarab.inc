ShowWindowMessage macro text, caption ; start of the macro
	;; Message Box invocation
	invoke MessageBox, 0, addr text, addr caption, 0
endm

DecryptPassword macro
	mov esi, offset BasarabPasswordBuffer
    mov edi, offset BasarabPasswordKey
    mov ebx, offset BasarabDecryptedPassword

	;; start of xor loop
	xor_loop:
		mov al, [esi]
		xor al, [edi] ; xor operation
		mov [ebx], al
		inc esi
		inc edi
		inc ebx
		cmp al, 0
		jne xor_loop

    mov eax, 0
endm

ComparePassword macro a, b
	local compare ; declaration of a local label
	
	compare:
		;; invocation of lstrcmp
		invoke lstrcmp, addr a, addr b
endm