`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 12:58:33
// Design Name: 
// Module Name: nbit_register
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


module nbit_register #(parameter SIZE = 8)
(
    input clk,
    input [SIZE-1:0] in,
    input en,
    input rst,
    output reg [SIZE-1:0] out
);
    
    always@(posedge clk or posedge rst)
	begin
		if(rst)
	 	  out <= 0;
		else if (en)
		  out <= in;
	end

endmodule
