`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 16:12:39
// Design Name: 
// Module Name: nbitUpDownBCD
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


module nbitUpDownBCD(
                input clk,                      //clokc
                input en,                       //enable
                input reset,                    //reset
                input upDown,                   //input to select up or down
                input [31:0] loadValue,         //value to load in
                input [7:0] loadSelect,         //load select
                output loadFeed,                //load feedback
                output [31:0] out               //output
            );
            
            //rollover for numbers "rolling over"
            wire [7:0] rollover;
            
            //load feedback is either loadselect[7] or , etc etc
            assign loadFeed = loadSelect[7] | loadSelect[6] |
                              loadSelect[5] | loadSelect[4] |
                              loadSelect[3] | loadSelect[2] |
                              loadSelect[1] | loadSelect[0];
            
            //call other bcdupdown module (not n-bit)
            BCDUpDownCounter COUNT0(
                .clk(clk),
                .en(en & ~loadFeed),
                .reset(reset),
                .upDown(upDown),
                .loadValue(loadValue[3:0]),
                .load(loadSelect[0]),
                .rollover(rollover[0]),
                .BCDOut(out[3:0])
            );
            
            //generate loop for parametrizing, up until i is 7
            generate
                genvar i;
                for(i=1; i<8; i=i+1) begin
                    BCDUpDownCounter COUNT(
                        .clk(rollover[i-1]),
                        .en(en & ~loadFeed),
                        .reset(reset),
                        .upDown(upDown),
                        .loadValue(loadValue[4*i+3:4*i]),
                        .load(loadSelect[i]),
                        .rollover(rollover[i]),
                        .BCDOut(out[4*i+3:4*i])
                    );
               end
           endgenerate
endmodule
