`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/24 01:56:43
// Design Name: 
// Module Name: top_testbench
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


module top_testbench 
        #(parameter SIZE_tb=16)(

                                     );
        
        reg [SIZE_tb-1:0] in_tb;
        reg sel_tb;
        reg CI_tb;       
        wire [SIZE_tb-1:0] SUM_tb;
        wire CO_tb;          
       
      //We can change the size by changing number inside .SIZE()            
      top  #(.SIZE(SIZE_tb)) Test1 (
                                    .in(in_tb),
                                    .sel(sel_tb),
                                    .CI(CI_tb),
                                    .SUM(SUM_tb),
                                    .CO(CO_tb)
                                 );       
       
       initial
            begin
                               
                 CI_tb =  1'b0;                
                 in_tb = 16'd3;
                 sel_tb = 1'b0;
                 
                 #10
                 in_tb = 16'd16;
                 sel_tb = 1'b1;
                                 
                 #10
                 CI_tb = 1'b1;
                 in_tb = 16'd16;
                 sel_tb = 1'b0;
                 
                 #10
                 in_tb=16'd104;
                 sel_tb = 1'b0;
                 
                 #10
                 CI_tb = 1'b0;
                 in_tb=16'd30;
                 sel_tb = 1'b1;
                
                            
                 #10
                $finish;
            end                          
                                 
endmodule

