
#include <p18f4620.h>
#include "Main.h"
#include "Fan_Support.h"
#include "stdio.h"

extern char HEATER;
extern char duty_cycle;
extern char heater_set_temp;
extern signed int DS1621_tempF;

int get_duty_cycle(signed int temp, int set_temp)
{
 
    if (temp >= set_temp) // check if temp is greater than set_temp. If so, set dc according to the handout
    {
        duty_cycle = 0;
        
    }
    else {
        signed int diff = set_temp - temp;
        if (diff > 50) duty_cycle = 100; // check if dc is greater than 50. If so, set it to 100
        if ((diff < 50) && (diff>= 25)) duty_cycle = diff * 2;
        if ((diff < 25) && (diff>= 10)) duty_cycle = diff * 3/2;
        if ((diff < 10) && (diff>= 0)) duty_cycle = diff;
        
    }
    return duty_cycle;
// if dc is negative, set to 0
// return dc

}

void Monitor_Heater()
{
    if (HEATER == 0) duty_cycle = 0;
    else duty_cycle = get_duty_cycle(DS1621_tempF, heater_set_temp);
    do_update_pwm(duty_cycle);

    if (HEATER == 1) 
    {
        FAN_EN = 1;
    }
    else FAN_EN = 0;
}

void Toggle_Heater()
{
    HEATER = !(HEATER);
//    if (HEATER == 0)
//        Turn_On_Fan();
//    else
//        Turn_Off_Fan();

}

int get_RPM()
{
    int RPS = TMR3L / 2; // read the count. Since there are 2 pulses per rev
                         // then RPS = count /2
    TMR3L = 0;           // clear out the count
    return (RPS * 60);   // return RPM = 60 * RPS
}

void Turn_Off_Fan()
{
    HEATER = 0;
    FAN_EN = 0;
    FANEN_LED = 0;
}

void Turn_On_Fan()
{
    HEATER = 1;
    do_update_pwm(duty_cycle);
    FAN_EN = 1;
    FANEN_LED = 1;
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




