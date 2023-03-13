
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
    MOVLW 0x0F		    
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
MOVF PORTA,W				;move contents of PORTA to W
ANDLW 0x0F;
MOVWF InA				;move working reg to InB
    
MOVF PORTB,W
ANDLW 0x0F				;mask input
MOVWF InB
MOVF InA,W
XORWF InB, W				;XOR InA and InB
MOVWF Result				;move working reg to Result
MOVFF Result,PORTC			;copy Result to PORTC
BZ LABEL1
BCF PORTE,1				;bit 1 of PORTE set to 0
GOTO LABEL2
LABEL1:
    BSF PORTE,1				;bit 1 of PORTE set to 1
LABEL2:
GOTO MAIN_LOOP
    
END
