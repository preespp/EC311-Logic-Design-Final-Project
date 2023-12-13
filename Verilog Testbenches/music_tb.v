`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 12:24:10 PM
// Design Name: 
// Module Name: music_tb
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


module music_tb(

    );

reg clk;
wire [22:0] sound;

music music1(
  .clk(clk),
  .sound(sound)
);

always #1 clk = ~clk;

initial #1000000 $finish;

initial begin 
#1 clk = 0;
end

endmodule