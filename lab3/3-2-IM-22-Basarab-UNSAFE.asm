.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data
	StanislavPasswordString			db "StasBas", 0
	StanislavCorrectWindowTitle		db "Password is correct!", 0
	StanislavCorrectWindowText		db "Full name of student: Basarab Stanislav Anatoliyovych", 13, 10,
									"Date of birth: 07.04.2005", 13, 10,
									"Zalik book: IM2202", 0
	StanislavWrongWindowTitle		db "Wrong password", 0
	StanislavWrongWindowText		db "Your password is wrong!", 0
	
.data?
	StanislavFieldPasswordString	db 32	dup (?)
	StanislavPasswordDecodedString	db 32	dup (?)

.code

Exit proc
	invoke ExitProcess, 0
Exit endp

Handler proc WindowHandle:dword, Unit:dword, WordPar:dword, LonPar:dword
	.if Unit == WM_COMMAND
		.if WordPar == IDOK
			invoke GetDlgItemText, WindowHandle, 1200, addr StanislavFieldPasswordString, 512
			invoke lstrcmp, offset StanislavPasswordString, offset StanislavFieldPasswordString
			
			.if EAX != 0
				invoke MessageBox, 0, offset StanislavWrongWindowText, offset StanislavWrongWindowTitle, 0
			.else
				invoke MessageBox, 0, offset StanislavCorrectWindowText, offset StanislavCorrectWindowTitle, 0
			.endif
			
		.endif
		
		.if WordPar == IDCANCEL
			call Exit
		.endif
			
	.elseif Unit == WM_CLOSE
		call Exit
	.endif
	return 0
Handler endp

start:
	Dialog "Lab3 | UNSAFE", "Tahoma", 11, \
	WS_SYSMENU or WS_OVERLAPPED or DS_CENTER, 4, 20, 20, 120, 95, 4466
	DlgStatic "Put the password", SS_CENTER, 1, 20, 75, 12, 445
	DlgEdit WS_BORDER, 6, 30, 110, 12, 1200
	DlgButton "Cancel", WS_TABSTOP, 19, 42, 35, 20, IDCANCEL 
	DlgButton "OK", WS_TABSTOP, 78, 42, 35, 20, IDOK
	
	CallModalDialog 0, 0, Handler, NULL
end start