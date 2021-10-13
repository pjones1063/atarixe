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

DDEVIC	equ $0300
DUNIT	equ $0301
DCOMND	equ $0302
DSTATS	equ $0303
DBUFLO	equ $0304
DBUFHI	equ $0305
DTIMLO	equ $0306
DUNUSE	equ $0307
DBYTLO	equ $0308
DBYTHI	equ $0309
DAUX1	equ $030A
DAUX2	equ $030B
NOCKSM	equ $003C

RAMTOP  equ $006A
PADDL0  equ $0270
PADDL1  equ $0271
PADDL2  equ $0272
PADDL3  equ $0273
STICK0  equ $0278
STICK1  equ $0279
PTRIG0  equ $027C
PTRIG1  equ $027D
PTRIG2  equ $027E
PTRIG3  equ $027D
STRIG0  equ $0284
STRIG1  equ $0285
SDMCTL  equ $022F
PCOLR0  equ $02C0
PCOLR1  equ $02C1
SIZEP0	equ $D008
GRACTL  equ $D01D
HPOSP0  equ $D000
HPOSP1  equ $D001 
PMBASE  equ $D407
CLOCK   equ $0014
COLOR0  equ $02C4
COLOR1  equ $02C5
COLOR2  equ $02C6
COLOR3  equ $02C7
COLOR4  equ $02C8

iccom	equ $0342
icbadr	equ $0344
icptl	equ $0346
icpth	equ $0347
icblen	equ $0348
icaux1	equ $034A
icaux2	equ $034B

ciov	equ $E456
portb	equ $D301

dday    equ $077B
dmth    equ $077C
dyer    equ $077D
dhrs    equ $077E
dmin    equ $077F
dsec    equ $0780

DOSVEC	equ $0A
DOSINI	equ $0C

SIOV	equ $E459

comfnam	equ $21
comtab	equ $0A

	org $80
Temp1			.ds 2
Temp2			.ds 2
Temp3			.ds 2
Temp4			.ds 2
LeadingZeroFlag	.ds 1
ArgIndex		.ds 1
FieldWidth		.ds 1
StringIndex		.ds 1
	

	
.macro ldyx
	ldy #< :1
	ldx #> :1
.endm

.macro styx
	sty :1
	stx :1+1
.endm

.macro ldax
	lda #< :1
	ldx #> :1
.endm

.macro stax
 	sta :1
 	stx :1+1
.endm
