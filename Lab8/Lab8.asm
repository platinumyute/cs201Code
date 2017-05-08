;------------------------------------------------------------------------------------------------------------
; Zailabdeen, Hoon: lab 8
;
; Description:	 1. This program will print a 4x4 matrix of letters.
;		      	 2. Each letter will be chosen at random based on a probability.
;------------------------------------------------------------------------------------------------------------

include C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.inc
includelib C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.lib	

.386
.model flat, stdcall
.stack 4096

.const
		NULL			equ		0
		ZERO			equ		0
		CDIST			EQU		3
		VDIST			EQU		7
		TEN				EQU		10
		NUM_VOWELS		EQU		5
		NUM_CONSONANTS	EQU		20
		MAX_PER_LINE	EQU		4
		MATRIX_SIZE		EQU		16

.data
		vowels			byte	'A', 'E', 'I', 'O', 'U'
		consonants		byte	'B', 'C', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'V', 'W', 'X', 'Y', 'Z'  
		
;macro to prints a new line
mNewline macro
	call crlf
endm

;print the character in al register
mPrintLetter macro pChar: REQ 
	mov al, pChar
	call writeChar

endm

;print a space
mPrintSpace macro
	mov al, ' '
	call writeChar
endm

;prototypes
getLetter proto arVowels: PTR BYTE, ArConsonants: PTR BYTE
getVowel proto  arVowels: PTR BYTE
getConsonant proto ArConsonants: PTR BYTE

.code
main    proc
		call randomize
		mov esi, ZERO
		mov ecx, MATRIX_SIZE
		.while(ecx > ZERO)
			;gets and prints a letter
			invoke getLetter, ADDR vowels, ADDR consonants 
			mPrintLetter al
			mPrintSpace
			dec ecx
			inc esi
			
			;moves to a new line if MAX_PER_LINE letters is printed
			.if(esi == MAX_PER_LINE)
				mNewline
				mov esi, ZERO
			.endif
		.endw
		ret 0
main    endp


;***********************************************************************************
;Proc Name  :	getLetter
;Description:   retrives and return a letter based on distribution ratio
;Paramaters :	pointer to BYTE
;Return     :	letter in al register
;***********************************************************************************
getLetter proc, arVowels: PTR BYTE, ArConsonants: PTR BYTE
		mov eax, TEN
		call randomRange
		inc eax
		.if(eax <= CDIST)
			invoke getVowel, arVowels
		.else
			invoke getConsonant, ArConsonants
		.endif
		ret
getLetter endp

;***********************************************************************************
;Proc Name  :	getVowel
;Description:   retrives and return a vowel letter from the consonants array
;Paramaters :	pointer to BYTE
;Return     :	vowel in al register
;***********************************************************************************
getVowel proc uses ebx esi, arVowels: PTR BYTE
		mov eax, NUM_VOWELS
		inc eax
		call randomRange
		
		mov esi, arVowels
		mov ebx, TYPE vowels
		mul ebx
		add esi, eax
		
		mov al, [esi]

		ret
getVowel endp

;***********************************************************************************
;Proc Name  :	getConsonant
;Description:   retrives and return a consonant letter from the consonants array
;Paramaters :	pointer to BYTE
;Return     :	consonant in al register
;***********************************************************************************
getConsonant proc uses ebx esi, ArConsonants: PTR BYTE
		mov eax, NUM_CONSONANTS
		inc eax
		call randomRange
		
		mov esi, ArConsonants
		mov ebx, TYPE consonants
		mul ebx
		add esi, eax
	
		mov al, [esi]
		
		ret
getConsonant endp

end     main
