# Assembly Language implementation

## Notes

This project implements uses of the Assembly Language with some arithmetic, logic and branching instructions.

## Schematics

Here's the schematics of implemented codes:

<img src='https://i.imgur.com/eIdrEYQ.jpg' title='Schematics_4' width='' alt='Schematics_4' />

## PART A)

The first part implements a basic program to input a member from the DIP switches, takes its 1's complement and display the results out to the LEDs. The 4 switches connected to PORT A are used to set a number. The content is read and masked in the lower 4-digit and stored in to the variable InB. The result is displayed on PORT C using 'COMF', 'MOVWF' and 'MOVFF' instructions. It shows the 1's complement of the number specified by the DIP switches.

## PART B)

The same operation as part a) is added but a test condition is added. The test is added after the completion of the Complement operation. The Zero (Z flag) is set through the use of the instruction BZ. If Z flag is 1, BZ will force a jump to a label where PORTE bit 1 is set to 1. If Z flag is 0, the instruction just below the BZ instruction will be executed.

## PART C)

A new operation is implemented to add two numbers. The routine developed in part b) is copied to add codes and read a second input from PORTA and stored into the variable 'In_A' and stored the result into 'Result'. The result is displayed into PORT C and shown on the 5 LEDs. The fifth LED of PORT C shows the overflow of the result of the addition of two 4-bit numbers.

## PART D)

The ADD operation on part c) is replaced by doing the 'OR' operation with the instruction 'ORWF     f, W'.

## PART E)

The ADD operation on part c) is replaced by doing the 'XOR' operation with the instruction 'XORWF     f, W'.

## PART F)

The last routine is added by taking a 4-bit input number and convert into s BCD number which is the decimal equivalent of the input number. The input number is checked against the value 0x09. If it is greater than 9, then add a constant 0x06 to it. If it is less than 9, then no addition of the constant is needed. The operationis implemented by reading the input into the varaible 'InB', loadig a constant 0x09 into W and using the instruction CPFSGT to compare the value in 'InB' against the W register.

## PART G)

The five functions implemented above are grouped into five different sets of code, SUBROUTINE_COMP, SUBROUTINE_ADD, SUBROUTINE_OR, SUBROUTINE_XOR, SUBROUTINE_BCD. The 'BTFSC' instructions are used to do the decoding of the five tasks. The BCF and BSF are used to set the three bits 6-4 of the PORTD to show what routine is being exceuted.

PORT D                  Action
Bit_2 Bit_1 Bit_0 
 0 0 0                  1’s complement 
 0 0 1                  ADD operation 
 0 1 0                  OR operation 
 0 1 1                  XOR operation 
 1 0 0                  BCD conversion 

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
