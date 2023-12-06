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
    input  wire [7:0] tap,  // 8 switch hit input

    input  wire start,        // button - start (original code is clr)
    input  wire [3:0]  difficulty,       // difficulty of easy medium hard
    output wire [7:0] holes,   // holes that have moles pop up
    output wire [11:0] score  
    );

    reg  [31:0] clk_cnt;    // clock count
    reg  clk_19;            // clock at 2^19 (100Hz)
    reg pse = 0;            // our project doesn't have pause button therefore, we set this signal as 0
    reg  pse_flg;           // pause flag
    wire cout0;             // carry signal




    wire [7:0]  hit;        // 8 successful hit

    // handle clock
    always @(posedge clk) begin
        // if(clr)          // DO NOT clear main clock as it is seed of randomizer
        //     clk_cnt = 0;
        // else begin
        clk_cnt = clk_cnt + 1;
        if(clk_cnt[31:28]>15)
            clk_cnt = 0;
    end


    // handle pause for clk_19
    always @ (posedge pse) begin
        pse_flg = ~pse_flg;
    end

    always @ (posedge clk) begin
        if (!pse_flg)
            clk_19 = clk_cnt[19];
    end

    // generate moles based on difficulty
    wam_gen sub_gen( .clk_19(clk_19), .clr(start), .clk_cnt(clk_cnt), .hit(hit), .hrdn(difficulty), .holes(holes) );

    // check if the user hit them or not
    wam_hit sub_hit( .clk_19(clk_19), .tap(tap), .holes(holes), .hit(hit));

    // handle score count
    wam_scr sub_scr( .clk(clk), .clr(start), .hit(hit), .num(score), .cout0(cout0) );

endmodule

