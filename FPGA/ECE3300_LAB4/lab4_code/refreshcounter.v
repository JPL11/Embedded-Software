`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/02 14:21:36
// Design Name: 
// Module Name: refreshcounter
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


module refreshcounter(
                            input refresh_clock,
                            output reg refreshcounter
                    );
        initial 
            refreshcounter = 0;
                
        always@(posedge refresh_clock) 
            begin
               refreshcounter <= refreshcounter +1;  
            end                                       
endmodule
