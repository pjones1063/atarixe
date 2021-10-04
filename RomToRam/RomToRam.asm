;Move XL OS ROM into RAM
;
;RAMROM--Installs the XL ROM-based
;  OS in RAM at the same address
;  space. This is useful for
;  making small patches to the
;  OS or for experimenting with
;  new design concepts, such as
;  multitasking, window
;  management, etc.
;
;    By Joe Miller.
;
;This version is configured
;as an AUTORUN.SYS file.
;
SOURCE  EQU     $CB             ;zero page usage
DEST    EQU     SOURCE+2
DOSVEC	EQU     $0A
DOSINI	EQU     $0C
START   EQU     $0600           ;START address
OSROM   EQU     $C000           ;address of OS ROM start
OSRAM   EQU     $4000           ;address of ROM destination
NMIEN   EQU     $D40E           ;NMI enable register
PORTB   EQU     $D301           ;memory mgt control latch

        ORG     START
        LDA     #< OSROM
        STA     SOURCE
        STA     DEST            ;initialize copy addrs
        LDA     #> OSROM
        STA     SOURCE+1
        LDA     #> OSRAM
        STA     DEST+1
        LDY     #0
                                 ;Repeat
Pass1   LDA     (SOURCE),Y      ;copy ROM to RAM
        STA     (DEST),Y
        INY
        BNE     Pass1 
        INC     DEST+1
        INC     SOURCE+1
        BEQ     Swap            ;If done
        LDA     SOURCE+1
        CMP     #$D0
        BNE     Pass1           ;skip 2K block at $D000
        LDA     #$D8
        STA     SOURCE+1
        BNE     Pass1           ;Until SOURCE = $0000
Swap    PHP                     ;save processor status
        SEI                     ;disable IRQs
        LDA     NMIEN
        PHA                     ;save NMIEN
        LDA     #0
        STA     NMIEN           ;disable NMIs
        LDA     PORTB
        AND     #$FE            ;turn off ROMs
        STA     PORTB           ;(leaving BASIC unchanged!)
        LDA     #> OSROM
        STA     DEST+1          ;set up block copy
        LDA     #> OSRAM
        STA     SOURCE+1
                                ;Repeat
Pass2   LDA     (SOURCE),Y      ;move RAM OS to proper address
        STA     (DEST),Y
        INY
        BNE     Pass2
        INC     SOURCE+1        ;move to next page
        INC     DEST+1
        BEQ     Enable          ;If complete
        LDA     DEST+1 
        CMP     #$D0
        BNE     Pass2           ;skip block at $D000
        LDA     #$D8
        STA     DEST+1
        BNE     Pass2           ;Until DEST = $000
Enable  PLA
        STA     NMIEN           ;reestablish NMI mask
        PLP                     ;reenable IRQs
 ;      RTS
  	    JMP (DOSVEC)      
        
        run     START
             