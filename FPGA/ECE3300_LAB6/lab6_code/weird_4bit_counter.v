`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 12:59:25
// Design Name: 
// Module Name: weird_4bit_counter
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


module weird_4bit_counter(
                                        input clk,
                                        input autoORmanual,
                                        input load,
                                        input [3:0] in,
                                        output reg [3:0] out=0  //initially at 0
                                    );
                     
    reg[26:0] clock_counter = 0; 
    wire clock_divider;

    assign clock_divider = clock_counter[26];

    always@(posedge clk)
        begin
            clock_counter <= clock_counter+1;
        end
        
   always@(posedge clock_divider)
    begin
        if(load || !autoORmanual) //either loading the value or on manual mode
            out = in;
        else
            out = out +1;    
    end     
                     
                     
endmodule
