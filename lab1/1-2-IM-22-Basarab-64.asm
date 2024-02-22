OPTION DOTNAME
	
option casemap:none
include \masm64\include\temphls.inc
include \masm64\include\win64.inc
include \masm64\include\kernel32.inc
includelib \masm64\lib\kernel32.lib
include \masm64\include\user32.inc
includelib \masm64\lib\user32.lib
OPTION PROLOGUE:rbpFramePrologue
OPTION EPILOGUE:none

.data
MsgCaption      db 'Персональні дані студента', 0
MsgBoxText      db 'ПІБ: Басараб Станіслав Анатолійович', 13, 10,
                'Дата народження: 07.04.2005', 13, 10,
                'Номер залікової книжки: ІМ2202', 0

.code
WinMain proc 
	sub rsp,28h
      invoke MessageBox, NULL, &MsgBoxText, &MsgCaption, MB_OK
      invoke ExitProcess,NULL
WinMain endp
end