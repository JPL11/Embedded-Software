`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal poly pomona
// Engineer: Jihun Choi, Jacky Li
// 
// Create Date: 2022/06/16 
// Design Name: Lab2 4 to 16 decoder
// Module Name: decoder4to16
// Project Name: Lab2 
// Target Devices: ARTIX-7 family
// Tool Versions: Vivado 2019.2
// Description: designing 4to16 decoder that has 4bit inputs, 1bit enable, and 16bit output
// 
// Dependencies: 
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments: This was designed by JIhun Choi and Jacky Li
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder4to16(
                        input wire [3:0] in,
                        input wire enable,
                        output reg [15:0] out
                     );
                     
       always@(in,enable)
       begin
            if(enable==1'b0)
                out=16'b0000000000000000;
            else if(enable==1'b1)
                if(in == 4'b0000)
                     out=16'b0000000000000001;
                else if(in == 4'b0001)
                     out=16'b0000000000000010;
                else if(in == 4'b0010)
                     out=16'b0000000000000100;
                else if(in == 4'b0011)
                     out=16'b0000000000001000;
                else if(in == 4'b0100)
                     out=16'b000000000010000;
                else if(in == 4'b0101)
                     out=16'b0000000000100000;
                else if(in == 4'b0110)
                     out=16'b0000000001000000;
                else if(in == 4'b0111)
                     out=16'b0000000010000000;
                else if(in == 4'b1000)
                     out=16'b0000000100000000;
                else if(in == 4'b1001)
                     out=16'b0000001000000000;
                else if(in == 4'b1010)
                     out=16'b0000010000000000; 
                else if(in == 4'b1011)
                     out=16'b0000100000000000;
                else if(in == 4'b1100)
                     out=16'b0001000000000000; 
                else if(in == 4'b1101)
                     out=16'b0010000000000000;
                else if(in == 4'b1110)
                     out=16'b0100000000000000;  
                else if(in == 4'b1111)
                     out=16'b1000000000000000;                                                                   
       end
       
endmodule
