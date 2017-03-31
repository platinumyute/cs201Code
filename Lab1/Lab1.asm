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
	;Define the names of the days of the week to be string constants 
    sunday				equ				"sunday"		, NULL		
    monday				equ				"monday"		, NULL		
    tuesday				equ				"tuesday"		, NULL			
    wednesday			equ				"wednesday"		, NULL	
    thursday			equ				"thursday"		, NULL	
    friday				equ				"friday"		, NULL
    saturday			equ				"saturday"		, NULL


.data?
	;declares uninitilized varibles
    _D					dword	         ?
    _Y					dword            ?			

.data
    ; declares an array 'days' with days of the week constants
	days				byte			sunday, monday, tuesday, wednesday, thursday, friday, saturday
	
	
	;declare string variables with default values
	msg_enterValue		byte			"Please enter a value: ", NULL
	msg_output			byte			"The expression with A = 5, B = 7, C = 12 and D = ", NULL
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


			;moves _A  to eax register, adds _B to eax (_A + _B), eax to eax (_A + _B) * 2
			mov			eax,			_A
			add			eax,			_B	
			add			eax,			eax
			

			;subtracts	_C from eax twice
			sub			eax,			_C	
			sub			eax,			_C
		

			;subtracts  _D from eax trice (three times)
			sub			eax,			_D
			sub			eax,			_D
			sub			eax,			_D
			

			;moves value in eax to _Y
			mov			_Y,				eax


			;
			mov			edx,			offset		 msg_output
			call		writeString
			
			mov			eax,			_D
			call		writeInt


			mov			edx,			offset		 msg_output_Y
			call		writeString
			
			mov			eax,			_Y
			call		writeInt

			call		crlf


			ret 0

main        endp
            end     main