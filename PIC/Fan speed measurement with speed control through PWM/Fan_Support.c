#include <p18f4620.h>
#include "Main.h"
#include "Fan_Support.h"
#include "stdio.h"

extern char FAN;
extern char duty_cycle; 


int get_RPM()
{
    int RPS = TMR3L / 2; // read the count. Since there are 2 pulses per rev
                         // then RPS = count /2
    TMR3L = 0;           // clear out the count
    return (RPS * 60);   // return RPM = 60 * RPS
}

void Toggle_Fan()
{
    if(FAN == 0)         // if FAN is 0, FAN is turned on. else FAN is off
        Turn_On_Fan();
    else
        Turn_Off_Fan();
}

void Turn_Off_Fan()
{
    FAN = 0;            // Set FAN = 0, so it can be toggled on
    FAN_EN = 0;         // FAN enabled and LED are turned off
    FANEN_LED = 0;
}

void Turn_On_Fan()
{
    FAN = 1;                    // Set FAN = 1, so it can be toggled off
    do_update_pwm(duty_cycle);  // reupdate the pwm
    FAN_EN = 1;                 // FAN enabled and LED are turned on
    FANEN_LED = 1;
}

void Increase_Speed()
{
    if ( duty_cycle == 100 ) 
    {
        Do_Beep();
        Do_Beep();
        do_update_pwm(duty_cycle); 
    }
    else 
    {
        duty_cycle += 5;
        do_update_pwm(duty_cycle); 
    }


}

void Decrease_Speed()
{
   if ( duty_cycle == 0 ) 
    {
       Do_Beep();
       Do_Beep();
       do_update_pwm(duty_cycle); 
    }
   else 
   {
       duty_cycle -= 5;
       do_update_pwm(duty_cycle); 
   }
}

void do_update_pwm(char duty_cycle)
{
    float dc_f;
    int dc_I;
    PR2 = 0b00000100 ;                  // set the frequency for 25 Khz
    T2CON = 0b00000111 ;                //
    dc_f = ( 4.0 * duty_cycle / 20.0) ; // calculate factor of duty cycle versus a 25 Khz
                                        // signal
    dc_I = (int) dc_f;                  // get the integer part
    if (dc_I > duty_cycle) dc_I++;      // round up function
    CCP1CON = ((dc_I & 0x03) << 4) | 0b00001100;
    CCPR1L = (dc_I) >> 2;
}

 void Set_DC_RGB(int duty_cycle)
{
    int temp = duty_cycle / 10;
    int output;
    if (temp ==0 )     output = 0;                              //if the upper digit = 0 then LED2 will be off
    else if((temp >= 1) & (temp < 7))    output = temp;         //if 1<=u<7 then LED2 will display the color of the corresponding number of u
    else if (temp>=7) output = 0x07;                            //if u>= 7, LED2 will be white
    PORTD = output | PORTD;
}

void Set_RPM_RGB(int rpm)
{
    int output;
    if (rpm == 0) output == 0;
    else
    {
        int temp = rpm / 500;
        if (temp == 0) output = 0x01;
        else if ( (temp >= 1) & (temp < 6) ) output = temp+1;
        else if ( temp >= 6) output = 0x07;
    }
    PORTD = (output << 3);
}

void Do_Beep()
{
    Activate_Buzzer();
    Wait_One_Sec();
    Deactivate_Buzzer();
}

void Wait_One_Sec()
{
    Activate_Buzzer();
    for (int k=0;k<17000;k++);
    Deactivate_Buzzer();
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
