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
    
    wire [4:0] time_display;
    wire start;
    wire [9:0] x;
    wire [8:0] y;
    wire click;
    wire [7:0] tap;
    wire [1:0] difficulty;
    wire [7:0] holes;
    wire [11:0] score;
    wire pause;
    wire [7:0] tap;
    
    //all modules
    
   //mouse mouse_decoder(.mouse(mouse),.x(x),.y(y),.click(click));
    time_counter time_30_sec(.clk(clk),.start(start),.time_display(time_display));
    music music_background(.clk(clk),.music_play(music_play));
  //vga vga_display(.x(x),.y(y),.click(click),.clk(clk),.holes(holes),.score(score),.tap(tap),.difficulty(difficulty),.start(start),.VGA_output(VGA_output));
    game_logic game(.clk(clk),.tap(tap),.start(start),.difficulty(difficulty),.holes(holes),.score(score));
    
endmodule
