`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/24 01:55:40
// Design Name: 
// Module Name: Demux
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


module Demux(
                input  in,
                input  sel,
                output reg out0,
                output reg out1
                
            );
            
         
                     
         always @(in,sel)
         begin    
                  if(sel)
                  out1=in;
                  else 
                  out0=in;
         end                
endmodule
