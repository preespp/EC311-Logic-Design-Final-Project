`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 03:45:11 PM
// Design Name: 
// Module Name: FPGA_testing_tb
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


module FPGA_testing_tb(

    );

    reg clk;
    reg start; // we only include game logic, music, time and testing module
    //we will use button on fpga for testing purpose instead
    reg lft;
    reg rgt;
    reg [7:0] sw;
    wire [7:0] an;
    wire [6:0] a2g;
    wire [7:0] ld;
    //output music_play
    
// for testbench purpose please modify the original file clock before using this testbench (same with time_tb)
// because it will require very long time to simulate the actual 30 sec on this testbench
// change line 48 of time_counter module from 100,000,000 to 1,000
// change setting of simulaion time to 100,000 ns 

Top_Module_FPGA_Testing testing(.clk(clk),.start(start),.lft(lft),.rgt(rgt),.sw(sw),.an(an),.a2g(a2g),.ld(ld));

always #1 clk = ~clk;
always #1 sw = ~sw;

initial
        #100000000 $finish;
initial begin
        #1 clk = 0; sw = 0; start = 0; lft = 0; rgt = 1;
        #1 rgt = 0; start = 1;
        #5 start = 0;
        #65000 start = 1;
        #1 start = 0;
    end
  


    endmodule