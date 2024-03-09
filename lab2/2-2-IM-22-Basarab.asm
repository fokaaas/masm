.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc

.data?
	windowContentBuffer		db 256	dup (?)
	positiveDStringBuffer	db 32 	dup (?)
	negativeDStringBuffer	db 32 	dup (?)
	positiveEStringBuffer	db 32 	dup (?)
	negativeEStringBuffer	db 128	dup (?)
	positiveFStringBuffer	db 128	dup (?)
	negativeFStringBuffer	db 128	dup (?)
	
.data
	windowCaption 		db 	"Лаб. робота 2. Басараб Станіслав ІМ-22", 0
	
	windowContent		db 	"Моя дата народження: 07042005", 10, 10,
							"Номер залікової книжки: 8856", 10, 10,
							"Значення констант:", 10,
							"A = %d, -A = %d", 10,
							"B = %d, -B = %d", 10,
							"C = %d, -C = %d", 10,
							"D = %s, -D = %s", 10,
							"E = %s, -E = %s", 10,
							"F = %s, -F = %s", 0
							
	dateOfBirth			db 	"07042005", 0
							
	positiveAByte		db 	07
	negativeAByte		db 	-07
	
	positiveAWord		dw 	07
	positiveBWord		dw 	0704
	negativeAWord		dw 	-07
	negativeBWord		dw 	-0704
	
	positiveAShortInt	dd 	07
	positiveBShortInt	dd 	0704
	positiveCShortInt	dd 	07042005
	negativeAShortInt	dd 	-07
	negativeBShortInt	dd 	-0704
	negativeCShortInt	dd 	-07042005
	
	positiveDSingle		dd 	0.001
	negativeDSingle		dd 	-0.001
	
	positiveALongInt	dq 	07
	positiveBLongInt	dq 	0704
	positiveCLongInt	dq 	07042005
	negativeALongInt	dq 	-07
	negativeBLongInt	dq 	-0704
	negativeCLongInt	dq 	-07042005
	
	positiveDDouble		dq 	0.001
	positiveEDouble		dq 	0.079
	positiveFDouble		dq 	795.168
	negativeDDouble		dq 	-0.001
	negativeEDouble		dq 	-0.079
	negativeFDouble		dq 	-795.168
	
	positiveFExtended	dt 	795.168
	negativeFExtended	dt 	-795.168
	
.code
start:
	invoke FloatToStr2, positiveDDouble, addr positiveDStringBuffer
	invoke FloatToStr2, positiveEDouble, addr positiveEStringBuffer
	invoke FloatToStr2, positiveFDouble, addr positiveFStringBuffer
	invoke FloatToStr2, negativeDDouble, addr negativeDStringBuffer
	invoke FloatToStr2, negativeEDouble, addr negativeEStringBuffer
	invoke FloatToStr2, negativeFDouble, addr negativeFStringBuffer
	
	invoke wsprintf,
		addr windowContentBuffer,
		addr windowContent,
		positiveAShortInt,
		negativeAShortInt,
		positiveBShortInt,
		negativeBShortInt,
		positiveCShortInt,
		negativeCShortInt,
		addr positiveDStringBuffer,
		addr negativeDStringBuffer,
		addr positiveEStringBuffer,
		addr negativeEStringBuffer,
		addr positiveFStringBuffer,
		addr negativeFStringBuffer
	
	invoke MessageBox, NULL, addr windowContentBuffer, addr windowCaption, MB_OK
	
	invoke ExitProcess, 0
end start