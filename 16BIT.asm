ORG 0000H
;-- The first opcode is burned into ROM address 0000H,
;-- since this is where the 8051 looks for the first 
;-- instruction when it is booted.
;-- We achieve this by the ORG 00H statement in the source program

LJMP MAIN

;R0 and R1 should contain the address of two no.
;location given by R0:- 	MSB of 1st no.
;location given by R0+1:-	LSB of 1st no.
;location given by R1:- 	MSB of 1st no.
;location given by R1+1:-	LSB of 1st no.
;location given by R0+2:- 	CARRY	
;location given by R0+3:-	MSB OF ANS	
;location given by R0+4:- 	LSB OF ANS

;---------------------------------------------------------;
ORG 50H
;this function adds and stores result in appropriate location
LOADA1:
MOV A,#01H
RET


SIGN_EXE:
MOV 68H,60H ;MSB1
ANL 68H,#80H  ;Move 1000 0000 to check for negative
MOV 69H,70H ;MSB2
ANL 69H,#80H  ;Move 1000 0000 to check for negative
MOV A,68H
XRL A,69H    ;XOR   A*B'+B*A'
JNZ LOADA1  ;JUMP IF A IS NOT 0
RET




ADDER_16BIT:
	
	;-- perform the addition/subtraction of two 16-bit no.
	;-- use subroutine written for addition of two 8-bit no.
	;-- remember the no. are given in 2's complement form
	;-- take care when you set carry/borrow.
	;-- store the result at appropriate locations.
	
	;MOV A,R1
	;ADDC A,R2
	;MOV 63H,A
	;MOV A,#0
	;MOV A,R3
	;ADDC A,R4
	;MOV 64H,A
	;JNC RITIZ
	;MOV 62H,#0
	;RITIZ: MOV 62H,#1 	
	
MOV A,61H
ADD A,71H
MOV 64H,A
MOV A,60H
ADDC A,70H
MOV 63H,A
ACALL SIGN_EXE
ADDC A,#00H
ANL A,#01H ;If the Accumulator holds 0C3H (1100001lB), and register 0 holds 55H (01010101B), then the following instruction,
           ;ANL A,R0
           ;leaves 41H (01000001B) in the Accumulator
MOV 62H,A
	
	RET
;-- end of subroutine ADDER_16BIT	

	

INIT:
	; BELOW CODE ADDS AB20H + 65DE = 110FE WITH CARRY FLAG SET
	
	;MOV R1,#020H  ;LOWER BYTE OF OPERAND 1 IN A
	;MOV R2,#0DEH  ;ADD LOWER BYTE OF OPERAND 2 WITH A
	;	MOV R1,A  ;STORES LSB OF RESULT IN R1
	;MOV R3,#65H  ;HIGHER BYTE OF OPERAND 2 IN A
	;MOV R4,#0ABH ; ADD WITH HIGHER BYTE OF OPERAND 1
	;MOV R0,A  ;STORES MSB OF RESULT IN R0
	
	
	;MOV 60H,50H ;MSB1
	;MOV 61H,51H ;LSB1
	;MOV 70H,52H ;MSB2
	;MOV 71H,53H ;LSB2
	RET
;-- end of subroutine INIT



ORG 0200H
MAIN:
	ACALL INIT	    ;-- calling a subroutine INIT
	ACALL ADDER_16BIT   ;-- calling a subroutine ADDER_16BIT
	
HERE:SJMP HERE
END

