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
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output reg VGA_HS,
    output reg VGA_VS,
    output reg music_play
    );
    
    // register variables
    
    wire start;
    wire [9:0] x;
    wire [8:0] y;
    wire click;
    wire [7:0] tap;
    
    reg [1:0] difficulty;
    wire [7:0] holes;
    wire [11:0] score;
    wire [4:0] time_display;
    wire pause;
    wire [7:0] tap;
    
    //all modules
    
    time_counter time_30_sec(.clk(clk),.start(start),.time_display(time_display),.pause(pause));
    
    music music_background(.clk(clk),.sound(music_play));
    
   //vga vga_display(.in_clk(clk),.reset(reset),.holes(holes),.VGA_R(VGA_R),.VGA_G(VGA_G),.VGA_B(VGA_B),.VGA_HS(VGA_HS),.VGA_VS(VGA_VS));
  
     //mouse mouse_decoder(.mouse(mouse),.x(x),.y(y),.click(click));
  
    game_logic game(.clk(clk),.pause(pause),.tap(tap),.start(start),.difficulty(difficulty),.holes(holes),.score(score));
    
endmodule
