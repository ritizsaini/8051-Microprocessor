ORG 00H
;-- code memory location 00h
LJMP MAIN

ORG 50H
;-- code memory location 50h

INIT:
	;-- store the numbers to be added at appropriate locations
	;MOV R0,@30H
	MOV A,#40    ; stored 40 in A
	MOV R0,#67H   ; stored 67 in R0
		LOAD:
		MOV @R0,A  ;move content of A into the memory address held by R0
		DEC A		;A--
		DEC R0		;R0--
		JNZ LOAD
	
	RET
;-- end of subroutine INIT

ADD_40:

	MOV A, #40
	MOV R0, #67H
	MOV 28H, #00  ; store 00 in 28H
	adder:
		MOV 30H, A  ;30H=A=40
		MOV A, 28H   ;A=0
		ADD A, @R0  ;A=0+40
		MOV 28H, A  ;28H=40
		MOV A, 30H  ;A=40
		DEC A
		DEC R0
		JNZ adder
	;-- add the numbers stored from memory location 40h to 67h
	;-- by using subroutine written in homework

	RET
;-- end of subroutine ADD_40
	
TWOS_COMP:
	
	; A=0 and 28H=Sum of numbers
	MOV A, 28H
	CPL A     ; makes compliment of each bit
	ADD A, #01H  ; add 1 to A now whose each bit is now complimented
	MOV 68H, A  
	;-- perform 2's compliment of the resultant sum
	;-- store the checksum byte at memory location 68h
	
	RET
;-- end of subroutine TWOS_COMP

ADD_41:

MOV A,28H
MOV 69H,A
ADD A,68H

;	MOV A, #41
;	MOV R0, #68H
;	MOV 26H,#00
	
;	adder_2:
;		MOV 30H, A
;		MOV A, 26H
;		ADD A, @R0
;		MOV 26H, A
;;		MOV A, 30H
;		DEC A
;		DEC R0
;		JNZ adder_2
;	MOV 29H, 28H
        ;-- add numbers from memory location 40h to 68h
	
	RET
;-- end of subroutine ADD_41

ORG 0200H
;-- code memory location 200h
MAIN:
	ACALL INIT
	ACALL ADD_40
	ACALL TWOS_COMP
	ACALL ADD_41	;verify the result
	HERE:SJMP HERE
END
	
	
	



