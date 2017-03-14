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
	NULL				equ				0;
	
	sunday				equ				1;
    monday				equ				2;
    tuesday				equ				3;
    wednesday			equ				4;
    thursday			equ				5;
    friday				equ				6;
	saturday			equ				7;


.data?
	_D					dword			?
	_Y					dword			?


.data
    days				byte			sunday, monday, tuesday, wednesday, thursday, friday, saturday
	
	msg_enterValue		byte			"Please enter a value: ", NULL
	msg_output			byte			"The expression with A = 5, B = 7, C = 12 and D = ", NULL
	msg_output_Y		byte			" is Y = ", NULL
   
	_A					dword			5 
	_B					dword			7
	_C					dword			12


.code
    main    proc
            
		
			mov			edx,			offset		msg_enterValue
			call		writeString
			call		readInt
			mov			_D,				eax


			mov			eax,			_A
			add			eax,			_B
			add			eax,			eax
		
			
			sub			eax,			_C
			sub			eax,			_C
		

			sub			eax,			_D
			sub			eax,			_D 
			sub			eax,			_D
			
			mov			_Y,				eax


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