`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 16:09:34
// Design Name: 
// Module Name: BCDUpDownCounter
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

//standard up-down BCD counter
module BCDUpDownCounter(
                input clk,                      //clock
                input en,                       //enable
                input reset,                    //reset                        
                input upDown,                   //up or down
                input load,                     //load
                input [3:0] loadValue,          //value to load in
                output reg rollover = 0,        //register for rollover on 7-segment display
                output reg [3:0] BCDOut = 0     //output for BCD, register of size 4
            );
            
            //always block on rising edge of clock, same for reset and load
            always@(posedge clk, posedge reset, posedge load)
            begin
                //if reset is true, continue
                if(reset) begin
                    //set rollover = 0, set BCD output to 0
                    rollover <= 0;
                    BCDOut <= 'b0;
                end
                //if load is true, continue
                else if(load) begin
                    //if the load value is greater than 9, then set BCD output to 9
                    if(loadValue > 9)
                        BCDOut = 9;
                    else
                        //if load value is less than 9, set BCD output = to load value
                        BCDOut <= loadValue;
                end
                //if enable AND load are both false, continue
                else if(!en && !load) begin
                    //bcd output stays the same
                    BCDOut <= BCDOut;
                end
                else begin
                    //if up or down switch is true
                    if(upDown) begin
                        //we INCREMENT 
                        if(BCDOut < 9) begin
                            rollover <= 0;
                            BCDOut <= BCDOut + 1;
                        end
                        else begin
                            BCDOut <= 0;
                            rollover = 1;
                        end
                     end
                    else begin
                        //we DECREMENT
                        if(BCDOut > 0) begin
                            rollover <= 0;
                            BCDOut <= BCDOut - 1;
                        end
                        else begin
                            BCDOut <= 9;
                            rollover = 1;
                         end
                      end
                  end
              end
endmodule
