`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal poly pomona
// Engineer: Jihun Choi, Jacky Li
// 
// Create Date: 2022/06/08 15:17:15
// Design Name: Lab1 2 to 1 mux
// Module Name: mux2to1
// Project Name: Lab1 
// Target Devices: ARTIX-7 family
// Tool Versions: Vivado 2019.2
// Description: designing 2to1 mux that has two of 4bit inputs, 1bit select, and 4 bit output
// 
// Dependencies: 
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments: This was designed by JIhun Choi and Jacky Li
// 
//////////////////////////////////////////////////////////////////////////////////


module mux2to1(
                    input wire [3:0] a,
                    input wire [3:0] b,
                    input wire sel,
                    output reg  [3:0] f
                  
              );
                          
     always @(a,b,sel)
     begin    
              if(sel==0)
              f=a;
              else 
              f=b;
     end
              
endmodule
