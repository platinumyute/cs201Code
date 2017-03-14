;------------------------------------------------------------------------------------
; Zailabdeen, Hoon, Choi : lab 1
;
; Description: this program prints a string,integer and hexadecimal to the screen
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
    _D					dword			?
    _Y					dword           ?			
	_m5B				dword			?
	_m12C				dword			?
	_m31D				dword			?


.data
	
	;declare string variables with default values
	msg_enterValue		byte			"Please enter a value: ", NULL
	msg_output			byte			"Y(A,B,C, D) = ", NULL
	msg_output_Y		byte			" is Y = ", NULL
	
	;Declare variables with default values
	_A					dword			5
	_B					dword			7	
	_C					dword			12	


.code
    main    proc
            
			;prompts user to enter value, collects the value and stores it in '_D'
			mov			edx,			offset		msg_enterValue
			call		writeString
			call		readInt
			mov			_D,				eax

			;moves _B to eax, multiplies it by 5, and stores it in _m5B
			mov			eax,			_B
			imul		eax,			5
			mov			_m5B,			eax			
			
			
			;moves _A to eax, subtracts _m5B, multiplies it by 21, and moves result to _Y
			mov			eax,			_A
			sub			eax,			_m5B
			imul		eax,			21
			mov			_Y,				eax
			

			;moves _C to eax, multiplies it by 12, add _Y, and moves result to _Y
			mov			eax,			_C
			imul		eax,			12
			add			eax,			_Y
			mov			_Y,				eax
			

			;moves _D to eax, multiples it by 31
			mov			eax,			_D
			imul		eax,			31


			;subtracts eax from _Y
			sub			_Y,				eax
			

			;moves output message to edx, and prints it to screen
			mov			edx,			offset		msg_output
			call		writeString
			
			mov			eax,			_Y
			call		writeInt

			call		crlf


			ret 0

main        endp
            end     main