
#include<P18F4620.inc>
    config OSC = INTIO67
    config WDT = OFF
    config LVP = OFF
    config BOREN = OFF
InB equ 0x0060
Result equ 0x0062
    
    ORG 0x0000
START:
    MOVLW 0x0F		    
    MOVWF ADCON1					; initialize the A/D Conversion    
    MOVLW 0xFF		    
    MOVWF TRISA						; PORTA as input
    MOVLW 0xFF				    
    MOVWF TRISB						; PORTB as input
    MOVLW 0xFF		    
    MOVWF TRISD						; PORTD as input
    
    MOVLW 0x00		    
    MOVWF TRISC						; PORTC as output
    MOVLW 0x00		    
    MOVWF TRISE						; PORTE as output
    
    CLRF PORTE
    
MAIN_LOOP:
MOVF PORTA,W						;move contents of PORTA to W
MOVWF InB						;move working reg to InB
COMF InB,W						;complement InB and store in working reg
ANDLW 0x0F						;mask W lower 4 bits with 1
MOVWF Result						;move working reg to Result
MOVFF Result,PORTC					;copy Result to PORTC
GOTO MAIN_LOOP						;repeat loop
END



