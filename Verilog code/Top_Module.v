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
    input start,
    input [1:0] difficulty,
    input [7:0] tap,
   // input wire mouse,
    // delete this later
    input next,
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output reg VGA_HS,
    output reg VGA_VS,
    output music_play
    );
    
    // register variables
    
//    wire start; //put it in input for testing purpose
    wire [9:0] x;
    wire [8:0] y;
    wire click;
    
//    reg [1:0] difficulty;  //put it in input for testing purpose
    wire [7:0] holes;
    wire [11:0] score;
    wire [4:0] time_display;
    wire pause;
 //   wire [7:0] tap;      //put it in input for testing purpose
    
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
    
    wire reset = 1;
    
    //all modules
    
    time_counter time_30_sec(.clk(clk),.start(start),.time_display(time_display),.pause(pause));
    
    music music_background(.clk(clk),.sound(music_play));
    
    vga vga_display(.in_clk(clk),.reset(reset),.holes(holes),.score(score),.time_display(time_display),.VGA_R(VGA_R_play),.VGA_G(VGA_G_play),.VGA_B(VGA_B_play),.VGA_HS(VGA_HS_play),.VGA_VS(VGA_VS_play));
    
    VGA2 vga_start(.in_clk(clk),.VGA_R(VGA_R_start),.VGA_G(VGA_G_start),.VGA_B(VGA_B_start),.VGA_HS(VGA_HS_start),.VGA_VS(VGA_VS_start));
    
    vga_last vga_final(.in_clk(clk),.score(score),.VGA_R(VGA_R_final),.VGA_G(VGA_G_final),.VGA_B(VGA_B_final),.VGA_HS(VGA_HS_final),.VGA_VS(VGA_VS_final));    
  
     //mouse mouse_decoder(.mouse(mouse),.x(x),.y(y),.click(click));
  
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
                // if (x and y in the range of play button):
                // start <=1
                // if (x and y in the range of 1,2,3 button):
                // case(difficulty)
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
                // if (x and y in the range of each holes button):
                // case(holes) output tap
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
                // fix to restart signal after got mouse
                if (next == 1) begin
                state <= 0;
                end
            end
            default:begin 
                state <= 0; //begin page
            end
        endcase
    end
    
    
endmodule
