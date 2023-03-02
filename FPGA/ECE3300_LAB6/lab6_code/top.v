`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 13:02:21
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


module top(
                    input clk,
                    input rstReg1,
                    input rstReg2,
                    input sel_reg,
                    input [15:0] SW,
                    output LEDforReg,
                    output DP,
                    output [7:0] anode,
                    output [6:0] cathode
             );
                        
    assign LEDforReg = sel_reg ? 1:0 ;
    
    wire [15:0] output_barrelshifter;
    wire [15:0] output_shifted;
    wire [7:0] autoORmanual;
    wire [3:0] level;
  
   
    
    
     nbit_register #(.SIZE(16)) REG1(
        .clk(clk),
        .in(SW),
        .en(~sel_reg),
        .rst(rstReg1),
        .out(output_barrelshifter)
    );
    
    nbit_register #(.SIZE(8)) REG2(
        .clk(clk),
        .in({SW[15:12], SW[11:8]}),
        .en(sel_reg),
        .rst(rstReg2),
        .out(autoORmanual)
    );
    
    weird_4bit_counter COUNTER(
        .clk(clk),
        .autoORmanual(autoORmanual[7]),
        .load(autoORmanual[6]),
        .in(autoORmanual[3:0]),
        .out(level)
    );
    
    nbit_barrelshifter #(.SIZE(16)) BARREL(
        .RorS(autoORmanual[5]),
        .LorR(autoORmanual[4]),
        .howmany(level),
        .in(output_barrelshifter),
        .out(output_shifted)
    );
    
    seven_seg_controller SEVEN_SEG(
        .clk(clk),  
        .in(output_shifted),
        .DP(DP),
        .anode(anode),
        .cathode(cathode)
    );
    
endmodule
