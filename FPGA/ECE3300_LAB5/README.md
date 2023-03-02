LAB5 -  Alien Calculator using 7 seven-seg-displays by using instantiation 

ECE3300L.02 - Summer 2022

Group Jihun : Jihun Choi(Bronco ID#: 011841206) 

LAB5 description:

 Alien calculator that handles addition, subtraction, and multiplication plus division (extra feature) of two 4bit numbers that each has an extra 1 it for its own sign using 7 seven-seg-displays is designed by using vivado software and test the results with FPGA. 



1) clock_divider module was created to divide clock for seven segment display

  (input clk, output reg [2:0] divided_clk)
 
2) display_controller module was created to have 4 different functions

-generate refresh clock

-anode controller (seven seg display controller)

-digit controller (which digit to show)

-bcd to cathode (translating bcd number to corresponding cathode variables)

 (input [2:0] clock, [3:0] portA, portB, input signA, signB, [1:0] mode, [3:0] result_ones, [3:0] result_tens, input result_sign, output reg [6:0] cathode, output reg  [7:0] anode)

3) binary_to_bcd_converter module was created to convert binary number to bcd format using idea of shift 

 (input [7:0] number, output [3:0] ones, output [3:0] tens)

4) calculator module was created to have the functions of addition, subtraction, multiplication, and division (extra feature).

 (input [3:0] A, B, input sign_A, sign_B, input [1:0] mode, output reg [7:0] result, output reg result_sign)

5) calculator_top module was created to connect all other modules together.

6) calculator_top.xdc file was created and connected to the correct ports.

7) simulation was performed




Video demonstartion Link:

https://youtu.be/Vq9J-m0bdp0

or

https://drive.google.com/file/d/1wM39O4ceyxF0Vwz4pXxonIgVMO8qMVhj/view?usp=sharing


