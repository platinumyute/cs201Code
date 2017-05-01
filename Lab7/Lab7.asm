;------------------------------------------------------------------------------------------------------------
; Zailabdeen, Hoon: lab 7
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
		NULL			equ		0
		MAX_CHARS		equ		5
		
.data?
		_dstn			byte	MAX_CHARS + 1 dup(?),		NULL

.data
		_msgInputStr	byte	"please enter string: ",	NULL
		_userInput 		byte 	MAX_CHARS + 1 dup(?),		NULL
		_msgCopiedChars	byte	"Number of chars copied: ", NULL
		_msgNewStr		byte	"The new string is: ",		NULL

		
;procedure prototypes
readInput proto strOutput:PTR BYTE
numOfChars proto mystr:PTR BYTE
reverseString proto src:PTR BYTE, dstn:PTR BYTE, strlen:DWORD

;macro to print two lines
mNewline macro
	call crlf
	call crlf
endm

.code
main    proc
		;prompt user to input string
		mov edx, offset _msgInputStr
		call writeString
		
		;collects string up to MAX_CHARS in length
		invoke readInput, ADDR _userInput
		
		;gets the number of characters in the string, and puts it in ecx
		invoke numOfChars, ADDR _userInput

		;reverses the string, and prints it
		invoke reverseString, ADDR _userInput, ADDR _dstn, ecx
	
		ret 0
main    endp


;***********************************************************************************
;Proc Name  :	readInput
;Description:   Reads a string up to MAX_CHARS in length
;Paramaters :	pointer to BYTE
;Return     :	no return
;***********************************************************************************
readInput proc uses ecx edx, strOutput: PTR BYTE
		;reads string up to MAX_CHARS into strOutput	
		mov ecx, MAX_CHARS
		mov edx, strOutput
		call readString
		ret
readInput endp


;***********************************************************************************
;Proc Name  :	numOfChars
;Description:   Gets the number of characters in a given string
;Paramaters :	pointer to BYTE
;Return     :	number of characters in ecx
;***********************************************************************************
numOfChars proc uses eax esi, mystr: PTR BYTE
		mov ecx, -2;
		mov esi, mystr
		mov eax, [esi]
		
		;loops until NULL character is found
		;keeping a count for num of characters
		.while(eax != NULL)
			add esi, type byte			
			mov eax, [esi]
			inc ecx
		.endw
		ret
numOfChars endp


;***********************************************************************************
;Proc Name  :	reverseString
;Description:   Reverses a string
;				copies it into another string
;				then prints the reversed string, 
;				along with the num of copied characters.
;Paramaters :	pointer to BYTE, pointer to BYTE, DWORD
;Return     :	no return
;***********************************************************************************
reverseString proc uses eax ebx ecx edx edi esi, src:ptr byte, dstn:ptr byte, numChars: dword
		mov ecx, numChars	;string length
		mov esi, src		;source to copy from
		mov edi, dstn		;destination to copy to
		mov ebx, 0			;will keep track of copied characters
		
		;sets esi to last element
		mov eax, type byte
		mul ecx
		sub eax, type byte
		add esi, eax

		;esi has pointer to last element
		;edi has pointer to first element
		;loop copies esi into edi via last position to first
		.while(ecx > 0)
			mov	al, [esi]
			mov [edi], al
			
			sub	esi, type byte
			add edi, type byte 
			dec ecx
			inc ebx
		.endw

		mov edx, NULL
		mov [edi], edx

		;print number of copied chars
		mov edx, OFFSET _msgCopiedChars
		call writeString
		mov eax, ebx
		call writeDec

		mNewline

		;print new reversed string
		mov edx, OFFSET _msgNewStr
		call writeString
		mov edx, OFFSET _dstn
		call writeString
		ret
reverseString endp

end     main
