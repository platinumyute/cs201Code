;------------------------------------------------------------------------------------
; Zailabdeen, Hoon, Choi : lab 3
;
; Description:	 1. This program Creates a single dimensional array that holds 25 numbers. 
;				 2. Loads the array with random numbers.
;				 3. Prints the smallest and largest value in the array
;-------------------------------------------------------------------------------------

include C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.inc
includelib C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.lib	

.386
.model flat, stdcall
.stack 4096

.const
			;Defines null to be 0
			 NULL				equ				0
			 sixty				equ				60
.data?
			;declares uninitilized varibles
			_numGrade		dword			?
		
	
.data
	numGrade		dword			20
		

getNumericalGrade proto
printGrade	proto;, numGrade:dword
.code
    main    proc
            
			;invoke	getNumericalGrade
			mov	_numGrade, 2;	eax
			invoke printGrade;, _numGrade
		
			ret 0
main        endp

;***********************************************************************************
;Proc Name  :	getNumericalGrade
;Description:   Gets a random numerical grade between 0 and 100
;Paramaters :	dword
;Return     :	Numerical grade number in eax
;***********************************************************************************
getNumericalGrade	proc
			call	randomize

			;gets a random number between min-max and places it in current array cell
			mov		eax,	101
			call	randomRange
			
			ret 
getNumericalGrade	endp

;***********************************************************************************
;Proc Name  :	printGrade
;Description:   Prints a letter grade, provided a numerical value
;Paramaters :	dword
;Return     :	no return
;***********************************************************************************
printGrade	proc
			
			cmp	numGrade,	60
			JL	PrintF

			cmp	numGrade,	63
			JL	PrintDm

			cmp	numGrade,	67
			JL PrintD

			cmp	numGrade,	69
			JL PrintDp

			cmp	numGrade,	73
			JL PrintCm
			
			cmp	numGrade,	77
			JL PrintC

			cmp	numGrade,	80
			JL PrintCp

			cmp	numGrade,	83
			JL PrintBm

			cmp	numGrade,	87
			JL PrintB

			cmp	numGrade,	90
			JL PrintBp

			cmp	numGrade,	93
			JL PrintAm

			cmp	numGrade,	101
			JL PrintA

PrintF:		mov	edx, 46
			call writeString

			 
PrintDm:	mov	edx, 46
			call writeString
			 
PrintD:		mov	edx, 46
			call writeString
			 
PrintDp:	mov	edx, 46
			call writeString

PrintCm:	mov	edx, 46
			call writeString

PrintC:		mov	edx, 46
			call writeString

PrintCp:	mov	edx, 46
			call writeString

PrintBm:	mov	edx, 46
			call writeString

PrintB:		mov	edx, 46
			call writeString

PrintBp:	mov	edx, 46
			call writeString

PrintAm:	mov	edx, 46
			call writeString

PrintA:		mov	edx, 46
			call writeString

eof:		nop
			ret
printGrade	endp

            end     main