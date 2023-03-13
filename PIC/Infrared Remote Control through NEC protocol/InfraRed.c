#include <stdio.h>
#include <stdlib.h>
#include <xc.h>
#include <math.h>
#include <p18f4620.h>
#include <usart.h>
#include <string.h>

#pragma config OSC = INTIO67
#pragma config WDT = OFF
#pragma config LVP = OFF
#pragma config BOREN = OFF
#pragma config CCP2MX = PORTBE

#include "ST7735.h"



#define _XTAL_FREQ   8000000                        // Set operation for 8 Mhz
#define TFT_DC       PORTCbits.RC0          		// Location of TFT D/C
#define TFT_CS       PORTCbits.RC1                  // Location of TFT Chip Select
#define TFT_RST      PORTCbits.RC4                  // Location of TFT Reset




void TIMER1_isr(void);
void INT0_isr(void);
void Initialize_Screen();

unsigned char Nec_state = 0;
unsigned char i,bit_count;
short nec_ok = 0;
unsigned long long Nec_code;
char Nec_code1;
unsigned int Time_Elapsed;

void force_nec_state0(void); 
//void waitHalfSecond();
void wait_one_sec();
// colors
#define RD               ST7735_RED
#define BU               ST7735_BLUE
#define GR               ST7735_GREEN
#define CY               
#define MA               ST7735_MAGENTA
#define BK               ST7735_WHITE
                                                    // Format is Letter, Color, LED number
#define DR1             0x01                        // PORT D Start
#define DG1             0x02
#define DB1             0x04
#define DM1             0x05                        
#define DC1             0x06

#define DR2             0x01                        
#define DG2             0x02                        // Port E Start
#define DB2             0x04   
#define DC2             0x06

#define DM2             0x05
#define DW2             0x07                        // PORT E End


#define DW3             0x38                        // only PORT D definition



#define Circle_Size     20                          // Size of Circle for Light
#define Circle_X        60                          // Location of Circle
#define Circle_Y        80                          // Location of Circle
#define Text_X          52          
#define Text_Y          77          
#define TS_1            1                           // Size of Normal Text
#define TS_2            2                           // Size of Big Text



char buffer[31];                                    // general buffer for display purpose
char *nbr;                                          // general pointer used for buffer
char *txt;

char array1[21]=                                    // IR codes
{
    0xA2,0x62,0xE2,
    0x22,0x02,0xC2,
    0xE0,0xA8,0x90,
    0x68,0x98,0xB0,
    0x30,0x18,0x7A,
    0x10,0x38,0x5A,
    0x42,0x4A,0x52,
};

char txt1[21][4] =                                  // Text to display on LCD corresponding to button press      
{
    "CH-\0","CH\0","CH+\0",
    
    "|<<\0",">>|\0",">||\0",
    
    " - \0"," + \0","EQ \0",
    
    " 0 \0","100\0","200\0",
    
    " 1 \0"," 2 \0"," 3 \0",
    
    " 4 \0"," 5 \0"," 6 \0",
    
    " 7 \0"," 8 \0"," 9 \0"
};

int color[21]=                                      // Color of LCD circle that is displayed corresponding to button press
{
    RD,RD,RD,
    BU,BU,GR,
    MA,MA,MA,
    BK,BK,BK,
    BK,BK,BK,
    BK,BK,BK,
    BK,BK,BK,
};

char D1[21] =                                       // Color Definitions Start
{
    DR1,DR1,DR1,
    DC1,DC1,DG1,
    DB1,0x00,0x00,
    0x00,0x00,0x00,
    0x00,0x00,0x00,
    0x00,0x00,0x00,
    0x00,0x00,0x00,
};
char D2[21] = 
{
    0x00,0x00,0x00,
    0x00,0x00,0x00,
    0x00,DB2,DM2,
    DW2,DW2,DW2,
    DW2,DW2,0x00,
    0x00,0x00,0x00,
    0x00,0x00,0x00,
};
char D3[21] = 
{
    0x00,0x00,0x00,
    0x00,0x00,0x00,
    0x00,0x00,0x00,
    0x00,0x00,0x00,
    0x00,0x00,DW3,
    DW3,DW3,DW3,
    DW3,DW3,DW3,
};                                                  // Color Definitions End

