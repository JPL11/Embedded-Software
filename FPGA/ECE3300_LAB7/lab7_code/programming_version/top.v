`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 16:14:53
// Design Name: 
// Module Name: top
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

//Top Module Code
module top(
                input clk,                  //clock
                input en,                   //enable
                input reset,                //reset
                input load,                 //load
                input upDown,               //up or down
                input [2:0] loadSelect,     //select which to load
                input [3:0] loadValue,      //value to load
                input [4:0] speed,          //speed for clock
                output DP,                  //decimal point
                output loadLED,             //LED for load             
                output enLED,               //LED for enable
                output upDownLED,           //LED for up or down
                output [6:0] AtoG,          //A to G for 7-seg
                output [7:0] anode          //anode for 7-seg             
            );
            
            assign loadLED = load;          //set load LED = to load, to display if switched on
            assign enLED = en;              //set en LED = to enable, to display if switched on
            assign upDownLED = upDown;      //set updownLED = to updown, to display if switched on/off
            assign resetTog = 1'b0;
            
            wire [31:0] muxLoadValue;       //load value for our BIG mux, from the lecture video
            wire [7:0] muxLoadSel;          //selector value for load on BIG mux, from the lecture video
            wire clkDivider;                //clock divider
            wire counterLoadFeed;           //the load feedback for our counter
            wire [31:0] counterOutput;      //the output of our counter
            wire resetTog;                  //toggling reset
            
            //demux instantiation
            demux1by8 DEMUX(
                .en(load),
                .loadSelect(loadSelect),
                .loadValue(loadValue),
                .out(muxLoadValue),
                .enOut(muxLoadSel)
            );
            
            //clock speend instantiation
            clockSpeedController CLKSPEED(
                .clk(clk),
                .en(en),
                .clkSpeed(speed),
                .clkDivider(clkDivider)
            );
            
            //nbit Up-Down BCD counter instantiation
            nbitUpDownBCD COUNT(
                .clk(clkDivider),
                .en(en),
                .reset(reset),
                .upDown(upDown),
                .loadValue(muxLoadValue),
                .loadSelect(muxLoadSel),
                .loadFeed(counterLoadFeed),
                .out(counterOutput)
            );
            
            //7-segment display instantiation
            ssd SSD(
                .clk(clk),
                .reset(resetTog),
                .in(counterOutput),
                .DP(DP),
                .anode(anode),
                .AtoG(AtoG)
            );
            
            
endmodule
