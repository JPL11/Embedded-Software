`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/02 14:40:30
// Design Name: 
// Module Name: binary_to_bcd_converter
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


module binary_to_bcd_converter(
                                     input [7:0] number,  
                                     output reg [3:0] ones,                    
                                     output reg [3:0] tens                       
                                );
           
           reg [15:0] shift;
           integer i;
           
           
           always@(number)
            begin
               shift[15:8] = 0; 
               shift[7:0] = number;             
                           
                   for (i=0; i<8; i=i+1)
                        begin
                            if(shift[11:8] > 4)
                                shift[11:8] = shift[11:8] +3; //ones
                            
                            if(shift[15:12] > 4)
                                shift[15:12] = shift[15:12] +3; //tens
                                                                              
                             shift = shift <<1;   
                        end
              
                  ones = shift[11:8];                       
                  tens = shift[15:12];
                                               
            end           
endmodule
