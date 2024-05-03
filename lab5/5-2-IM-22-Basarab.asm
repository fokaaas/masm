.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data?
	SBasarabWindowContentB		db 256 dup (?)
	SBasarabResultContentB		db 256 dup (?)
	
	SBasarabDown				dd ?
	SBasarabResult				dd ?

.data
	SBasarabArrayForA 			dd -25, 5, -5, 25, 5
	SBasarabArrayForB 			dd 2, 2, 6, 8, 2
	SBasarabArrayForC			dd 4, 3, -9, -2, -1
	
	SBasarabWindowCaption		db "Lab 5. Stanislav Basarab IM-22", 0
	SBasarabMainWindowContent	db "Formula for 2 variant: (-25/a + c - b*a)/(1 + c*b/2)", 10, 10,
								"a = %d", 10,
								"b = %d", 10,
								"c = %d", 10,
								"Expression: (-25/%d + %d - %d*%d)/(1 + %d*%d/2)", 10, 10,
								"%s", 0
	SBasarabResultWindowContent	db "Intermediate result: %d", 10,
								"Final result: %d", 0
	SBasarabErrorWindowContent	db "You cannot divide by zero!"
	
	SBasarabCounter				dd 0
	
.code
start:
	mov esi, SBasarabCounter
	start_loop_label:
		mov eax, SBasarabArrayForB[4 * esi]
		mov ebx, 2
		cdq
		idiv ebx
		
		mov ecx, SBasarabArrayForC[4 * esi]
		imul eax, ecx
		
		add eax, 1
		
		.if eax == 0
			invoke wsprintf, offset SBasarabWindowContentB, offset SBasarabMainWindowContent,
				SBasarabArrayForA[4 * esi], SBasarabArrayForB[4 * esi], SBasarabArrayForC[4 * esi],
				SBasarabArrayForA[4 * esi], SBasarabArrayForC[4 * esi], SBasarabArrayForB[4 * esi], SBasarabArrayForA[4 * esi],
				SBasarabArrayForC[4 * esi], SBasarabArrayForB[4 * esi], offset SBasarabErrorWindowContent
		.else
			mov SBasarabDown, eax
			
			mov eax, -25
			mov ebx, SBasarabArrayForA[4 * esi]
			cdq
			idiv ebx
			
			mov edx, SBasarabArrayForB[4 * esi]
			imul edx, ebx
			
			add eax, ecx
			sub eax, edx
		
			mov ebx, SBasarabDown
			cdq
			idiv ebx
			
			mov SBasarabResult, eax
			
			test eax, 1
			jz processEven
			jnz processOdd
			
			display:
				invoke wsprintf, offset SBasarabResultContentB, offset SBasarabResultWindowContent,
					SBasarabResult, eax
				invoke wsprintf, offset SBasarabWindowContentB, offset SBasarabMainWindowContent,
					SBasarabArrayForA[4 * esi], SBasarabArrayForB[4 * esi], SBasarabArrayForC[4 * esi],
					SBasarabArrayForA[4 * esi], SBasarabArrayForC[4 * esi], SBasarabArrayForB[4 * esi], SBasarabArrayForA[4 * esi],
					SBasarabArrayForC[4 * esi], SBasarabArrayForB[4 * esi], offset SBasarabResultContentB
		.endif
		
		invoke MessageBox, 0, offset SBasarabWindowContentB, offset SBasarabWindowCaption, 0
		
		inc esi
		.if esi == 5
			invoke ExitProcess, 0
		.endif
		
		jmp start_loop_label
		
		processEven:
			mov ebx, 2
			cdq
			idiv ebx
			jmp display
			
		processOdd:
			mov ebx, 5
			imul eax, ebx
			jmp display
end start