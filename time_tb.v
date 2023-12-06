`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 03:42:46 PM
// Design Name: 
// Module Name: time_tb
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


module time_tb(

    );
    reg clk;
    reg start;
    wire [4:0] time_display;
    wire time_signal;
    
  time_counter testtime (
    .clk(clk),
    .start(start),
    .time_display(time_display),
    .time_signal(time_signal)
); 
  
  
  // Clock generator
always #1 clk = ~clk;

initial
        #100000000 $finish;
initial begin
        #1 clk = 0; start = 0;
        #1 start = 1;
        #1 start = 0;
        #8000 start = 1;
        #8001 start = 0;
    end
  
endmodule
