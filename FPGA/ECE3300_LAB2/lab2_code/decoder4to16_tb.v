`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/16 13:26:33
// Design Name: 
// Module Name: decoder4to16_tb
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


module decoder4to16_tb(

                        );
                        reg [3:0] in_tb;
                        reg enable_tb;
                     
                        wire [15:0] led;
                        
                        decoder4to16 D (
                                            .in(in_tb),
                                            .enable(enable_tb),
                                            .out(led)
                                        );
                                        
          initial
            begin: test_case_1
                    enable_tb =1'b0;
                    in_tb =4'b0101;
                   
                    #10
                    
                    enable_tb =1'b0;
                    in_tb =4'b1101;
                   
                    #10
                    
                    enable_tb =1'b0;
                    in_tb =4'b1100;
                   
                    #10
                    
                    enable_tb =1'b0;
                    in_tb =4'b0001;
                   
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b0000;
                   
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b0001;
              
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b0010;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b0011;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b0100;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b0101;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b0110;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b0111;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b1000;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b1001;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b1010;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b1011;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b1100;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b1101;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b1110;
                    
                    #10
                    
                    enable_tb =1'b1;
                    in_tb =4'b1111;
                    
                    #10
                    $finish;
                 
                end                                             
                                        
endmodule
