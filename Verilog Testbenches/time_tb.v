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


// for testbench purpose please modify the original file clock before using this testbench
// because it will require very long time to simulate the actual 30 sec on this testbench
// change line 48 of time_counter module from 100,000,000 to 1,000
// change setting of simulaion time to 100,000 ns 

module time_tb(

    );
    reg clk;
    reg start;
    wire [4:0] time_display;
    wire pause;
    
  time_counter testtime (
    .clk(clk),
    .start(start),
    .time_display(time_display),
    .pause(pause)
); 
  
  
  // Clock generator
always #1 clk = ~clk;

initial
        #100000000 $finish;
initial begin
        #1 clk = 0; start = 0;
        #1 start = 1;
        #5 start = 0;
        #65000 start = 1;
        #1 start = 0;
    end
  
endmodule
