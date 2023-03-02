`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/02 14:47:03
// Design Name: 
// Module Name: bcd_to_cathode
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


module bcd_to_cathode(
                            input [3:0] digit,
                            output reg [6:0] cathode
                    );
         
         initial 
            cathode = 0;
            
         always@(digit)
            begin
                case(digit)
                     0: cathode = 7'b0000001;
                     1: cathode = 7'b1001111;
                     2: cathode = 7'b0010010;
                     3: cathode = 7'b0000110;
                     4: cathode = 7'b1001100;
                     5: cathode = 7'b0100100;
                     6: cathode = 7'b0100000;
                     7: cathode = 7'b0001111;
                     8: cathode = 7'b0000000;
                     9: cathode = 7'b0000100;                        
                     default: cathode = 7'b0000001;
                 endcase    
            end                                        
endmodule

