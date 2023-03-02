`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/02 17:02:09
// Design Name: 
// Module Name: top_tb
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


module top_tb();
          
          reg clk = 0;
          reg enable =0;
          reg reset = 0;
          wire [7:0] AN;
          wire [6:0] cathode;
          wire DP=1;
          
                                                 
          top top1(
                        .clk(clk),
                        .enable(enable),
                        .reset(reset),
                        .AN(AN),
                        .cathode(cathode),
                        .DP(DP)                       
                );
          
          always #5 clk = ~clk;
          initial
            begin
                #500
                    enable =1;                               
            end
            
          
          
endmodule
