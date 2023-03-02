`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/11 15:18:52
// Design Name: 
// Module Name: diplay_controller
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


module diplay_controller(
                            input [2:0] clock,
                            input [3:0] portA, portB,
                            input signA, signB,
                            input [1:0] mode, //4 different mode
                            input [3:0] result_ones, result_tens,
                            input result_sign,
                            output reg [6:0] cathode, //a~g
                            output reg [7:0] anode //8seven seg available                       
                        );
          
          //create refresh counter for diplay controller
         reg [3:0] refresh_counter = 0;
         always@ (posedge clock)
            begin
                refresh_counter <= ( refresh_counter +1 );
                if (refresh_counter > 7)
                    refresh_counter <= 0 ;
            end      
                  
        //annode controller    
         always@ (refresh_counter)
            begin
                case (refresh_counter)
                    3'b000: anode = 8'b11111110;
                    3'b001: anode = 8'b11111101;
                    3'b010: anode = 8'b11111011;
                    3'b011: anode = 8'b11110111;
                    3'b100: anode = 8'b11111111; //not using this seven seg
                    3'b101: anode = 8'b11011111;
                    3'b110: anode = 8'b10111111;
                    3'b111: anode = 8'b01111111;
                endcase     
            end
         
         //digit controller
         reg [3:0] num = 0;
         reg [3:0] signA_temp = 0, signB_temp = 0;
         reg [3:0] result_sign_temp =0;
         always@ (clock)
            begin
                case (signA)
                    1'b0: signA_temp = 4'd10;
                    1'b1: signA_temp = 4'd11;
                endcase
                
                case (signB)
                    1'b0: signB_temp = 4'd10;
                    1'b1: signB_temp = 4'd11;
                endcase
                
                case (result_sign)
                    1'b0: result_sign_temp = 4'd10;  
                    1'b1: result_sign_temp = 4'd11;
                                    
                endcase
                
                case (refresh_counter)
                    3'b000: num = portB;
                    3'b001: num = signB_temp;
                    3'b010: num = portA;
                    3'b011: num = signA_temp;
                    3'b100: num = 8'b00000000;
                    3'b101: num = result_ones;
                    3'b110: num = result_tens;
                    3'b111: num = result_sign_temp;
                endcase
            end
            
            //bcd to cathode
            always@ (num)
                begin
                    case (num)
                        0: cathode = 7'b0000001;
                        1: cathode = 7'b1001111;
                        2: cathode = 7'b0010010;
                        3: cathode = 7'b0000110;
                        4: cathode = 7'b1001100;
                        5: cathode = 7'b0100100;
                        6: cathode = 7'b0100000;
                        7: cathode = 7'b0001111;
                        8: cathode = 7'b0000000;
                        9: cathode = 7'b0000100;      
                        10: cathode = 7'b0110010;   //postive sign
                        11: cathode = 7'b1001110;   //negative sign
                        default: cathode = 7'b0000001;
                     endcase
                end
                
                        
endmodule
