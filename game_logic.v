`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 05:01:53 PM
// Design Name: 
// Module Name: game_logic
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


module game_logic(
    input  wire clk,        // clock (50MHz)
    input  wire pause,
    input  wire [7:0] tap,  // 8 switch hit input

    input  wire start,        // button - start (original code is clr)
    input  wire [3:0]  difficulty,       // difficulty of easy medium hard
    output [7:0] holes,   // holes that have moles pop up
    output [11:0] score  
    );

    reg  [31:0] clk_cnt;    // clock count
    reg  clk_19;            // clock at 2^19 (100Hz)
    wire cout0;             // carry signal

    wire [7:0]  hit;        // 8 successful hit

    // handle clock
    always @(posedge clk) begin
        if(start) begin      // DO NOT clear main clock as it is seed of randomizer
             clk_cnt = 0;
        end
        else begin
        clk_cnt = clk_cnt + 1;
        if(clk_cnt[31:28]>15) begin
            clk_cnt = 0;
    end
end
end


//clk_19 handle
// we found out that our time counter code will conflict with pse_flag of the original code
// our pause signal will flip it everytime we start new rounds which makes our game playable only for 1st,3th,5th time we press the start button
//therefore, we delete pse_flag and replaceit with pause signal directly

    always @ (posedge clk) begin
        if (!pause)
            clk_19 = clk_cnt[19];
    end

    // generate moles based on difficulty
    wam_gen sub_gen( .clk_19(clk_19), .clr(start), .clk_cnt(clk_cnt), .hit(hit), .hrdn(difficulty), .holes(holes) );

    // check if the user hit them or not
    wam_hit sub_hit( .clk_19(clk_19), .tap(tap), .holes(holes), .hit(hit));

    // handle score count
    wam_scr sub_scr( .clk(clk), .clr(start), .hit(hit), .num(score), .cout0(cout0) );

endmodule

