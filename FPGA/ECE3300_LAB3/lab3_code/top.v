`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/24 01:56:11
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


module top
            #(parameter SIZE = 16)
            (
              input [SIZE-1:0] in,
              input sel,
              input CI,             
              output [SIZE-1:0] SUM,
              output CO
            );
            
            wire [SIZE-1:0] x;
            wire [SIZE-1:0] y;
            wire [SIZE:0] wire_RCA;          
            assign wire_RCA[0] = CI;
                             
               genvar i; //for loop for RTL
               for (i=0; i<SIZE; i=i+1)
                   begin
                            Demux d1(
                                       .in(in[i]),
                                       .sel(sel),
                                       .out0(x[i]),
                                       .out1(y[i])
                                 );
                                                
                             FA f1 (
                                        .A(x[i]),
                                        .B(y[i]),
                                        .CI(wire_RCA[i]),
                                        .SUM(SUM[i]),
                                        .CO(wire_RCA[i+1])                            
                                );
                    end        
       
                   assign CO = wire_RCA[SIZE];
       
endmodule
