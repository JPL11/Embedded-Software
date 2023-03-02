`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/02 14:09:38
// Design Name: 
// Module Name: clock_divider
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

//this module is to create clock divider to be used for seven segement display
module clock_divider#(parameter div_value = 4999) //Global parameter, this can be changed in top module
                      (
                            input clk, //100MZ
                            output reg divided_clk =0
                     );
           
           integer count = 0;
           
           always@(posedge clk)
            begin
                if(count == div_value)
                    begin
                        divided_clk <= ~divided_clk;
                        count <= 0;
                    end      
                else
                    begin
                        divided_clk <= divided_clk;
                        count <= count +1;
                    end                                    
            end
                      
                     
endmodule