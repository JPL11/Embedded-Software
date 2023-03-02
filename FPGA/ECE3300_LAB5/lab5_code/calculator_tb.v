`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/11 20:27:24
// Design Name: 
// Module Name: calculator_tb
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


module calculator_tb(

                    );
           reg [3:0] portA, portB;
           reg clock =0;
           reg signA, signB = 0;
           reg [1:0] mode;
           wire [7:0] AN;
           wire [6:0] cathode;
           wire DP;
           
           calculator_top cal1test (clock, portA, portB, signA, signB, mode, AN, cathode, DP);
           
           always #5 clock = ~clock;
           initial
            begin             
                    portA = 4'D0;
                    signA = 1'b0;
                    portB = 4'D0;
                    signB = 1'b0;
                    mode = 2'b00;
                 #5 //addtion: a+b, a= + , b= +
                    portA = 4'D5;
                    signA = 1'b0;
                    portB = 4'D7;
                    signB = 1'b0;
                    mode = 2'b00;
                 #5 //addtion: a+b, a= + , b= -
                    portA = 4'D5;
                    signA = 1'b0;
                    portB = 4'D7;
                    signB = 1'b1;
                    mode = 2'b00;   
                 #5 //addtion: a+b, a= - , b= -
                    portA = 4'D5;
                    signA = 1'b1;
                    portB = 4'D7;
                    signB = 1'b1;
                    mode = 2'b00;  
                 #5 //addtion: a+b, a= - , b= +
                    portA = 4'D5;
                    signA = 1'b1;
                    portB = 4'D7;
                    signB = 1'b0;
                    mode = 2'b00;         
                
                
                 #5 //subtraction: a-b, a= + , b= +
                    portA = 4'D5;
                    signA = 1'b0;
                    portB = 4'D7;
                    signB = 1'b0;
                    mode = 2'b01;
                 #5 //subtraction: a-b, a= + , b= -
                    portA = 4'D5;
                    signA = 1'b0;
                    portB = 4'D7;
                    signB = 1'b1;
                    mode = 2'b01;   
                 #5 //subtraction: a-b, a= - , b= -
                    portA = 4'D5;
                    signA = 1'b1;
                    portB = 4'D7;
                    signB = 1'b1;
                    mode = 2'b01;  
                 #5 //subtraction: a-b, a= - , b= +
                    portA = 4'D5;
                    signA = 1'b1;
                    portB = 4'D7;
                    signB = 1'b0;
                    mode = 2'b01;   
                 
                 
                 #5 //multiplication: a*b, a= + , b= +
                    portA = 4'D5;
                    signA = 1'b0;
                    portB = 4'D7;
                    signB = 1'b0;
                    mode = 2'b10;
                 #5 //multiplication: a*b, a= + , b= -
                    portA = 4'D5;
                    signA = 1'b0;
                    portB = 4'D7;
                    signB = 1'b1;
                    mode = 2'b10;   
                 #5 //multiplication: a*b, a= - , b= -
                    portA = 4'D5;
                    signA = 1'b1;
                    portB = 4'D7;
                    signB = 1'b1;
                    mode = 2'b10;  
                 #5 //multiplication: a*b, a= - , b= +
                    portA = 4'D5;
                    signA = 1'b1;
                    portB = 4'D7;
                    signB = 1'b0;
                    mode = 2'b10;
                    
                 #5 //division: a/b, a= + , b= +
                    portA = 4'D9;
                    signA = 1'b0;
                    portB = 4'D3;
                    signB = 1'b0;
                    mode = 2'b11;
                 #5 //division: a/b, a= + , b= -
                    portA = 4'D9;
                    signA = 1'b0;
                    portB = 4'D3;
                    signB = 1'b1;
                    mode = 2'b11;   
                 #5 //division: a/b, a= - , b= -
                    portA = 4'D9;
                    signA = 1'b1;
                    portB = 4'D3;
                    signB = 1'b1;
                    mode = 2'b11;  
                 #5 //division: a/b, a= - , b= +
                    portA = 4'D9;
                    signA = 1'b1;
                    portB = 4'D3;
                    signB = 1'b0;
                    mode = 2'b11;                                                                             
                #10
                $finish;    
            end
            
endmodule
