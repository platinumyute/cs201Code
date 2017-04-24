;------------------------------------------------------------------------------------------------------------
; Zailabdeen, Hoon, Choi : lab 6
;
; Description:	 1. This program will get an input from the user between 10-100.
;				 2. Print all prime numbers from 2 to user value.
;				 3. Align output.
;------------------------------------------------------------------------------------------------------------

include C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.inc
includelib C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.lib	

.386
.model flat, stdcall
.stack 4096

.const
		NULL			equ				0
		
		;boolean constants
		TRUE			equ				1
		FALSE			equ				0
		
		;numerical constants
		ZERO			equ				0
		ONE				equ				1
		TWO				equ				2
		FIVE			equ				5
		TEN				equ				10
		
.data?
		_userInput 		dword 			?

.data
		inptMsg		byte	"please enter number from 10-100: ", NULL
		outMsg			byte	"The primes from 2 - ", NULL
		outMsg2			byte	" are: ", NULL

.code

;*****prototypes*****
getUserInput proto
isPrime proto x:DWORD
printAllPrimes proto n:DWORD
printSpace proto n:DWORD
alignSpace proto prevNum:DWORD, maxSpaces:DWORD

main    proc		
		
		invoke getUserInput
		mov _userInput, eax

		mov edx, OFFSET outMsg
		call writeString
		mov eax, _userInput
		call writeDec
		mov edx, OFFSET outMsg2
		call writeString
		call crlf
		invoke printAllPrimes, _userInput
		
		ret 0
main    endp

;***********************************************************************************
;Proc Name  :	getUserInput
;Description:   Gets user input. An integer from 10-100 
;Paramaters :	no paramaters
;Return     :	returns entered value in eax
;***********************************************************************************
getUserInput proc uses edx
		mov edx, OFFSET inptMsg
		call writeString
		call ReadInt
		ret
getUserInput endp

;***********************************************************************************
;Proc Name  :	isPrime
;Description:   Gets a random numerical grade between 0 and 100
;Paramaters :	DWORD 
;Return     :	returns bool value, TRUE or FALSE
;***********************************************************************************
isPrime proc uses eax ecx esi, x:DWORD
	mov esi, x
	mov ecx, TWO
	mov edx, ONE
	
	.WHILE(ecx < esi) && (edx != ZERO)
		mov eax, esi
		mov edx, ZERO
		div ecx
		inc ecx
	.ENDW
	
	.IF(edx == ZERO)
		mov edx, FALSE
	.ELSE
		mov edx, TRUE
	.ENDIF
	ret
isPrime	endp

;***********************************************************************************
;Proc Name  :	printAllPrimes
;Description:   Print all prime numbers from 2 to n
;Paramaters :	DWORD
;Return     :	No Return
;***********************************************************************************
printAllPrimes proc uses eax ebx ecx edx, n:DWORD 
	
	mov ebx, n		;user input value
	mov ecx, TWO	;loop counter
	mov esi, ZERO	;print counter
	.WHILE (ecx <= ebx)	
		invoke isPrime, ecx
		.IF( edx == TRUE)
			mov eax, ecx
			call writeDec
			inc esi

			invoke alignSpace, eax, FIVE
			
			.IF(esi == TEN)
				call crlf
				mov esi, ZERO
			.ENDIF
	
		.ENDIF
		inc ecx
	.ENDW
	ret
printAllPrimes endp

;***********************************************************************************
;Proc Name  :	printSpace
;Description:   Prints 'n' amounts of spaces to console
;Paramaters :	DWORD
;Return     :	No Return
;***********************************************************************************
printSpace proc uses ecx eax, n:DWORD
	mov ecx, n
	mov al, ' ';
	.WHILE(ecx > ZERO)
		call writeChar
		dec ecx
	.ENDW
	ret
printSpace endp

;***********************************************************************************
;Proc Name  :	alignSpace
;Description:   Prints required amount of spaces to align numbers
;Paramaters :	DWORD, DWORD
;Return     :	No Return
;***********************************************************************************
alignSpace proc uses eax esi edx ecx, prevNum:DWORD, maxSpaces:DWORD
	mov eax, prevNum
	mov esi, maxSpaces
	mov edx, ZERO
	mov ecx, TEN
	div ecx

	.IF(eax > ZERO)
		dec esi
	.ENDIF
	
	;prints spaces
	invoke printSpace, esi
	ret
alignSpace endp

end     main
