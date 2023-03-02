`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 16:13:13
// Design Name: 
// Module Name: ssd
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


`define anodeOn 8'hFF                   //AnodeON definition
`define initialDisplay 8'hFF            //initial 7-seg display definition 
`define DPOff 1'b0                      //DP is off definition

module ssd(
        input clk,                      //clock
        input reset,                    //reset
        input [31:0] in,                //input of size 32
        output DP,                      //decimal
        output reg [7:0] anode,         //anode for 7-segment
        output reg [6:0] AtoG           //AtoG for 7-segment conversion
            );
            
        wire [2:0] displaySelect;       //select the display
        wire [7:0] anodeEn;             //anode enable
        reg [3:0] digitDisplay = 0;     //which digit to display (4-bit)
        reg [19:0] clkCounter = 0;      //clock counter register for setting speeds
        
        assign DP = `DPOff;                             //set decimal point to be off
        assign displaySelect = clkCounter[19:17];       //clock counter register
        assign anodeEn = `initialDisplay;               //initial display
        
        //clock counter block
        always@(posedge clk)
            begin
                if(reset)
                    clkCounter <= 0;
                else
                    clkCounter <= clkCounter + 1;
            end
         
        always@(anodeEn, displaySelect)
            begin
                anode = `anodeOn;
                if(anode[displaySelect])
                    anode[displaySelect] = 1'b0;
            end
            
        //always block for input and display select
        always@(in, displaySelect)
            begin
                //case for display select
                case(displaySelect)
                    3'b000:     digitDisplay = in[3:0];
                    3'b001:     digitDisplay = in[7:4];
                    3'b010:     digitDisplay = in[11:8];
                    3'b011:     digitDisplay = in[15:12];
                    3'b100:     digitDisplay = in[19:16];
                    3'b101:     digitDisplay = in[23:20];
                    3'b110:     digitDisplay = in[27:24];
                    3'b111:     digitDisplay = in[31:28];
                    default:    digitDisplay = 4'bZZZZ;
                 endcase
             end
         
         //always block for digit to display
         always@(digitDisplay)
            begin
                case(digitDisplay)
                    0:          AtoG <= 7'b000_0001;
                    1:          AtoG <= 7'b100_1111;
                    2:          AtoG <= 7'b001_0010;
                    3:          AtoG <= 7'b000_0110;
                    4:          AtoG <= 7'b100_1100;
                    5:          AtoG <= 7'b010_0100;
                    6:          AtoG <= 7'b010_0000;
                    7:          AtoG <= 7'b000_1111;
                    8:          AtoG <= 7'b000_0000;
                    9:          AtoG <= 7'b000_0100;
                 4'hA:          AtoG <= 7'b000_1000;
                 4'hB:          AtoG <= 7'b110_0000;
                 4'hC:          AtoG <= 7'b011_0001;
                 4'hD:          AtoG <= 7'b100_0010;
                 4'hE:          AtoG <= 7'b011_0000;
                 4'hF:          AtoG <= 7'b011_1000;
                 default:       AtoG <= 7'bZZZ_ZZZZ;
              endcase
          end
endmodule
