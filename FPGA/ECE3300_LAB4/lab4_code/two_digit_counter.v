`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/02 14:53:57
// Design Name: 
// Module Name: two_digit_counter
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


module two_digit_counter(
                                input clk, enable, reset,
                                output reg [7:0] counter
                         );
         initial
            counter = 0;
                 
         always@(posedge clk)
            begin
            
                if (enable == 0)
                    begin
                        counter <= counter;
                    end
                    
                if (enable == 1)
                    begin
                        counter <= counter+1;
                            if(counter > 99)
                                begin
                                    counter <= 0;
                                end
                    end 
                    
                if (reset ==1)
                    begin
                        counter <= 0;
                    end     
                                             
            end
                                  
endmodule