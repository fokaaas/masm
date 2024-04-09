.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

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

.data?
	BasarabPasswordBuffer		db 16	dup (?)
	BasarabDecryptedPassword	db 16	dup (?)

.data
	BasarabSuccessWindowCaption		db "The password is entered correctly!", 0
	BasarabFullNameWindowMessage	db "Full name: Basarab Stanislav Anatoliyovych", 0
	BasarabBirthDateWindowMessage	db "Date of Birth: 07.04.2005", 0
	BasarabStudentIdWindowMessage	db "Student ID: IM2202", 0
								
	BasarabErrorWindowCaption		db "Error", 0
	BasarabErrorWindowMessage		db "The password is incorrect, please try again!", 0
	
	BasarabPassword					db "kGXFrSD", 0
	BasarabPasswordKey				db "8395027", 0

.code

Handle proc
	ComparePassword BasarabDecryptedPassword, BasarabPassword
	.if eax == 0
		ShowWindowMessage BasarabFullNameWindowMessage, BasarabSuccessWindowCaption
		ShowWindowMessage BasarabBirthDateWindowMessage, BasarabSuccessWindowCaption
		ShowWindowMessage BasarabStudentIdWindowMessage, BasarabSuccessWindowCaption
	.else
		ShowWindowMessage BasarabErrorWindowMessage, BasarabErrorWindowCaption
	.endif
	ret
Handle endp

DialogProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	.if uMsg == WM_COMMAND
		.if wParam == IDCANCEL
			invoke ExitProcess, 0
			
		.elseif wParam == IDOK
			invoke GetDlgItemText, hWnd, 100, addr BasarabPasswordBuffer, 512
			DecryptPassword
			call Handle
		.endif
		
	.elseif uMsg == WM_CLOSE
		invoke ExitProcess, 0
	.endif
	
	return 0
DialogProc endp

start:
	Dialog "Lab. work 4. Stanislav Basarab IM-22", "Tahoma", 11, \
	WS_SYSMENU or WS_OVERLAPPED or DS_CENTER, 4, 15, 15, 130, 100, 2202
	DlgStatic "Enter the password", SS_CENTER, 0, 15, 80, 10, 123
	DlgEdit WS_BORDER, 5, 25, 100, 10, 100
	DlgButton "Cancel", WS_TABSTOP, 20, 40, 30, 15, IDCANCEL 
	DlgButton "Confirm", WS_TABSTOP, 75, 40, 30, 15, IDOK
	
	CallModalDialog 0, 0, DialogProc, NULL
end start