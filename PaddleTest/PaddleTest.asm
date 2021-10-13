;Paddle test 
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

blue	equ $a8	
green	equ $b8	
yellow	equ $ff
black   equ $00
	
		org $2000

start
	lda #black     
	sta color2
	
	jsr printf
	.byte 125,155,'XE Paddle Tester',0
	
	lda #>pmb     		;setup pmg
	sta PMBASE
	lda #46
	sta SDMCTL
	lda #03
	sta GRACTL
	
	ldy #$80			;clear out pmg buffer
	lda #00	
cl0	sta	p0,y
 	sta	p1,y
	dey
	bne cl0
	
	ldy #8				; set the players
	ldx x0
lp0	lda player0,y
	sta p0,x
	dex
	dey
	bne lp0

	ldy #8
	ldx x1
lp1	lda player1,y
	sta p1,x
	dex
	dey
	bne lp1
 
 
loop					
	ldx #blue				; check paddle 0
	lda PTRIG0
	bne lp2
 	ldx #yellow
lp2	stx c0
    stx PCOLR0
	ldy PADDL0
	jsr checkPaddle
	sty y0
	sty HPOSP0
	
	ldx #green				; paddle 1
	lda PTRIG1
	bne lp3
 	ldx #yellow
lp3	stx c1
    stx PCOLR1     
	ldy PADDL1
	jsr checkPaddle
	sty y1
    sty HPOSP1
	
	jsr ticktock			; take a little break
	jmp loop				; main loop


.proc checkPaddle  
st4	cpy  #200			;test min / max
	bcc xy1
	ldy #200	 	
xy1	cpy #47
	bcs xy2
	ldy #47	
xy2	rts
.endp


.proc ticktock
	lda #00
	sta clock
tok	lda clock
	cmp #00
	beq tok
	rts	
.endp
		

		icl 'printf.asm'

	
player0
	.byte $00,$00,$18,$3C,$7E,$DB,$81,$00,$00
x0	.byte $30
y0	.byte $00
c0	.byte $A8
player1
	.byte $00,$00,$99,$BD,$FF,$BD,$99,$00,$00
x1	.byte $50
y1	.byte $00
c1	.byte $B8
	 
	 
	 org $4000	
pmb	.ds $0200
p0	.ds $0080
p1	.ds $0080
p2	.ds $0080
p3	.ds $0080

		run start
	
	