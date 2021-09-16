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

iccom	equ $0342
icbadr	equ $0344
icptl	equ $0346
icpth	equ $0347
icblen	equ $0348
icaux1	equ $034A
icaux2	equ $034B

ciov	equ $E456
portb	equ $D301

xebank  equ $4000

b0      equ $E1
b1      equ $E5
b2      equ $E9
b3      equ $ED 

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
