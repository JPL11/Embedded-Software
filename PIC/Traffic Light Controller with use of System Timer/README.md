# Traffic Light Controller with use of System Timer

The system comprises four RGB LEDs (NS RGB, NSLT RGB, EW RGB, and EWLT RGB), four input sensors, two sets of 7-segment display, a buzzer, and a photo sensor. 

## Notes

A routine named Wait_One_Second() that waits for one second is implemented. This routine calls another routine Wait_Half_Second() twice to help wait for half a second. The Wait_Half_Second() uses Timer 0, 16-bit mode, and prescaler 1:8 to set the lower byte of TMR and the upper byte of TMR. The TMR0IF flag is cleared, and the Timer 0 is turned on, waiting for the flag to be set to signal that the wait is over. Then, support routine named Wait_N_Seconds(char seconds) that uses the Wait_One_Second() function to delay for N seconds is implemented. Nest, The #define statement is used to create eight signal names: NS_RED, NS_GREEN, NSLT_RED, NSLT_GREEN, EW_RED, EW_GREEN, EWLT_RED, and EWLT_GREEN. The schematics is used to determine the bit definitions for each signal name. And another routine is implemented to set the proper color for the RGB LEDs.

## Schematics

## License

    Copyright [2023] [Jacky Li]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
