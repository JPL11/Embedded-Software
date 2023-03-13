#include <stdio.h>
#include <stdlib.h>
#include <xc.h>
#include <math.h>
#include <p18f4620.h>

#pragma config OSC = INTIO67
#pragma config WDT = OFF
#pragma config LVP = OFF
#pragma config BOREN = OFF

#define D1_RED PORTBbits.RB3
#define D1_GREEN PORTBbits.RB4
#define D1_BLUE PORTBbits.RB5

#define D2_RED PORTBbits.RB0
#define D2_GREEN PORTBbits.RB1   
#define D2_BLUE PORTBbits.RB2

#define D3_RED PORTAbits.RA4
#define D3_BLUE PORTAbits.RA5


char array[]= {0x01,0x4f,0x12,0x06,0x4C,0x24,0x20,0x0F,0x00,0x04};  //7 segment display values from 0-9

void init_UART()
{
 OpenUSART (USART_TX_INT_OFF & USART_RX_INT_OFF &
USART_ASYNCH_MODE & USART_EIGHT_BIT & USART_CONT_RX &
USART_BRGH_HIGH, 25);
 OSCCON = 0x60;
}

void putch (char c)
{
 while (!TRMT);
 TXREG = c;
}
void Set_D1(char);
void Set_D2(char);
void Init_ADC(void)
{
 ADCON0=0x01;
 ADCON1=0x1B ;                              // select pins AN0 through AN3 as analog signal, VDD-VSS as
                                            // reference voltage
 ADCON2=0xA9;                               // right justify the result. Set the bit conversion time (TAD) and
                                            // acquisition time
}
unsigned int get_full_ADC(void)
{
int result;
ADCON0bits.GO=1;                            // Start Conversion
while(ADCON0bits.DONE==1);                  // wait for conversion to be completed
result = (ADRESH * 0x100) + ADRESL;         // combine result of upper byte and
                                            // lower byte into result
return result;                              // return the result.
}
void Delay_One_Sec()
{
    for(int I=0; I <17000; I++);
}
void Select_ADC_Channel(char channel)
{
    ADCON0 = channel * 4 + 1;           // ADCON0 select channel depending on
}

void Init_TRIS(){
    TRISA = 0x0F;                       // PORTA as output for last 4 bits
    TRISB = 0x00;                       // PORTB as output
    TRISC = 0x00;                       // PORTC as output
    TRISD = 0x00;                       // PORTD as output
    TRISE = 0x00;                       // PORTE as output
    PORTC = 0xFF;
    PORTD = 0xFF;
    PORTB = 0x00;
}
void Display_Lower_Digit(char digit)
{
    PORTD = array[digit];
}
void Display_Upper_Digit(char digit)
{
    PORTC = array[digit] & 0x3f;        // MASK PORTC with array[digit] lower 5 bits
    int bit6 = array[digit]&0x40;       // create a variable called bit 6 that mask the array[digit] 6 bit
    if(bit6 == 0x40){                   // checks if bit 6 is 1
        PORTE = 0x01;                   // PORTE is 1 (OFF)
    }
    else if(bit6 == 0x00){              // checks if bit 6 is 0
        PORTE = 0x00;                   // PORT E is 0 (ON)
    }
}
void SET_D1_OFF()
{
    D1_RED = 0;
    D1_GREEN = 0;
    D1_BLUE = 0;
}
void SET_D1_RED()
{
    D1_RED = 1;
    D1_GREEN = 0;
    D1_BLUE = 0;
}
void SET_D1_GREEN()
{
    D1_RED = 0;
    D1_GREEN = 1;
    D1_BLUE = 0;
}

void SET_D1_YELLOW()
{
    D1_RED = 1;
    D1_GREEN = 1;
    D1_BLUE = 0;
}
void SET_D1_BLUE()
{
    D1_RED = 0;
    D1_GREEN = 0;
    D1_BLUE = 1;
}
void SET_D1_PURPLE()
{
    D1_RED = 1;
    D1_GREEN = 0;
    D1_BLUE = 1;
}
void SET_D1_CYAN()
{
    D1_RED = 0;
    D1_GREEN = 1;
    D1_BLUE = 1;
}
void SET_D1_WHITE()
{
    D1_RED = 1;
    D1_GREEN = 1;
    D1_BLUE = 1;
}
//D2
void SET_D2_OFF()
{
    D2_RED = 0;
    D2_GREEN = 0;
    D2_BLUE = 0;
}
void SET_D2_RED()
{
    D2_RED = 1;
    D2_GREEN = 0;
    D2_BLUE = 0;
}
void SET_D2_GREEN()
{
    D2_RED = 0;
    D2_GREEN = 1;
    D2_BLUE = 0;
}

