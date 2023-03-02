`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 16:47:13
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


module top_tb();
reg clk, en, reset, load, upDown;
reg [2:0] loadSelect;
reg [3:0] loadValue;
reg [5:0] speed;
wire DP_tb, loadLED_tb, enLed_tb, upDownLED_tb;
wire [6:0] AtoG;
wire [7:0] anode;
wire [31:0] output_tb;

top test1(
                .clk(clk),                  
                .en(en),                   
                .reset(reset),                
                .load(load),                 
                .upDown(upDown),              
                .loadSelect(loadSelect),     
                .loadValue(loadValue),      
                .speed(speed),          
                .DP(DP_tb),                  
                .loadLED(loadLED_tb),                       
                .enLED(enLed_tb),               
                .upDownLED(upDownLED_tb),           
                .AtoG(AtoG),         
                .anode(anode),         
                .output_tb(output_tb)
            );
            
integer i=0;

always
    begin
        clk = 1;
        forever #5 clk = ~clk;       
    end
    
    initial 
        begin
            en = 1'b0;
            reset = 1'b0;
            load = 1'b0;
            upDown = 1'b1; //counting up
            loadSelect = 3'b000;
            loadValue = 4'b0000;
            speed = 5'b00000;
            
       #2000
        en = 1'b1; //checking enable
       #2000
        upDown = 1'b0; //checking counting down
       #5000
        reset = 1'b1; //checking reset
       #2000
         reset = 1'b0; //checking load function
         load = 1'b1; //load on
         loadValue = 4'b0111; //loading 7
         for(i=0; i<8; i=i+1) //loading all 8 seven seg with 7
            begin
                loadSelect = i;
                #5;
            end         
        #2000
            load = 1'b0; //load off
            //counting down currently
        #2000 
            for(i=0; i<20; i=i+1) //testing different speed of clk 
                begin
                    speed = i;
                    @(posedge clk);                   
                end
         #5000000      
       $finish;       
               
        end
        
                
            
endmodule
