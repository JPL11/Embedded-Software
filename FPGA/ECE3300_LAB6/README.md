LAB6 - Barrel Shifter using 4 of seven-seg-displays by using instantiation 

ECE3300L.02 - Summer 2022

Group Jihun : Jihun Choi(Bronco ID#: 011841206) 

LAB6 description:

  Barrel Shifter that has multiple functions of mode(auto/manual), load, rotation/shift, left/right, and etc… by instantiation using vivado software and test the results with FPGA board.  



1) n-bit register module was created to be able to save the data and used for any amount of bit I need to use for later instantiation

 (input clk, input  [SIZE-1:0] in, input en, input rst, output reg [SIZE-1:0] out)
 
2) weird_4bit_counter module was created, as it was explained, it controls mode, load and 4 bit input and saves data into register2. 

In past 2 labs, I have been using refresh counter module to divide the clock, this time, following the lecture example of clock divider.

(input clk, input autoORmanual, input load, input [3:0] in, output reg [3:0] out)

3) nbit_barrelshifter module was created to have logic of left/right rotation and left/right shift. 

(input RorS, input LorR, input [$clog2(SIZE)-1:0] howmany, input [SIZE-1:0] in, output reg [SIZE-1:0] out)

4) seven_seg_controller module was created to control the output for seven_seg. This was basically reused code from past 2 labs.

(input clk, input [15:0] in, output DP, output reg [7:0] anode, output reg [6:0] cathode)

5) top module was created to connect everything together.

(input clk, input rstReg1, input rstReg2, input sel_reg, input [15:0] SW, output LEDforReg, output DP, output [7:0] anode, output [6:0] cathode)

6) top.xdc file was created and connected to the correct ports.

7) simulation was performed.





Video demonstartion Link:

https://youtu.be/nYmKyMC1K2k

or

https://drive.google.com/file/d/1pFKh9gAu_zoc07pPiJ2JiMsee6YaX43e/view?usp=sharing

