`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 04:04:49 PM
// Design Name: 
// Module Name: game_logic_tb
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


module game_logic_tb(

    );
    reg clk;
    reg pause;
    reg [7:0] tap;
    reg start;
    reg [3:0] difficulty;
    wire [7:0] holes;
    wire [11:0] score;
    
game_logic game(.clk(clk),.pause(pause),.tap(tap),.start(start),.difficulty(difficulty),.holes(holes),.score(score));

    always #1 clk = ~clk;
initial
        #1000 $finish;
initial begin
        #1 clk = 0; pause = 1; start = 0; tap = 7'b0010101; difficulty = 3'b001;
        #1 start = 1; pause = 0;
        #5 start = 0;
        #24 pause = 1;
        #5 start = 1; pause = 0;
        #1 start = 0;
        #24 pause = 1;
    end
endmodule