;------------------------------------------------------------------------------------------------------------
; Zailabdeen, Hoon, Choi : lab 4
;
; Description:	 1. This program will use a proc to generate a numerical grade between 0 and 100 (inclusive)
;				 2. Associate a letter grade to the generated number  
;				 3. Print the generated number along with the letter grade
;------------------------------------------------------------------------------------------------------------

include C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.inc
includelib C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.lib	

.386
.model flat, stdcall
.stack 4096

.const
		;Defines all constants
		NULL			equ				0
		gradeF			equ				60
		gradeDm			equ				63
		gradeD			equ				67
		gradeDp			equ				70
		gradeCm			equ				73
		gradeC			equ				77
		gradeCp			equ				80
		gradeBm			equ				83
		gradeB			equ				87
		gradeBp			equ				90
		gradeAm			equ				93
		gradeA			equ				101
.data?
		;declares uninitilized varibles			
		_numGrade		dword			?
	
.data
		_msg1			byte			"The Grade ", NULL
		_msg2			byte			" is Equivalent to the letter ", NULL

	
;prototypes for procs
	getNumericalGrade proto
	printGrade	proto, numGrade:dword, msg1:PTR byte, msg2: PTR byte

.code
    main    proc
	
			invoke getNumericalGrade
			mov	_numGrade, eax
			invoke printGrade, _numGrade, ADDR _msg1, ADDR _msg2	
	
			ret 0
	main    endp

;***********************************************************************************
;Proc Name  :	getNumericalGrade
;Description:   Gets a random numerical grade between 0 and 100
;Paramaters :	no paramater
;Return     :	Numerical grade number in eax
;***********************************************************************************
getNumericalGrade	proc
			call	randomize

			;gets a random number between 0-100 and places it in eax
			mov		eax,	101
			call	randomRange
			
			ret 
getNumericalGrade	endp


;***********************************************************************************
;Proc Name  :	printGrade
;Description:   Prints a letter grade, based on numerical value input
;Paramaters :	dword, pointer to byte, pointer to byte
;Return     :	no return
;***********************************************************************************
printGrade	proc uses eax ebx ecx edx, numGrade:dword, msg1:PTR byte, msg2: PTR byte
			
;compares numGrade to various grade levels, and jumps to appropriate Label
			cmp	numGrade,	gradeF
			JL	PrintFail

			cmp	numGrade,	gradeDm
			JL	PrintDm

			cmp	numGrade,	gradeD
			JL PrintD

			cmp	numGrade,	gradeDp
			JL PrintDp

			cmp	numGrade,	gradeCm
			JL PrintCm
			
			cmp	numGrade,	gradeC
			JL PrintC

			cmp	numGrade,	gradeCp
			JL PrintCp

			cmp	numGrade,	gradeBm
			JL PrintBm

			cmp	numGrade,	gradeB
			JL PrintB

			cmp	numGrade,	gradeBp
			JL PrintBp

			cmp	numGrade,	gradeAm
			JL PrintAm

			cmp	numGrade,	gradeA
			JL PrintA

;assigns values to ebx and ecx which will be used to print letter grade on the eof label.
PrintFail:	mov ebx, 'F'
			mov ecx, ' '
			jmp eof
			
PrintDm:	mov ebx, 'D'
			mov ecx, '-'
			jmp eof
	
PrintD:		mov ebx, 'D'
			mov ecx, ' '
			jmp eof
	
PrintDp:	mov ebx, 'D'
			mov ecx, '+'
			jmp eof
	
PrintCm:	mov ebx, 'C'
			mov ecx, '-'
			jmp eof
		
PrintC:		mov ebx, 'C'
			mov ecx, ' '
			jmp eof
	
PrintCp:	mov ebx, 'C'
			mov ecx, '+'
			jmp eof

PrintBm:	mov ebx, 'B'
			mov ecx, '-'
			jmp eof
	
PrintB:		mov ebx, 'B'
			mov ecx, ' '
			jmp eof
		
PrintBp:	mov ebx, 'B'
			mov ecx, '+'
			jmp eof
	
PrintAm:	mov ebx, 'A'
			mov ecx, '-'
			jmp eof
	
PrintA:		mov ebx, 'A'
			mov ecx, ' '
			jmp eof

;prints message to user, regarding numerical grade, and the letter graded associated
eof:		mov edx, msg1
			call writeString
			mov eax, numGrade
			call writeInt
			mov edx, msg2
			call writeString
			
			;writes letter grade
			mov eax, ebx
			call writeChar
			mov eax, ecx
			call writeChar
			ret
printGrade	endp
            end     main