void putch (char c)
{
    while (!TRMT);
    TXREG = c;
}
void init_UART()
{
    OpenUSART (USART_TX_INT_OFF & USART_RX_INT_OFF &
    USART_ASYNCH_MODE & USART_EIGHT_BIT & USART_CONT_RX &
    USART_BRGH_HIGH, 25);
    OSCCON = 0x60;
}

void interrupt high_priority chkisr()
{
    if (PIR1bits.TMR1IF == 1) TIMER1_isr();
    if (INTCONbits.INT0IF == 1) INT0_isr();
}

void TIMER1_isr(void)
{
    Nec_state = 0;                                  // Reset decoding process
    INTCON2bits.INTEDG0 = 0;                        // Edge programming for INT0 falling edge
    T1CONbits.TMR1ON = 0;                           // Disable T1 Timer
    PIR1bits.TMR1IF = 0;                            // Clear interrupt flag
}

void force_nec_state0()
{
    Nec_state=0;
    T1CONbits.TMR1ON = 0;
}

void INT0_isr(void)
{
    INTCONbits.INT0IF = 0;                          // Clear external interrupt
    if (Nec_state != 0)
    {
        Time_Elapsed = (TMR1H << 8) | TMR1L;       // Store Timer1 value
        TMR1H = 0;                                 // Reset Timer1
        TMR1L = 0;
    }
    
    switch(Nec_state)
    {
        case 0 :
        {
                                                    // Clear Timer 1
            TMR1H = 0;                              // Reset Timer1
            TMR1L = 0;                              //
            PIR1bits.TMR1IF = 0;                    //
            T1CON= 0x90;                            // Program Timer1 mode with count = 1usec using System clock running at 8Mhz
            T1CONbits.TMR1ON = 1;                   // Enable Timer 1
            bit_count = 0;                          // Force bit count (bit_count) to 0
            Nec_code = 0;                           // Set Nec_code = 0
            Nec_state = 1;                          // Set Nec_State to state 1
            INTCON2bits.INTEDG0 = 1;                // Change Edge interrupt of INT0 to Low to High            
            return;
        }
        
        case 1 :
        {
            

            if( (Time_Elapsed > 8500 ) && (Time_Elapsed < 9500))
            {
                Nec_state = 2;                      // Set to next state if time is between 8500 microseconds and 9500 microseconds
            }
            else
            {
                force_nec_state0();                 // If it is not, force state to 0
            }
            
          INTCON2bits.INTEDG0 = 0;                  // Change Edge interrupt of INT0 to High to Low
          return; 
        }
        
        case 2 :                           
        {
            
            if( (Time_Elapsed > 4000 ) && (Time_Elapsed < 5000))
            {
                Nec_state = 3;                      // Set to next state if time is between 4000 microseconds and 500 microseconds
            }
            
            else
            {
                force_nec_state0();                 // If it is not, force state to 0
            }
          INTCON2bits.INTEDG0 = 1;                  // Change Edge interrupt of INT0 to Low to High
          return; 
        }
        
        case 3 :                            
        {
            
            if( (Time_Elapsed > 400 ) && (Time_Elapsed < 700))
            {
                Nec_state = 4;                      // Set to next state if time is between 4000 microseconds and 500 microseconds
            }
            
            else
            {
                force_nec_state0();                 // If it is not, force state to 0
            }
          INTCON2bits.INTEDG0 = 0;                  // Change Edge interrupt of INT0 to High to Low
          return;
        }
        
        case 4 :                            
        {
            
             if( (Time_Elapsed > 400) && (Time_Elapsed < 1800))
            {
                Nec_code = Nec_code << 1;           // If time elapsed is between 400 microseconds and 1800 microseconds
                                                    // Left shift Nec_code by 1
                    if( Time_Elapsed > 1000 )       // If time elapsed is greater than 1000 microseconds
                    {
                        Nec_code += 1;              // Increment Nec_code
                    }
                    
                bit_count++;                        // Increment every time a bit is received
                
                    if( bit_count > 31 )            // Check if all the data is present
                    {
                        nec_ok = 1;                 // If it is reset interrupt flag, set transmission as success and restart the state machine
                        INTCONbits.INT0IE = 0;
                        Nec_state = 0; 
                    }
                
                Nec_state = 3;                      // Go back to state 3 and repeat until all bits are transmitted properly
                
                 
            }
            else
            {
                 force_nec_state0();                // If none of the conditions within the time elapsed are not met, restart the state machine
            } 
           INTCON2bits.INTEDG0 = 1;                 // Change Edge interrupt of INT0 to Low to High
           
           return;
        }   
    }
}

