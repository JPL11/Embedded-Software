
#include<P18F4620.inc>
    config OSC = INTIO67
    config WDT = OFF
    config LVP = OFF
    config BOREN = OFF
InB equ 0x0060
InA equ 0x0061
Result equ 0x0062
    ORG 0x0000
START:
    MOVLW 0x0F				    ;initialize ports and ad converter
    MOVWF ADCON1	    
    MOVLW 0xFF		    
    MOVWF TRISA
    MOVLW 0xFF		    
    MOVWF TRISB
    MOVLW 0x0F		    
    MOVWF TRISD
    
    MOVLW 0x00		    
    MOVWF TRISC
    MOVLW 0x00		    
    MOVWF TRISE
    
MAIN_LOOP:

BTFSC PORTD,2				    ;bit skip condition
GOTO  T_BCD
GOTO  PORTDEQ_0

PORTDEQ_0:				    ;set conditions for selecting operation
   BTFSC PORTD,1
   GOTO PORTDEQ_01
   GOTO PORTDEQ_00

PORTDEQ_01:
    BTFSC PORTD,0
    GOTO T_XOR
    GOTO T_OR
    
PORTDEQ_00:
    BTFSC PORTD,0
    GOTO T_ADD
    GOTO T_COMP
					    ; "T_<operation>" is the format being used for operation locations
					    ; each has the specific bits set for the RGB lights 
T_COMP:
    BCF PORTD,4
    BCF PORTD,5
    BCF PORTD,6
    CALL SUBROUTINE_COMP
    GOTO MAIN_LOOP
T_ADD:    
    BSF PORTD,4
    BCF PORTD,5
    BCF PORTD,6
    CALL SUBROUTINE_ADD
    GOTO MAIN_LOOP
T_OR:
    BCF PORTD,4
    BSF PORTD,5
    BCF PORTD,6
    CALL SUBROUTINE_OR
    GOTO MAIN_LOOP
T_XOR:
    BSF PORTD,4
    BSF PORTD,5
    BCF PORTD,6
    CALL SUBROUTINE_XOR
    GOTO MAIN_LOOP
T_BCD:    
    BCF PORTD,4
    BCF PORTD,5
    BSF PORTD,6
    CALL SUBROUTINE_BCD
    GOTO MAIN_LOOP
    
SUBROUTINE_COMP:
MOVF PORTA,W				    ;move contents of PORTA to W
MOVWF InB				    ;move working reg to InB
COMF InB,0				    ;complement InB and store in working reg
ANDLW 0x0F
MOVWF Result				    ;move working reg to Result
MOVFF Result,PORTC			    ;copy Result to PORTC
BZ LABEL1
BCF PORTE,1
GOTO LABEL2
LABEL1:
    BSF PORTE,1
LABEL2:
RETURN
    
SUBROUTINE_ADD:
MOVF PORTA,W				    ;move contents of PORTA to W
ANDLW 0x0F;
MOVWF InA				    ;move working reg to InB
    
MOVF PORTB,W
ANDLW 0x0F				    ;mask input
MOVWF InB
MOVF InA,W
ADDWF InB, W				    ;add InA and InB
MOVWF Result				    ;move working reg to Result
MOVFF Result,PORTC			    ;copy Result to PORTC
BZ LABEL3
BCF PORTE,1
GOTO LABEL4
LABEL3:
    BSF PORTE,1
LABEL4:
RETURN
    
SUBROUTINE_OR:  
MOVF PORTA,W				    ;move contents of PORTA to W
ANDLW 0x0F;
MOVWF InA				    ;move working reg to InB
    
MOVF PORTB,W
ANDLW 0x0F
MOVWF InB
MOVF InA,W
IORWF InB, W				    ;OR InA and InB
MOVWF Result				    ;move working reg to Result
MOVFF Result,PORTC			    ;copy Result to PORTC
BZ LABEL5
BCF PORTE,1
GOTO LABEL6
LABEL5:
    BSF PORTE,1
LABEL6:
RETURN
    
SUBROUTINE_XOR:
MOVF PORTA,W				    ;move contents of PORTA to W
ANDLW 0x0F;
MOVWF InA				    ;move working reg to InB
    
MOVF PORTB,W
ANDLW 0x0F
MOVWF InB
MOVF InA,W
XORWF InB, W				    ;OR InA and InB
MOVWF Result				    ;move working reg to Result
MOVFF Result,PORTC			    ;copy Result to PORTC
BZ LABEL7
BCF PORTE,1
GOTO LABEL8
LABEL7:
    BSF PORTE,1
LABEL8:
RETURN

SUBROUTINE_BCD:
MOVF PORTA,W				    ;move contents of PORTA to W
ANDLW 0x0F;
MOVWF InA				    ;move working reg to InB
MOVLW 0x0A
CPFSLT InA, W				    ; if InA is less than W, skip next line
GOTO CONVERT
GOTO FINISH    
CONVERT:
MOVF InA,W
ADDLW 0x06				    ; BCD, if 10 or greater convert
MOVWF InA
FINISH:
MOVFF InA,PORTC

BZ LABEL9
BCF PORTE,1
GOTO LABEL10
LABEL9:
    BSF PORTE,1
LABEL10:
RETURN

GOTO MAIN_LOOP
    
END
