# Fan speed measurement with speed control through PWM

The Pulse Width Modulation (PWM) is used to control the speed of a fan and measure the speed that the fan is rotating by capturing the number of tach pulses from the fan, and the result is displayed on the TFT panel. 

## Notes

It involves measuring the speed of the fan using a timer to count the number of pulses generated on the Tach signal. A routine called get_RPM() is then written to measure and return the revolution per minute of the fan. The duty cycle is varied to control the speed of the fan using the signal FAN_PWM. The fan can take a PWM pulse with a frequency range from 18Khz to 30 Khz, and 25 Khz will be used as the frequency. The registers PR2, T2CON, CCP1CON, and CCPR1L will be changed based on the specified value of the duty cycle.

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
