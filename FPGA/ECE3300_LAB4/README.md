LAB4 - - 2 digit counter using 2 seven-seg-displays by using instantiation 

ECE3300L.02 - Summer 2022

Group A : Jihun Choi(Bronco ID#: 011841206) 


LAB4 description:

2 digit counter (0~99) using 2 seven-seg-displays is designed by using vivado software and test the results with FPGA. 

1) we create clock_divider module to divide clock for seven segment display

(input clk, output divided_clk)

2) we create refreshcounter module to have separate counter to be used in anode
controller and digit controller

(input refresh_clock, output refreshcounter)

3) we create anode_controller module to control which 7 sevenment to be turned on
by using refreshcounter

(input refreshcounter, output [7:0] AN since there are 8 seven seg available, but we are only using 2)

4) we create digit_controller module to control which locations of digit(one's or ten's) to show by using refrescounter

(input refreshcounter, [3:0] ones, [3:0] tens, output [3:0] digit )

5) we create binary_to_bcd_converter module to convert binary number to bcd format using idea of shift

(input [7:0] number, output [3:0] ones, output [3:0] tens)

6) we create bcd_to_cathode module to connect bcd number (0~9) to corresponding cathode for seven segment display

(input [3:0] digit, output reg [6:0] cathode)

7) we create two_digit_counter module to write function of the main idea (reset and enable to pause)

(input clk, enable, reset , output [7:0] counter)

8) we create seven_seg_controller to connect refresh counter module to anode_controller and digit_controller. Then, connect digit_controller with bcd_to_cathode

(input refresh_clock, input [3:0] ones, tens, output [7:0] AN, output [6:0] cathode)

9) we create top module to connect two_digit_counter to be connected with other modules

10) we create a top.xdc file and connect the correct ports.

11) simulation was performed and confirmed (No video included for simulation since computer was not able to handle to record and run it at sametime)

Video demonstartion Link:

https://youtu.be/2OLKznhubEw

or

https://drive.google.com/file/d/1CL9M76JCyxCSSrKhnL69roycP3X1VjHo/view?usp=sharing
