`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/24 01:55:11
// Design Name: 
// Module Name: FA
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


module FA(          
            input A,
            input B,
            input CI,
            output wire SUM,
            output wire CO
        );


        assign SUM =  A ^ B ^ CI; //^ is xor
        assign CO = (A & B) | (A & CI) | (B & CI);
endmodule 
