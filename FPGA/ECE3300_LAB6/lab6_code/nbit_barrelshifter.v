`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 13:00:11
// Design Name: 
// Module Name: nbit_barrelshifter
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


module nbit_barrelshifter #(parameter SIZE = 8)
(
        input RorS,   //Rotate or Shift
        input LorR,   //left or right
        input [$clog2(SIZE)-1:0] howmany, //log2 function
        input [SIZE-1:0] in,
        output reg [SIZE-1:0] out
);

    
    reg [SIZE-1:0] temp;
    integer i;

   //4 conditions to consider, rotateleft, rotateright, shiftleft, shiftright

    always@(*)
        begin
            temp = in;
            if(RorS && LorR) 
                begin: rotateleft
                    for(i=0; i<howmany; i=i+1)
                        begin
                            temp = { temp[SIZE-2:0], temp[SIZE-1] };
                        end
                        out = temp;  
                end
            else if(RorS && !LorR)
                begin: rotateright
                    for(i=0; i<howmany; i=i+1)
                        begin
                            temp = { temp[0], temp[SIZE-1:1] };
                        end
                        out = temp;                
                end
            else if(!RorS && LorR)
                begin: shiftleft                 
                        out = in << howmany;                
                end  
            else 
                begin: shiftright                 
                        out = in >> howmany;                
                end                                   
        end
        
    
endmodule
