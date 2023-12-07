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


module fpga_test(
    input  wire clk,        // clock (50MHz)
    input  wire [4:0] time_display,
    input  wire start,        // button - start
    input  wire pause,      // from time_counter to show state if the game stop or not
    input  wire lft,        // button - change difficulty easier
    input  wire rgt,        // button - change difficulty harder
    input  wire [7:0]  holes,      // 8 holes idicating have moles or not
    input  wire [11:0] score,      // score
    input  wire [7:0] sw,   // switch
    output [7:0] an,   // digital tube - analog
    output [6:0] a2g,  // digital tube - stroke
    output [7:0] ld,    // LED
    output [7:0] tap        // 8 switch hit input
    );

    reg  [31:0] clk_cnt;    // clock count
    wire clk_16;            // clock at 2^16 (800Hz)
    reg  clk_19;            // clock at 2^19 (100Hz)
    reg  pse_flg;           // pause flag
    wire cout0;             // carry signal

    wire [3:0]  difficulty;       // easy medium hard
    
    // handle clock
    always @(posedge clk) begin
        // if(clr)          // DO NOT clear main clock as it is seed of randomizer
        //     clk_cnt = 0;
        // else begin
        clk_cnt = clk_cnt + 1;
        if(clk_cnt[31:28]>15)
            clk_cnt = 0;
    end

    assign clk_16 = clk_cnt[15];

    // handle pause for clk_19
    always @ (posedge pause) begin
        pse_flg = ~pse_flg;
    end

    always @ (posedge clk) begin
        if (!pse_flg)
            clk_19 = clk_cnt[19];
    end
    // use difficulty control on board instead of input from mouse
    wam_hrd sub_hrd( .clk_19(clk_19), .start(start), .lft(lft), .rgt(rgt), .cout0(cout0), .hrdn(difficulty) );
    
    // handle input tap
    wam_tap sub_tap( .clk_19(clk_19), .sw(sw), .tap(tap) );

    // handle display on digital tube
    wam_led sub_led( .holes(holes), .ld(ld) );
    wam_dis sub_dis( .clk_16(clk_16),.time_display(time_display), .hrdn(difficulty), .score(score), .an(an), .a2g(a2g) );
endmodule

