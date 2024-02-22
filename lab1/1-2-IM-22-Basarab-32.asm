.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

.data
    caption db "Персональні дані студента", 0
    basarabData db "ПІБ: Басараб Станіслав Анатолійович", 13, 10,
                "Дата народження: 07.04.2005", 13, 10,
                "Номер залікової книжки: ІМ2202", 0

.code
start:
    invoke MessageBox, NULL, addr basarabData, addr caption, MB_OK
    invoke ExitProcess, 0
end start