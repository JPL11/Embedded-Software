`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 16:11:41
// Design Name: 
// Module Name: demux1by8
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


//Demultiplexer module
module demux1by8(
                input en,                           //enable
                input [2:0] loadSelect,             //load selector for top module
                input [3:0] loadValue,              //which value to load in (4-bit)
                output reg [7:0] enOut,             //enable output value
                output reg [31:0] out               //output value, for top module BCD counter
            );
            
            //always block to repetitively occur
            always@(*)
                begin
                    //if enable is true, continue
                    if(en) begin
                        //case statement on load select value
                        case(loadSelect)
                            3'b000:     begin out = loadValue       ;   enOut = 8'b0000_0001; end
                            3'b001:     begin out = loadValue << 4  ;   enOut = 8'b0000_0010; end
                            3'b010:     begin out = loadValue << 8  ;   enOut = 8'b0000_0100; end
                            3'b011:     begin out = loadValue << 12 ;   enOut = 8'b0000_1000; end
                            3'b100:     begin out = loadValue << 16 ;   enOut = 8'b0001_0000; end
                            3'b101:     begin out = loadValue << 20 ;   enOut = 8'b0010_0000; end
                            3'b110:     begin out = loadValue << 24 ;   enOut = 8'b0100_0000; end
                            3'b111:     begin out = loadValue << 28 ;   enOut = 8'b1000_0000; end
                            default:    begin out = 0;  enOut = 0; end
                        endcase
                     end
                     //if enable is not true, continue
                    else begin
                        out = 'b0;
                        enOut = 'b0;
                     end
                 end
endmodule
