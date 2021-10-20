;MEMTEST - 130EX Memory Bank Test

;
;  This program is free software; you can redistribute it and/or modify
;  it under the terms of the GNU General Public License as published by
;  the Free Software Foundation; either version 2 of the License, or
;  (at your option) any later version.
;
;  This program is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  along with this program; if not, write to the Free Software
;  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;

	icl 	'sym.asm'	
		
	org $3400
	
Start

	lda #01
	sta CRSINH
	
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
	lda #00
	sta CRSINH
	jmp (DOSVEC)
.endp
	
bank .ds 1 
	
	icl 'printf.asm'  
	run Start
	