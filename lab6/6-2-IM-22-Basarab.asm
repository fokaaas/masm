.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data
	SBasarabWinCaption				db "Lab work No6", 0
	SBasarabMainWinContent			db "Formula for 2 variant: (-2*c - d*82)/tg(a/4 - b)", 10, 10,
										"a = %s", 10,
										"b = %s", 10,
										"c = %s", 10,
										"d = %s", 10,
										"Expression: (-2*%s - %s*82)/tg(%s/4 - %s)", 10, 10,
										"%s", 0

	SBasarabMasivForBukvaA 			dq -8.8, 9.2, 1.1, -7.3, 11.5, 9.424776, 15.70796
	SBasarabMasivForBukvaB 			dq 6.3, 7.4, 1.2, 8.5, 2.875, 3.92699, -0.785398
	SBasarabMasivForBukvaC			dq 4.5, 9.6, 9.7, -1.3, 9.2, 5.23, 1.2
	SBasarabMasivForBukvaD			dq -1.3, 1.1, -5.5, 3.4, 3.1, 41.2, 2.3
	
	SBasarabResultWinContent		db "Result: %s", 0
	SBasarabDivideByZeroWinContent	db "You cannot divide by zero!", 0
	SBasarabTgScopeWinContent		db "The area of definition of the tangent is violated!", 0
	
	SBasarabFourNum					dq 4.0
	SBasarabMinusTwoNum				dq -2.0
	SBasarabEightyTwoNum			dq 82.0
	SBasarabPiNum					dq 3.141592
	SBasarabPiNa2Num				dq 1.570796

.data?
	SBasarabWinContentB				db 256 dup (?)
	SBasarabResultContentB			db 256 dup (?)
	
	SBasarabThisAStringB			db 128 dup (?)
	SBasarabThisBStringB			db 128 dup (?)
	SBasarabThisCStringB			db 128 dup (?)
	SBasarabThisDStringB			db 128 dup (?)
	SBasarabResultStringB			db 128 dup (?)
	
	SBasarabTanArgB					dt ?
	SBasarabUpB						dt ?
	SBasarabDownB					dt ?
	SBasarabMultiplicationNum1		dt ?
	SBasarabMultiplicationNum2		dt ?
	SBasarabReminder				dt ?
	SBasarabResultB					dq ?
	
.code
basarabLab6:
	mov esi, 0
	cycl_for_counting:
		finit
		
		; a / 4
		fld SBasarabMasivForBukvaA[esi * 8]
		fdiv SBasarabFourNum
		
		; a / 4 - b
		fld SBasarabMasivForBukvaB[esi * 8]
		fsub
		
		fstp SBasarabTanArgB
		
		invoke FloatToStr, SBasarabMasivForBukvaA[esi * 8], addr SBasarabThisAStringB
		invoke FloatToStr, SBasarabMasivForBukvaB[esi * 8], addr SBasarabThisBStringB
		invoke FloatToStr, SBasarabMasivForBukvaC[esi * 8], addr SBasarabThisCStringB
		invoke FloatToStr, SBasarabMasivForBukvaD[esi * 8], addr SBasarabThisDStringB
		
		; if arg == 0
		fld SBasarabTanArgB ; load tg arg
		fldz ; load zero
		fcom ; comparison
		fnstsw ax ; save to ax
		sahf ; check flag
		jz basarab_divide_by_zero
		
		fld SBasarabTanArgB
		fsub SBasarabPiNa2Num
		
		; load pi
		fld SBasarabPiNum
		fprem
		fistp dword ptr [SBasarabReminder]
		cmp dword ptr [SBasarabReminder], 0
		je basarab_invalid_arg
		
		; tg(a / 4 - b)
		fld SBasarabTanArgB
		fptan
		
		fstp st(0)
		fstp SBasarabDownB
		
		; -2 * c
		fld SBasarabMasivForBukvaC[esi * 8]
		fld SBasarabMinusTwoNum
		fmul
		fstp SBasarabMultiplicationNum1
		
		; d * 82
		fld SBasarabMasivForBukvaD[esi * 8]
		fld SBasarabEightyTwoNum
		fmul
		fstp SBasarabMultiplicationNum2
		
		; -2 * c - d * 82
		fld SBasarabMultiplicationNum1
		fld SBasarabMultiplicationNum2
		fsub
		fstp SBasarabUpB
		
		; (-2 * c - d * 82) / tg(a / 4 - b)
		fld SBasarabUpB
        fld SBasarabDownB
        fdiv
		fstp SBasarabResultB
		
		invoke FloatToStr, SBasarabResultB, addr SBasarabResultStringB
		
		invoke wsprintf, addr SBasarabResultContentB, addr SBasarabResultWinContent, addr SBasarabResultStringB
		invoke wsprintf, addr SBasarabWinContentB, addr SBasarabMainWinContent,
			addr SBasarabThisAStringB, addr SBasarabThisBStringB, addr SBasarabThisCStringB, addr SBasarabThisDStringB,
			addr SBasarabThisCStringB, addr SBasarabThisDStringB, addr SBasarabThisAStringB, addr SBasarabThisBStringB,
			addr SBasarabResultContentB
		
		basarab_return:
			invoke MessageBox, 0, addr SBasarabWinContentB, addr SBasarabWinCaption, 0
		
			inc esi
			.if esi == 7
				invoke ExitProcess, 0
			.endif
		
			jmp cycl_for_counting
		
		basarab_divide_by_zero:
			invoke wsprintf, addr SBasarabWinContentB, addr SBasarabMainWinContent,
				addr SBasarabThisAStringB, addr SBasarabThisBStringB, addr SBasarabThisCStringB, addr SBasarabThisDStringB,
				addr SBasarabThisCStringB, addr SBasarabThisDStringB, addr SBasarabThisAStringB, addr SBasarabThisBStringB,
				addr SBasarabDivideByZeroWinContent
			jmp basarab_return
			
		basarab_invalid_arg:
			invoke wsprintf, addr SBasarabWinContentB, addr SBasarabMainWinContent,
				addr SBasarabThisAStringB, addr SBasarabThisBStringB, addr SBasarabThisCStringB, addr SBasarabThisDStringB,
				addr SBasarabThisCStringB, addr SBasarabThisDStringB, addr SBasarabThisAStringB, addr SBasarabThisBStringB,
				addr SBasarabTgScopeWinContent
			jmp basarab_return
end basarabLab6