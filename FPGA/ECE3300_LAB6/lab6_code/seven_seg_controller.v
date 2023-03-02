`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/23 13:01:04
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
                                input clk,
                                input [15:0] in,             
                                output DP,
                                output reg [7:0] anode,
                                output reg [6:0] cathode        
                );
                
                
               assign DP = 1'b1;
               
               wire [1:0] sel;          
               reg [3:0] num = 0;
               reg [19:0] clock_counter = 0;
                
                assign sel = clock_counter[19:18];   
                
                    always@(posedge clk)
                begin
                    clock_counter <= clock_counter+1;
                end
      
             //digit controller                          
                always@(num)
                    begin
                        case(num)
                            0: cathode <= 7'b0000001;
                            1: cathode <= 7'b1001111;
                            2: cathode <= 7'b0010010;
                            3: cathode <= 7'b0000110;
                            4: cathode <= 7'b1001100;
                            5: cathode <= 7'b0100100;
                            6: cathode <= 7'b0100000;
                            7: cathode <= 7'b0001111;
                            8: cathode <= 7'b0000000;
                            9: cathode <= 7'b0000100;
                          'hA: cathode <= 7'b0001000;
                          'hB: cathode <= 7'b1100000;
                          'hC: cathode <= 7'b0110001;
                          'hD: cathode <= 7'b1000010;
                          'hE: cathode <= 7'b0110000;
                          'hF: cathode <= 7'b0111000;
                          default: cathode = 7'b0000000;//0
                       endcase
                    end
                    
            always@(sel)
                begin
                    case(sel)
                    0: anode = 8'b11111110; 
                    1: anode = 8'b11111101; 
                    2: anode = 8'b11111011; 
                    3: anode = 8'b11110111; 
                    endcase
                end
                
             always@(sel, in)
                begin
                    case(sel)
                        0:        num = in[3:0];
                        1:        num = in[7:4];
                        2:        num = in[11:8];
                        3:        num = in[15:12];
                        default: num = 4'b0000;
                    endcase
                end
                   
                
                    
endmodule
