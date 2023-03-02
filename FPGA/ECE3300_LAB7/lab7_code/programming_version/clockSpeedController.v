`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 16:11:03
// Design Name: 
// Module Name: clockSpeedController
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


//clock speed module
module clockSpeedController(
            input clk,                  //clock input
            input en,                   //enable input
            input [4:0] clkSpeed,       //clock speed register of size 5 (5 switches)
            output clkDivider           //clock divider
        );
        
        reg [31:0] clkCounter = 0;      //clock counter register (32-bit) for the top module up-down BCD counter
        
        assign clkDivider = clkCounter[clkSpeed];
        
        //always block on rising edge of clock
        always@(posedge clk)
            begin
                //if enable is true, continue
                if(en) begin
                    clkCounter <= clkCounter + 1;
                end
                //if enable is NOT true, continue
                else begin
                    clkCounter <= clkCounter;
                end
             end
endmodule
