`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 14:20:37
// Design Name: 
// Module Name: top_tb
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


module top_tb(

            );
            
            reg clk, sel_reg, rstReg1, rstReg2;
            reg [15:0] SW;
            wire LEDforReg, DP;
            wire [7:0] anode;
            wire [6:0] cathode;
           

top test1(
                     .clk(clk),
                     .rstReg1(rstReg1),
                     .rstReg2(rstReg2),
                     .sel_reg(sel_reg),
                     .SW(SW),
                     .LEDforReg(LEDforReg),
                     .DP(DP),
                     .anode(anode),
                     .cathode(cathode)
                     
             );           
            
        always
            begin
                clk = 1;
                forever #5 clk = ~clk; 
            end    
            
        initial 
            begin
                sel_reg = 1'b0; //using register1
                rstReg1 = 1'b0;
                rstReg2 = 1'b0;
                SW = 16'h0F00;
            #20 //rotate left
                sel_reg = 1'b1; //using register2
                SW = 16'h3800; //manual, no load, rotating left 8bit   
            #20                   
                SW = 16'h2800; //manual, no load, rotating right 8bit       
            #20   
                SW = 16'h1C00;   //manual, no load, shifting left 12bit 
            #20   
                SW = 16'h0C00;   //manual, no load, shifting right 12bit
            #20
               rstReg1 = 1'b1; //reset Reg1
               rstReg2 = 1'b1; //reset Reg2
            #20
                rstReg1 = 1'b0; 
                rstReg2 = 1'b0;
                sel_reg = 1'b0; //using reg1
                SW = 16'hF0F0; //giving this number to reg1
            #20
                sel_reg = 1'b1;  //using reg2  
            #20
               SW = 16'h8800; //Auto, no load, shiftright 8bit
            #20
                SW = 16'hC100; //Auto, load 1, shiftright 
            #20
                $finish;            
                    
            end
                
            
            
endmodule
