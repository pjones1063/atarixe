	icl 	'printf_sym.asm'	
		
	org $3400
	
Start
	jsr printf
	.byte 125,155,'130 XE Extended Memory Test ',155, 155, 155,0
	
	jsr printf
	.byte 'Write > bank 0 ',155,0
	lda #b0
    jsr loadbank
 
 	jsr printf
 	.byte 'Write > bank 1 ',155,0
	lda #b1
	jsr loadbank

	jsr printf
	.byte 'Write > bank 2 ',155,0
	lda #b2
	jsr loadbank

	sta bank	
	jsr printf
	.byte 'Write > bank 3 ',155,155,0
	lda #b3
	jsr loadbank
	
// --

	jsr printf
	.byte 'Read  > bank 0                 ',155,0
 	lda #b0
    jsr readbank

 	jsr printf
 	.byte 'Read  > bank 1                  ',155,0
	lda #b1
 	jsr readbank
	
	jsr printf	
	.byte 'Read  > bank 2                  ',155,0
	lda #b2
 	jsr readbank

	jsr printf
	.byte 'Read  > bank 3                  ',155,0
	lda #b3
 	jsr readbank

	jsr printf
	.byte '                                ',28,155
	.byte 155,155,'All Banks Tested -  Passed ',155,155,155,0

	jmp Exit
	
.proc loadbank
	STA bank
	STA portb
	LDA #>xebank
	STA ix+2
	LDX #$00
	STX ix+1	
lp1	LDA bank		    
ix: STA xebank,x
    INX
    BNE ix
	INC ix+2
	LDA ix+2
	CMP #$80
	BNE lp1
	RTS
.endp

.proc readbank
	STA bank		    		    
	STA portb
	LDA #>xebank
	STA iy+2
	LDX #$00
	STX iy+1
lp2	
	jsr Printf
	.byte '  %x -> Testing Block - %x00',28,155,0
	.word bank 
	.word iy+2
	LDA bank
iy: CMP xebank,x
    BNE ExitError
    INX    
    BNE iy 
	INC iy+2
	LDA iy+2
	CMP #$80
	BNE lp2
	RTS
.endp	

ExitError:
	jsr Printf
	.byte 155,155,155,'error in memory',155,0	
.proc Exit
	jsr Printf
	.byte 155,'Press a key to quit',155,0
	jsr Input1
	jmp (DOSVEC)
.endp
	
bank .ds 1 
	
    icl 'printf.asm'      
	
	run Start
	