void main()
{
    init_UART();
    OSCCON = 0x70;                                  // 8 Mhz
    nRBPU = 0;                                      // Enable PORTB internal pull up resistor
    TRISA = 0x00;       
    TRISB = 0x01;       
    TRISC = 0x00;                                   // PORTC as output
    TRISD = 0x00;       
        
//PORTA = 0x00;       
//PORTB = 0x00;       
//PORTC = 0x00;       
//PORTD = 0x00;       
//PORTE = 0x00;       

    ADCON1 = 0x0F;      

    TRISE = 0x00;   

    Initialize_Screen();        
    INTCONbits.INT0IF = 0;                          // Clear external interrupt
    INTCON2bits.INTEDG0 = 0;                        // Edge programming for INT0 falling edge H to L
    INTCONbits.INT0IE = 1;                          // Enable external interrupt
    TMR1H = 0;                                      // Reset Timer1
    TMR1L = 0;                                      //
    PIR1bits.TMR1IF = 0;                            // Clear timer 1 interrupt flag
    PIE1bits.TMR1IE = 1;                            // Enable Timer 1 interrupt
    INTCONbits.PEIE = 1;                            // Enable Peripheral interrupt
    INTCONbits.GIE = 1;                             // Enable global interrupts
    nec_ok = 0;                                     // Clear flag
    Nec_code = 0x0;                                 // Clear code
    
    while(1)
    {
      
        
        if (nec_ok == 1)                            // If the transmission was successful
        {
            nec_ok = 0;                             // Clear flag

            Nec_code1 = (char) ((Nec_code >> 8));
            printf ("NEC_Code = %08lx %x\r\n", Nec_code, Nec_code1);
            INTCONbits.INT0IE = 1;                  // Enable external interrupt
            INTCON2bits.INTEDG0 = 0;                // Edge programming for INT0 falling edge

            char found = 0xff;                      // Initialize found variable to hold incoming data
            
            for( int i = 0; i < 21; i++ ) 
            {
                if( Nec_code1 == array1[i] )        // Check the array for the transmission 
                {
                    found = i;                      // Since all arrays are mapped in the same way, passing the index will give you the correct value for found
                } 
                
            }
            
            
            if (found != 0xff)                      // If the data was found, do a routine to display to LCD, Turn LEDs to color, and then buzz. 
            {
                fillCircle(Circle_X, Circle_Y, Circle_Size, color[found]);              // Display LCD Start
                drawCircle(Circle_X, Circle_Y, Circle_Size, ST7735_WHITE);              //
                drawtext(Text_X, Text_Y, txt1[found], ST7735_BLACK, ST7735_BLACK,TS_1); // Display LCD End
                PORTD = D1[found] | D3 [found];                                                      // Turn LEDs to color Start
                PORTE = D2[found];                                             //
            //    PORTD = PORTD & 0x1C | (D1[found]);                                     // Turn LEDs to color Start
            //    waitHalfSecond();                                                       // Turn on buzzer and activation (SEC) LED for roughly 500ms
                wait_one_sec();
            }

        }
    }
}


void Initialize_Screen()
{
    LCD_Reset();
    TFT_GreenTab_Initialize();
    fillScreen(ST7735_BLACK);
  
    /* TOP HEADER FIELD */
    txt = buffer;
    strcpy(txt, "ECE3301L Fall 22-S3");  
    drawtext(2, 2, txt, ST7735_WHITE, ST7735_BLACK, TS_1);

    strcpy(txt, "LAB 10");  
    drawtext(50, 10, txt, ST7735_WHITE, ST7735_BLACK, TS_1);
}




void Activate_Buzzer()
{
    PR2 = 0b11111001;
    T2CON = 0b00000101;
    CCPR2L = 0b01001010;
    CCP2CON = 0b00111100; 
}

void Deactivate_Buzzer()
{
    CCP2CON = 0x0;
    PORTBbits.RB3 = 0; 
}
void wait_one_sec()
{
     Activate_Buzzer();
    for (int k=0;k<17000;k++);
     Deactivate_Buzzer();
}
        

