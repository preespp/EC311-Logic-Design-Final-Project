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
    input wire reset,
    inout ps2c,ps2d,
    input key0,key1,
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output reg VGA_HS,
    output reg VGA_VS,
    output music_play,
    output reg [2:0] btn
    );
    
    // register variables

    wire start;
    wire [9:0] x;
    wire [8:0] y;
    wire click;
    wire [7:0] tap;
    
    wire [1:0] difficulty;
    wire [7:0] holes;
    wire [11:0] score;
    wire [4:0] time_display;
    wire pause;
    
    // for vga
    wire [3:0] VGA_R_play;
    wire [3:0] VGA_G_play;
    wire [3:0] VGA_B_play;
    wire VGA_HS_play;
    wire VGA_VS_play;
    wire [3:0] VGA_R_start;
    wire [3:0] VGA_G_start;
    wire [3:0] VGA_B_start;
    wire VGA_HS_start;
    wire VGA_VS_start;
    wire [3:0] VGA_R_final;
    wire [3:0] VGA_G_final;
    wire [3:0] VGA_B_final;
    wire VGA_HS_final;
    wire VGA_VS_final;
    
    // for inter signal between modules
    wire restart;
    wire [2:0] btn0;
    wire [2:0] btn1;
    wire [2:0] btn2;
    
    
    //all modules
    
    time_counter time_30_sec(.clk(clk),.start(start),.time_display(time_display),.pause(pause));
    
    music music_background(.clk(clk),.sound(music_play));
    
    vga vga_display(.in_clk(clk),.ps2c(ps2c),.ps2d(ps2d),.key0(key0),.key1(key1),.reset(reset),.holes(holes),.score(score),.time_display(time_display),.VGA_R(VGA_R_play),.VGA_G(VGA_G_play),.VGA_B(VGA_B_play),.VGA_HS(VGA_HS_play),.VGA_VS(VGA_VS_play),.btn(btn1), .tap(tap));
    
    VGA2 vga_start(.in_clk(clk),.reset(reset),.ps2c(ps2c),.ps2d(ps2d),.key0(key0),.key1(key1),.VGA_R(VGA_R_start),.VGA_G(VGA_G_start),.VGA_B(VGA_B_start),.VGA_HS(VGA_HS_start),.VGA_VS(VGA_VS_start),.start(start),.difficulty(difficulty),.btn(btn0));
    
    vga_last vga_final(.in_clk(clk),.reset(reset),.ps2c(ps2c),.ps2d(ps2d),.key0(key0),.key1(key1),.score(score),.VGA_R(VGA_R_final),.VGA_G(VGA_G_final),.VGA_B(VGA_B_final),.VGA_HS(VGA_HS_final),.VGA_VS(VGA_VS_final),.btn(btn2),.restart(restart));    
  
  
    game_logic game(.clk(clk),.pause(pause),.tap(tap),.start(start),.difficulty(difficulty),.holes(holes),.score(score));
    
    // fsm for vga screen (3 stages)
    reg [1:0] state;
    
    initial begin 
        state = 0;
    end
    
    always @(posedge clk) begin
        case(state)
            0:begin //begin page
                VGA_R = VGA_R_start;
                VGA_G = VGA_G_start;
                VGA_B = VGA_B_start;
                VGA_HS = VGA_HS_start;
                VGA_VS = VGA_VS_start;
                btn = btn0;
                if (start == 1) begin
                    state <= 1;
                end
            end
            1:begin // play page
                VGA_R = VGA_R_play;
                VGA_G = VGA_G_play;
                VGA_B = VGA_B_play;
                VGA_HS = VGA_HS_play;
                VGA_VS = VGA_VS_play;
                btn = btn1;
                if (pause == 1) begin
                    state <= 2;
                end
            end
            2:begin // end page and restart
                VGA_R = VGA_R_final;
                VGA_G = VGA_G_final;
                VGA_B = VGA_B_final;
                VGA_HS = VGA_HS_final;
                VGA_VS = VGA_VS_final;
                btn = btn2;
                // fix to restart signal after got mouse
                if (restart == 1) begin
                state <= 0;
                end
            end
            default:begin 
                state <= 0; //begin page
            end
        endcase
    end
    
    
endmodule
