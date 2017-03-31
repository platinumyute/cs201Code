;------------------------------------------------------------------------------------
; Zailabdeen, Hoon, Choi : lab 3
;
; Description:	1. This program generates a value between two user input values,
;				2. Creates a single dimensional array that holds 25 numbers. Each number will be randomly
;				   generated and range from 1 – 40, and prints sum
;-------------------------------------------------------------------------------------

include C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.inc
includelib C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.lib	

.386
.model flat, stdcall
.stack 4096


.const
			;Defines null to be 0
			 NULL				equ				0

.data?
			;declares uninitilized varibles
			
			_randVal			dword			?
			_array				dword			25 dup(?)
	
.data
			_array_size			dword				25
			_max					dword				100
			_min					dword				1


LoadArray proto array:PTR dword, aSize:dword, rand_max:dword, rand_min:dword
PrintSmallestAndLargestElements	proto, array: PTR dword, aSize: dword

.code
    main    proc
            
			invoke	LoadArray, ADDR _array, _array_size, _max, _min
			invoke	PrintSmallestAndLargestElements, ADDR _array, _array_size

			
			ret 0
main        endp

LoadArray	proc	uses eax ecx esi, array:PTR dword, aSize:dword, max:dword, min:dword
			
			call	randomize
			mov		esi,	array
			mov		ecx,	aSize
			mov		ebx,	1						; remove this
FILL:		mov		eax,	max
			sub		eax,	min
			add		eax,	1			 
			call	randomRange
			add		eax,	min		
			mov		[esi],	eax
			add		esi,	TYPE dword
			
			loop	FILL
			ret 

LoadArray	endp

;Proc Name: PrintSmallestAndLargestElements
;Description: finds the smallest and largest value in a given array
;Return: eax: smallest value, ebx: largest values
;
PrintSmallestAndLargestElements	proc uses ecx esi, array: PTR dword, aSize: dword

			;will hold smallest value in eax, and largest value in ebx;
			mov		esi,	array
			mov		ecx,	aSize
			mov		eax,	[esi]	
			mov		ebx,	[esi]
		   
FindSmallest:
			cmp		[esi],	eax
			JGE		FindLargest
			
			mov		eax,	[esi]

FindLargest:	
			cmp		[esi],	ebx
			JLE		repeatSteps

			mov		ebx,	[esi]

repeatSteps:
			add		esi,	TYPE dword
			loop	FindSmallest
		
			ret

PrintSmallestAndLargestElements endp
            end     main