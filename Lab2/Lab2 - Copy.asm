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
	

.data
	;declares uninitilized varibles
	_max				dword							20
	_min				dword							10
	_A					dword							1,2,3,4,5,6,7,8,9,10
	_randVal			dword							0
	
.code
    main    proc
            			
			call		writeInt
			call		crlf
			call		crlf

				
			;set counter
			mov			ebx,								0;
			
			;loop counter
			mov			ecx,								10
			
			call		randomize
			mov			esi,								offset _A 
			

fill:		mov			eax,								_max
			sub			eax,								_min
			add			eax,								1			 
			call		randomRange
			add			eax,								_min		
			mov			_randVal,							eax

			;load into array using ebx as index
			mov			eax,								_randVal
			mov			[esi + (SIZEOF dword) * ebx],		eax
			add			ebx,								1
			loop		fill
			

			mov			ebx,								0
			mov			ecx,								10
			
print:		mov			eax,								[esi + (SIZEOF dword) * ebx]
			call		writeInt
			call		crlf
			add			ebx,								1
			loop		print
		

			ret 0

main        endp


		    end     main