.386
.model flat, stdcall
option casemap:none

public stbasarabCollectDown
extern SBasarabFourNum:qword, SBasarabMasivForBukvaA:qword, SBasarabMasivForBukvaB:qword

.code
stbasarabCollectDown proc
	; a / 4
	fld SBasarabMasivForBukvaA[esi * 8]
	fdiv SBasarabFourNum
		
	; a / 4 - b
	fld SBasarabMasivForBukvaB[esi * 8]
	fsub
	
	; tg(a / 4 - b)
	fptan
	ret
stbasarabCollectDown endp
end