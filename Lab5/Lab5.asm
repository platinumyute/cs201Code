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

		
.data?
		_userInput		DWORD			?
	
.data
		msg				BYTE			"hello ", NULL
		_array			dword			2,4,3,5,6
		_aSize			dword			5
		max dword 10
		min dword 3
getUserInput proto
getFactorial proto  num:DWORD
doubleArray proto array:PTR DWORD, arSize:DWORD

printArray proto array:PTR DWORD, arSize:DWORD
.code
main    proc
	
		ret 0
	
main    endp

getUserInput proc uses edx

		mov edx, offset msg
		call writeString
		call ReadInt
		ret
getUserInput endp

getFactorial proc uses ecx, num:dword
		mov eax, num
		mov ecx, num
		dec ecx

multiply:
		imul ecx
		loop multiply
		ret 
getFactorial  endp

doubleArray proc array:PTR DWORD, arSize:DWORD
		mov esi, array
		mov ecx, arSize

next:	mov	eax, [esi]
		add eax, eax
		mov [esi], eax
		add esi, type array
		loop next

		
		ret
doubleArray endp

printArray proc array:PTR DWORD, arSize:DWORD
		mov esi, array
		mov ecx, arSize
doPrint:
		mov eax, [esi]
		call writeInt
		call crlf
		add esi, type array
		loop doPrint
		ret
printArray endp

end     main