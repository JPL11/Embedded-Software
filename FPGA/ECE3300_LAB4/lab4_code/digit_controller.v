`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/02 14:35:48
// Design Name: 
// Module Name: digit_controller
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


module digit_controller(
                            input refreshcounter,
                            input [3:0] ones, tens,
                            output reg [3:0] digit                         
                        );
                    
                    initial 
                        digit = 0;
                        
        always@(refreshcounter)
            begin
                case(refreshcounter)
                    1'b0: digit = ones;
                    1'b1: digit = tens;
                endcase       
            end                                           
endmodule
