`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/11 15:58:14
// Design Name: 
// Module Name: calculator
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


module calculator(
                        input [3:0] A, B,
                        input sign_A, sign_B,
                        input [1:0] mode,
                        output reg [7:0] result,
                        output reg result_sign
                );
     //need to include A,B, sign_A, sign_B           
      always@ (*)
        begin
            case (mode)
                2'b00:  //Addition
                    begin                                                         
                       if(sign_A == 1 && sign_B == 0 && ( A > B ) )  //0 is positive, 1 is negative                      
                            begin
                                result_sign = 1;
                                result = A - B;
                            end    
                            
                        else if(sign_A == 1 && sign_B == 0 && ( A < B ) ) //0 is positive, 1 is negative                       
                            begin
                                result_sign = 0;
                                result = B - A;
                            end        
                            
                         else if(sign_A == 0 && sign_B == 1 && ( A > B ) )  //0 is positive, 1 is negative                      
                            begin
                                result_sign = 0;
                                result = A - B;
                            end    
                            
                        else if(sign_A == 0 && sign_B == 1 && ( A < B ) ) //0 is positive, 1 is negative                       
                            begin
                                result_sign = 1;
                                result = B - A;
                            end               
                        else if(sign_A ==1 && sign_B ==0)    
                             begin
                                result_sign = 1;
                                result = A - B;
                             end    
                       
                        else if(sign_A ==0 && sign_B ==1)    
                             begin
                                result_sign = 0;
                                result = A - B;
                             end  
                         else if(sign_A == 1 && sign_B == 1) //0 is positive, 1 is negative                  
                            begin
                                result_sign = 1;
                                result = A + B;
                            end         
                         else if(sign_A == 0 && sign_B == 0) //0 is positive, 1 is negative                  
                            begin
                                result_sign = 0;
                                result = A + B;
                            end           
                              
                                                               
                    end
                    
         
                2'b01:  //Subtraction
                     begin
                        
                        if(sign_A == 0 && sign_B == 0 && (A>B) ) //0 is positive, 1 is negative                  
                            begin
                                result_sign = 0;
                                result = A - B;
                            end    
                        
                        else if(sign_A == 0 && sign_B == 0 && (A<B) ) //0 is positive, 1 is negative                  
                            begin
                                result_sign = 1;
                                result = B-A;
                            end    
                            
                        else if(sign_A == 1 && sign_B == 1 && (A>B) ) //0 is positive, 1 is negative                  
                            begin
                                result_sign = 1;
                                result = A - B;
                            end   
                            
                        else if(sign_A == 1 && sign_B == 1 && (A<B) ) //0 is positive, 1 is negative                  
                            begin
                                result_sign = 0;
                                result = B - A;
                            end     
                        
                        else if(sign_A == 0 && sign_B == 0) //0 is positive, 1 is negative                  
                            begin
                                result_sign = 0;
                                result = A - B;
                            end            
                            
                        else if(sign_A == 1 && sign_B == 1) //0 is positive, 1 is negative                  
                            begin
                                result_sign = 0;
                                result = A - B;
                            end    
                             
                        else if(sign_A ==0 && sign_B ==1)    
                             begin
                                result_sign = 0;
                                result = A + B;
                             end    
                                                                        
                        else if(sign_A ==1 && sign_B ==0)    
                             begin
                                result_sign = 1;
                                result = A + B;
                             end                                                                                                           
                                                                       
                    end   
                    
               2'b10:  //Multiplication
                    begin
                        result = A * B;
                        if(sign_A ==0 && sign_B ==0)    
                            result_sign = 0;
                        else if(sign_A ==0 && sign_B ==1)    
                            result_sign = 1;                                                                                             
                        else if(sign_A ==1 && sign_B ==0)    
                            result_sign = 1;   
                        else if(sign_A ==1 && sign_B ==1)    
                            result_sign = 0;                                                
                    end   
                    
               2'b11:  //division
                     begin
                          result = A / B;
                        if(sign_A ==0 && sign_B ==0)    
                            result_sign = 0;
                        else if(sign_A ==0 && sign_B ==1)    
                            result_sign = 1;                                                                                             
                        else if(sign_A ==1 && sign_B ==0)    
                            result_sign = 1;   
                        else if(sign_A ==1 && sign_B ==1)    
                            result_sign = 0;                                                                                                                                                                     
                    end                    
                
             endcase       
        end
        
endmodule