# Pedestrian Control using External Interrupt

## Notes

The same circuit is used as the one implemented in Implementation of LCD Panel in a Traffic Light Controller. Interrupt Enable (IE), Interrupt Flag (IF), and Global Interrupt Enable (GIE) bits are used. The Interrupt Service Routine (ISR) and a Return from Interrupt (RETI) are used to resume the interrupted program. External interrupts occur when an input changes from one logic level to another, and three PIC18F4620 pins can be used for this operation. The registers associated with these pins are INTCONbits, INTCON3bits, and INTCON2bits. The INTxIE must be set to 1 to enable an associated INTx signal to generate an interrupt when it transitions with the type of edge specified by the INTEDGx bit. The INTxIF bit is set to 1 when the associated INTx signal has made the edge transition that would cause a subsequent interrupt. It needs to be cleared once the interrupt has been processed to allow the next interrupt to occur. The INTEDGx bit is set to 0 or 1, indicating whether an interrupt is to be generated when the logic transition goes from high-to-low (falling edge) or vice versa.

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
