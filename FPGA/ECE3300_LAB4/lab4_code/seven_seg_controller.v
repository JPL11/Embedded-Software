`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/02 14:58:32
// Design Name: 
// Module Name: seven_seg_controller
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


module seven_seg_controller(
                                    input refresh_clock,
                                    input [3:0] ones, tens,
                                    output [7:0] AN,
                                    output [6:0] cathode                                  
                            );
                            
          wire refreshcounter;
          wire [3:0] digit;
          
          refreshcounter refreshcounter1 (
                                            .refresh_clock(refresh_clock),
                                            .refreshcounter(refreshcounter)
                                         );  
          
          anode_controller anode_controller1(
                                                    .refreshcounter(refreshcounter),
                                                    .AN(AN)
                                            );         
          
          digit_controller digit_controller1(
                                                .refreshcounter(refreshcounter),
                                                .ones(ones),
                                                .tens(tens),                                      
                                                .digit(digit)
                                            );   
                                    
          bcd_to_cathode bcd_to_cathode_converter(
                                                        .digit(digit),
                                                        .cathode(cathode)
                                                );                                                                                
endmodule
