LAB7 - updown load couonter using 8 of seven-seg-displays by using instantiation 

ECE3300L.02 - Summer 2022

Group Jihun : Jihun Choi(Bronco ID#: 011841206) + Group D(Eric & Michael)

This lab7 was collaboration work with Group D. 

LAB7 description:

   Updown Counter using 8 seven segment displays that has a function of loading 4-bit BCD value to any of 8 seven segment displays by instantiation using vivado software and test the results with FPGA board.



1) demux1by8 module was created to be able to select 0~7 of 8 available seven segment displays

 (input en, input [2:0] loadSelect, input [3:0] loadValue, output reg [7:0] enOut, output reg [31:0] out)
 
2) clockSpeedController module was created to control the speed of the counter, more likely to control the divider value for clock.

(input clk, input en, input [4:0] clkSpeed, output clkDivider)

3) BCDUpDownCounter module was created to have the functions of UpDownCounter. It has functions of reset, load, enable, up and down. 

(input clk, input en, input reset, input upDown, input load, input [3:0] loadValue, output reg rollover, output reg [3:0] BCDOut)

4) nbitUpDownBCD module was created to call BCDUpDownCounter module to make it as 8bit since we have 8 seven segment displays.

(input clk, input en, input reset, input upDown, input [31:0] loadValue, input [7:0] loadSelect, output loadFeed, output [31:0] out )

5)  ssd module was created to control the seven segment displays

(input clk, input reset, input [31:0] in, output DP, output reg [7:0] anode, output reg [6:0] AtoG)

6) top module was created to connect everything together.

(input clk, input en, input reset, input load, input upDown, input [2:0] loadSelect, input [3:0] loadValue, input [4:0] speed, output DP, output loadLED, output enLED, output upDownLED, output [6:0] AtoG, output [7:0] anode)

7) top.xdc file was created and connected to the correct ports.

8) simulation was performed to test every corner case possible

-testing enable+counting up

-testing counting down

-testing reset

-testing load

-testing counting down with load value

-testing different clock speed


Video demonstartion Link:

https://youtu.be/Bylgmd7i0PA

or

https://drive.google.com/file/d/12g5RtZtZgz62S7-GDnIKTBJm5SykJPBH/view?usp=sharing


