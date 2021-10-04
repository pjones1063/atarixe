;MEMTEST - 130EX Memory Bank Test


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
	.byte 'Read  > bank 0              ',155,0
 	lda #b0
	jsr readbank

 	jsr printf
 	.byte 'Read  > bank 1              ',155,0
	lda #b1
	jsr readbank
	
	jsr printf	
	.byte 'Read  > bank 2               ',155,0
	lda #b2
	jsr readbank

	jsr printf
	.byte 'Read  > bank 3               ',155,0
	lda #b3
 	jsr readbank

	jsr printf
	.byte 28,155
	.byte 155,155,'All Banks Tested -  Passed ',155,155,155,0

	jmp Exit
	
.proc loadbank
	sta bank
	sta portb
	lda #>xebank
	sta ix+2
	ldx #$00
	stx ix+1	
lp1	lda bank		
	ix: sta xebank,x
	inx
	bne ix
	inc ix+2
	lda ix+2
	cmp #$80
	bne lp1
	rts
.endp

.proc readbank
	sta bank				
	sta portb
	lda #>xebank
	sta iy+2
	ldx #$00
	stx iy+1
lp2	
	jsr Printf
	.byte '  %x -> Testing Block - %x00',28,155,0
	.word bank 
	.word iy+2
	lda bank
iy: cmp xebank,x
	bne ExitError
	inx
	bne iy 
	inc iy+2
	lda iy+2
	cmp #$80
	bne lp2
	rts
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
	