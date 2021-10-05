;JoyStick test 
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
    
    icl 	'printf_sym.asm'	
    
	org $2000

start
    lda #$00
    sta color2
 	jsr printf
	.byte 125,155,'XE Joystick Tester',0
    
	lda #>pmb 
	sta PMBASE
	lda #46
	sta SDMCTL
	lda #03
	sta GRACTL
	
	ldy #$80
	lda #00
cl0	sta	p0,y
 	sta	p1,y
	dey
	bne cl0

loop

	ldy #8
	ldx x0
lp0	lda player,y
	sta p0,x
	dex
	dey
	bne lp0
	lda y0
	sta HPOSP0
	lda c0
	sta PCOLR0	

	ldy #8
	ldx x1
lp1	lda player,y
	sta p1,x
	dex
	dey
	bne lp1
	lda y1
	sta HPOSP1
	lda c1
	sta PCOLR1

    ldx #$A8
	lda STRIG0
	bne lp2
 	ldx #$FF
lp2	stx c0
	lda STICK0
	ldy y0
	ldx x0
	jsr checkStick
	sty y0
	stx x0

    ldx #$B8
	lda STRIG1
	bne lp3
 	ldx #$FF
lp3	stx c1
	lda STICK1
	ldy y1
	ldx x1
	jsr checkStick
	sty y1
	stx x1
	
	jsr ticktock
	
	jmp loop


.proc checkStick
	cmp #7
	bne st1
	iny  
st1 cmp #11
	bne st2
	dey 
st2 cmp #14
    bne st3
    dex 
st3 cmp #13
	bne st4
	inx  
st4	 		
	cpy  #200
	bcc xy1
	ldy #200	 	
xy1 cpy #47
	bcs xy2
	ldy #47	
xy2 cpx #115
    bcc xy3
    ldx #115
xy3 cpx #23
    bcs xy4
    ldx #23  
xy4
	rts
.endp

.proc ticktock
    lda #00
 	sta clock
tok lda clock
	cmp #00
	beq tok
    rts	
.endp
		
	icl 'printf.asm'
	
player .byte $00,$00,$99,$BD,$FF,$BD,$99,$00,$00
x0  .byte $30
y0  .byte $90
c0  .byte $A8
x1  .byte $30
y1  .byte $60
c1  .byte $B8
	 
	 org $4000	
pmb	 .ds $0200
p0   .ds $0080
p1   .ds $0080
p2   .ds $0080
p3   .ds $0080

	run start
	
	