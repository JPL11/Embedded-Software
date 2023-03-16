# Digital Voltage Meter: Ohm Meter using Buzzer

## Notes

Two different meters, a voltage meter and an ohm meter, are designed and implemented. 

For the voltage meter, a potentiometer is connected to pin AN0 (RA0). And a program is written to measure the voltage input and display the voltage reading on two 7-segment displays with the upper digit indicating the volts and the lower digit showing the 1/10 volts unit. The program should also display the reading on TeraTerm software. Four different voltages between 0.5V and 4V are measured and the percentage error between the measured value and the actual value are calculated abd displayed on TeraTerm.

For the ohm meter, several resistors of known values and several resistors of unknown values are used. The program must be designed to measure the value of the unknown resistor based on the input voltage measured at AN1 (RA1), using KVL and KCL laws. The measured value of the unknown resistor must be displayed on two 7-segment displays, with the upper digit showing the value up to 9.9K with a decimal point and the lower digit showing only the integer portion of the value above 10K with no decimal point. The program should also display the reading on TeraTerm software. Ten different resistances are measured and the percentage error between the measured value and the actual value are calculated and displayed on TeraTerm. Additionally, the color of an RGB LED D2 is set to reflect the range of the value of the unknown resistor.


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
