`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/02 15:06:53
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
                            input clk, enable, reset,
                            output [7:0] AN,
                            output [6:0] cathode,
                            output DP
           );
                
                assign DP = 1'b1;
                wire refresh_clock;
                wire counter_clock;               
                wire [7:0] counter_value;
                wire [3:0] ones, tens;    
                    
                clock_divider #(4999) refresh_clk (clk, refresh_clock); //refresh_clock is very fast
                clock_divider #(9999999) counter_clk (clk, counter_clock); //counter_clk is much slower
                two_digit_counter count_99 (counter_clock, enable, reset, counter_value);
                binary_to_bcd_converter convert_bcd (counter_value, ones, tens);
                seven_seg_controller ssd_control (refresh_clock, ones, tens, AN, cathode);    
endmodule
