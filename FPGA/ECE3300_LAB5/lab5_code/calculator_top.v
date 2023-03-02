`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/11 16:59:27
// Design Name: 
// Module Name: calculator_top
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


module calculator_top(
                        input clk,
                        input [3:0] portA, portB,
                        input signA, signB,
                        input [1:0] mode,
                        output [7:0] AN,
                        output [6:0] cathode,
                        output DP                                       
                    );
                    
      assign DP = 1'b1;
      wire [2:0] refresh_clock;
      wire [7:0] result;
      wire sign_result;
      wire [3:0] ones, tens;      
      
      clock_divider #(4999) refresh_clk (clk, refresh_clock);
      calculator cal1 (portA, portB, signA, signB, mode, result, sign_result);
      binary_to_bcd_converter converter1(result, ones, tens);
      diplay_controller controller1(refresh_clock, portA, portB, signA, signB, mode, ones, tens, sign_result, cathode, AN);        
                    
endmodule
