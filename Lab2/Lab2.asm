;------------------------------------------------------------------------------------
; Zailabdeen, Hoon, Choi : lab 2
;
; Description:	this program computes an arithmetic equation using four variables A,B,C,D
;				with D being entered by user.
;-------------------------------------------------------------------------------------

include C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.inc
includelib C:\Users\nathan\Documents\ASMIO\ASMIO\asm32.lib	

.386
.model flat, stdcall
.stack 4096


.const
	;Defines null to be 0
    NULL				equ				0
	
	array_size			equ				25
	array_rand_max		equ				40
	array_rand_min		equ				1

.data?
	;declares uninitilized varibles
    _Y					dword           ?			
	_A					dword			?
	_B					dword			?
	_randVal			dword			?
	_array				dword			array_size dup(?)
	
.data

	;declare string variables with default values
	msg_enterValueA		byte			"Please enter a value: ",	NULL
	msg_enterValueB		byte			"Please enter a value: ",	NULL
	msg_outputRandom	byte			"The random number from ",	NULL
	msg_outputTo		byte			" to ",						NULL
	msg_outputIs		byte			" is :",					NULL
	


	
	
.code
    main    proc
            
			;prompts user to enter value, collects the value and stores it in '_A'
			mov			edx,			offset		msg_enterValueA
			call		writeString
			call		readInt
			mov			_A,				eax

			 
			;prompts user to enter value, collects the value and stores it in '_B'
			mov			edx,			offset		msg_enterValueB
			call		writeString
			call		readInt
			mov			_B,				eax

			sub			eax,			_A
			add			eax,			 1
			 
			call		randomize
			call		RandomRange
			add			eax,			_A		
			mov			_randVal,		eax


			;prints random num between values user entered to screen
			mov			edx,			offset		 msg_outputRandom
			call		writeString
			mov			eax,			_A
			call		writeInt
			mov			edx,			offset		 msg_outputTo
			call		writeString
			mov			eax,			_B
			call		writeInt
			mov			edx,			offset		 msg_outputIs
			call		writeString
			mov			eax,			_randVal
			call		writeInt
		
			;prints 2 new line
			call		crlf
			call		crlf

			


			;part two
			call		randomize
			mov			ecx,			array_size
			
		
			;set counter
			mov			ebx,								0;
			
			;loop counter
			mov			ecx,								array_size
			
			call		randomize
			mov			esi,								offset _A 
			

fill:		mov			eax,								array_rand_max
			sub			eax,								array_rand_min
			add			eax,								1			 
			call		randomRange
			add			eax,								array_rand_min		
			mov			_randVal,							eax
		
			
			;load into array using ebx as index
			mov			eax,								_randVal
			mov edx, 1
			mov			[esi + (SIZEOF dword) * ebx],		edx
			add			ebx,								1
			loop		fill
			

			;reset counters
			mov			ebx,								0
			mov			ecx,								array_size
			mov			edx,								0
			

sum:		mov			eax,								[esi + (SIZEOF dword) * ebx]
			add			edx,								eax
			add			ebx,								1
			loop		sum
			
			mov			eax,								edx
			call		writeInt

			ret 0

main        endp
            end     main