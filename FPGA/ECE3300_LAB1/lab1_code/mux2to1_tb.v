`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/08 15:42:37
// Design Name: 
// Module Name: mux2to1_tb
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


module mux2to1_tb(

                );
                
                reg [3:0] a_in;
                reg [3:0] b_in;
                reg sel_in;
                
                wire [3:0] led;
                
                mux2to1 M (
                        .a(a_in),
                        .b(b_in),
                        .sel(sel_in),
                        .f(led)
                            );
        initial
            begin
                    a_in =4'b0101;
                    b_in =4'b1001;
                    sel_in = 0;
                    #20
                    
                    a_in =4'b0101;
                    b_in =4'b1001;
                    sel_in = 1;
                    #20
                    
                    a_in =4'b0001;
                    b_in =4'b0011;
                    sel_in = 0;
                    #20
                    
                    a_in =4'b0001;
                    b_in =4'b0011;
                    sel_in = 1;
                    #20
                    
                    $finish;
                 
                end                       
           
endmodule
