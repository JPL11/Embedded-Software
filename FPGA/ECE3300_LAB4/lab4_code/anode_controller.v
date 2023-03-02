`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/02 14:28:35
// Design Name: 
// Module Name: anode_controller
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


module anode_controller(
                                input refreshcounter,
                                output reg [7:0] AN //anode
                        );
                        
                 //set anode initially 0
                 initial
                 AN = 0;
                  
                 always@(refreshcounter)
                    begin
                        case(refreshcounter)
                            1'b0: AN = 8'b11111110;
                            1'b1: AN = 8'b01111111;
                        endcase
                    end                                    
endmodule
