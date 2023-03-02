LAB2 - 4 to 16 decoder

ECE3300L.02 - Summer 2022

Group A : Jihun Choi(Bronco ID#: 011841206) 

LAB2 description: 

4 to 16 decoder is designed by using vivado software and test the results with FPGA. Input ‘in’ is 4 bits, Input ‘enable’ which is an enable line is just 1 bit, and  Output ‘out’ is  16 bits. The function of 4 to 16 decoder is pretty simple. When the enable line equals ‘0’, the decoder is off. Even if we feed any 4 bits input, output will be simply zero(16b’0000000000000000). And when the enable line equals ‘1’, the decoder is on. 


Since it is on, 

if we feed input ‘in’ as 0000, output ‘out’ equals ‘16b’0000000000000001’.

if we feed input ‘in’ as 0001, output ‘out’ equals ‘16b’0000000000000010’.

if we feed input ‘in’ as 0010, output ‘out’ equals ‘16b’0000000000000100’.

                                     .                                 
                                     .
                                     .
                                     
                                  (continued)
                                  
if we feed input ‘in’ as 1110, output ‘out’ equals ‘16b’0100000000000000’.

if we feed input ‘in’ as 1111, output ‘out’ equals ‘16b’1000000000000000’.



Video demonstartion Link:

https://youtu.be/wUiby-y5p4M

or

https://drive.google.com/file/d/16Se2DlpeUQATIBwV22T7ARjVBSh67f6d/view?usp=sharing