void SET_D2_YELLOW()
{
    D2_RED = 1;
    D2_GREEN = 1;
    D2_BLUE = 0;
}
void SET_D2_BLUE()
{
    D2_RED = 0;
    D2_GREEN = 0;
    D2_BLUE = 1;
}
void SET_D2_PURPLE()
{
    D2_RED = 1;
    D2_GREEN = 0;
    D2_BLUE = 1;
}
void SET_D2_CYAN()
{
    D2_RED = 0;
    D2_GREEN = 1;
    D2_BLUE = 1;
}
void SET_D2_WHITE()
{
    D2_RED = 1;
    D2_GREEN = 1;
    D2_BLUE = 1;
}
//D3
void SET_D3_RED()
{
    D3_RED = 1;
    D3_BLUE = 0;
}
void SET_D3_BLUE()
{
    D3_RED = 0;
    D3_BLUE = 1;
}
void SET_D3_PURPLE()
{
    D3_RED = 1;
    D3_BLUE = 1;
}

void main()
{
 while(1){
 Init_TRIS();                                          // Initialize the IO function
 Init_ADC();                                         // Initialize ADC
 init_UART();                                        // Initialize UART
 
 Select_ADC_Channel(0);                              // Select Channel AN0
 int num_step = get_full_ADC();                      // Getting number of steps from ADC
 float voltage_mv = num_step * 4.0;                  // The voltage in mv is num_steps * 4
 float temperature_C = (1035.0 - voltage_mv) / 5.50; // Formula for temperature in Celsius
 float temperature_F = 1.80 * temperature_C + 32.0;  // Conversion from temperature C to temperature F
 int tempF = (int) temperature_F;                    // Cast temperature_F and store it in tempF
 char U = tempF / 10;                                // store tempF/10 giving the into a char U
 char L = tempF % 10;                                // store tempF%10 (remainder) into a char L
// PORTD = array[L];
// char t = array[U];
// PORTC = U & 0x3f;
 Display_Upper_Digit(U);                             // Display the char U into the seven segments upper digit
 Display_Lower_Digit(L);                             // Display the char L into the seven segments lower digit
 
if (tempF >= 70) SET_D2_WHITE();
    
    else if (tempF <=0) SET_D2_OFF();
   else  (PORTB = tempF/10);   

//  if(tempF < 10){                                     // if tempF is less than 10
//     SET_D2_OFF();                                   // SET D1 to OFF
// }
// else if(tempF>=10 && tempF <=19){                   // if tempF between 10 and 19
//     SET_D2_RED();                                   // SET D1 TO RED
// }
// else if(tempF>=20 && tempF <=29){                   // if tempF between 20 and 29
//     SET_D2_GREEN();                                 // SET D1 TO GREEN
// }
// else if(tempF>=30 && tempF <=39){                   // if tempF between 30 and 39
//     SET_D2_YELLOW();                                // SET D1 TO YELLOW
// }
// else if(tempF>=40 && tempF <=49){                   // if tempF between 40 and 49
//     SET_D2_BLUE();                                  // SET D1 TO BLUE
// }
// else if(tempF>=50 && tempF <=59){                   // if tempF between 50 and 59
//     SET_D2_PURPLE();                                // SET D1 TO PURPLE
// }
// else if(tempF>=60 && tempF <=69){                   // if tempF between 60 and 69
//     SET_D2_CYAN();                                  // SET D1 TO CYAN
// }
// else if(tempF>=70){                                 // if tempF greater than 70
//     SET_D2_WHITE();                                 // SET D1 TO WHITE
// }

 if(tempF <= 45){                                    // if tempF less than 45
     SET_D1_OFF();                                   // SET D2 TO OFF
 }
 else if(tempF>=46 && tempF <=55){                   // if tempF between 46 and 55
     SET_D1_RED();                                   // SET D2 TO RED
 }
 else if(tempF>=56 && tempF <=65){                   // if tempF between 56 and 65
     SET_D1_GREEN();                                 // SET D2 TO GREEN
 }
 else if(tempF>=66 && tempF <=75){                   // if tempF between 66 and 75
     SET_D1_BLUE();                                  // SET D2 TO BLUE
 }
 else if(tempF>= 76){                                // if tempF greater than 76
     SET_D1_WHITE();                                 // SET D2 TO WHITE
 }

  Select_ADC_Channel(2);                            // Selecting Channel AN1 to read the photo resistor values
  int num_step = get_full_ADC();                   // get number of steps from channel AN1 using get_full_ADC
  float voltage_mv1 = (num_step * 4.0)/1000.0;       // photo resistor voltage values in Volts
  if(voltage_mv1 < 2.1){                            // if Voltage is less than 2.5
      SET_D3_RED();                                 // SET RGB LED D3 to RED
  }
  else if(voltage_mv1 >= 2.1 && voltage_mv1<3.0){   // if voltage of channel AN1 between 2.5 and 3.4
      SET_D3_BLUE();                               // SET RGB LED D3 to BLUE
  }
  else if(voltage_mv1 >= 3.0){                      // if voltage of channel AN1 greater than 3.4
      SET_D3_PURPLE();                              // SET RGB LED D3 to PURPLE
  }
 printf ("Light Voltage = %f V \r\n", voltage_mv1); // print out the light voltage ADC value on TeraTerm
 printf ("Temperature = %d F \r\n\n", tempF);       // print out the tempF ADC value on TeraTerm
  Delay_One_Sec();                                  //Delay One Sec to see TeraTerm results slower
    }
}

