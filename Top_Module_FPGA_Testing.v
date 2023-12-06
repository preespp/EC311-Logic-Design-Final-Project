`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 04:52:04 PM
// Design Name: 
// Module Name: Top_Module_FPGA_Testing
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


module Top_Module_FPGA_Testing(
    input wire clk,
    input wire start, // we only include game logic, music, time and testing module
    //we will use button on fpga for testing purpose instead
    input wire lft,
    input wire rgt,
    input wire [7:0] sw,
    output reg [3:0] an,
    output reg [6:0]a2g,
    output reg [7:0]ld,
    output reg music_play,
    output reg [4:0] time_display
    );
    
    // register variables
    reg time_signal;
    reg [8:0] tap;
    
    //all modules
    
    time_counter time_30_sec(.clk(clk),.start(start),.time_display(time_display),.time_signal(time_signal));
    music music_background(.clk(clk),.music_play(music_play));
    game_logic game(.clk(clk),.tap(tap),.start(start),.difficulty(difficulty),.holes(holes),.score(score));
    fpga_test test(.clk(clk),.clr(start),.lft(lft),.rgt(rgt),.holes(holes),.score(score),.sw(sw),.an(an),.a2g(a2g),.ld(ld),.tap(tap));
    
endmodule
