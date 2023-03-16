# Infrared Remote Control through NEC protocol

## Notes

The NEC protocol transmission is used to interface an Infrared Remote Control. The transmission is implemeted through the basic steps of the protocol, including the leading burst of pulses, the space period, and the various 8-bit fields. A detection method is used to differentiate between logic '0' and logic '1'. The protocol is implemented using a timer and an input pin with an edge-triggered interrupt feature. The program will use the INT0 pin to detect the different transitions of the IR signals and update the value of 'Nec_state' to keep track of the progress of the sequence. When an INT0 interrupt occurs, the first task is to read the content of the timer and save it to a variable. Then the program should determine which state the 'Nec_state' variable is in and update it accordingly. Sample code is provided to get started. Finally, the main routine checks the variable 'nec_ok' constantly.

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
