`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 04:39:59 PM
// Design Name: 
// Module Name: Top_Module
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


module Top_Module(
    input wire clk,
    input wire mouse,
    output reg VGA_output,
    output reg music_play
    );
    
    // register variables
    
    reg [4:0] time_display;
    reg time_signal;
    reg start;
    reg [9:0] x;
    reg [8:0] y;
    reg click;
    
    //all modules
    
   //mouse mouse_decoder(.mouse(mouse),.x(x),.y(y),.click(click));
    time_counter time_30_sec(.clk(clk),.start(start),.time_display(time_display),.time_signal(time_signal));
    music music_background(.clk(clk),.music_play(music_play));
  //vga vga_display(.x(x),.y(y),.click(click),.clk(clk),.holes(holes),.score(score),.tap(tap),.difficulty(difficulty),.start(start),.VGA_output(VGA_output));
    game_logic game(.clk(clk),.tap(tap),.start(start),.difficulty(difficulty),.holes(holes),.score(score));
    
endmodule
