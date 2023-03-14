# A/D converter, Temperature Sensor & Light Sensor

## Notes

The voltage is read from the LMT84 using the PIC18F4620's ADC Channel 0 connected to AN0. The tempertaure is calculated in degree C. Then the voltage is converted into the equivalent temperature in degree F. The temperature in degree F is displayed onto the two 7-segment displays. the same result is output to the TeraTerm terminal. The voltage readout of the LMT84 and the temperatures in degree F are displayed. The three common cathode RGB LEDs, D1, D2 and D3, show different colors based on temperature range, temperature and AN2 voltage respectively.

## Schematics

Here's the schematics of implemented codes/circuit:

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
