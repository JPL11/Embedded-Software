
#include<P18F4620.inc>
    config OSC = INTIO67
    config WDT = OFF
    config LVP = OFF
    config BOREN = OFF
InB equ 0x0060
InA equ 0x0061
    
    ORG 0x0000
START:
    MOVLW 0x0F				    ;intialize ADCON and Ports 
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
MOVF PORTA,W				    ;move contents of PORTA to W
ANDLW 0x0F;
MOVWF InA				    ;move working reg to InB
MOVLW 0x0A
CPFSLT InA, W				    ;if InA is less than 10, skip next line
GOTO CONVERT				    ;jump to convert
GOTO FINISH				    ;jump to finish
CONVERT:				    ; begin conversion for bcd value
MOVF InA,W
ADDLW 0x06				    ;add 0x06 to W
MOVWF InA
FINISH:
MOVFF InA,PORTC				    ;copy InA to PORTC

BZ LABEL1
BCF PORTE,1				    ;set bit 1 of PORTE to 0
GOTO LABEL2
LABEL1:
    BSF PORTE,1				    ;set bit 1 of PORTE to 1
LABEL2:
GOTO MAIN_LOOP
    
END
