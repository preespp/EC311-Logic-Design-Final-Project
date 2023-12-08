`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 04:56:24 PM
// Design Name: 
// Module Name: music
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

module music(
  input clk,
  output sound
);

wire fasterclk;
wire clk_400;
wire valid;
wire [21:0] tone;
reg [3:0] count;

reg [5:0] next_state;

initial next_state = 0;

Clock_divider faster(clk,fasterclk);

// FSM for song 
// Pacman
// Score available at https://musescore.com/user/85429/scores/107109
// B4, 16, NOTE_B5, 16, NOTE_FS5, 16, NOTE_DS5, 16, //1  NOTE_B5, 32, NOTE_FS5, -16, NOTE_DS5, 8, NOTE_C5, 16,
 // NOTE_C6, 16, NOTE_G6, 16, NOTE_E6, 16, NOTE_C6, 32, NOTE_G6, -16, NOTE_E6, 8,

  //NOTE_B4, 16,  NOTE_B5, 16,  NOTE_FS5, 16,   NOTE_DS5, 16,  NOTE_B5, 32,  //2
 // NOTE_FS5, -16, NOTE_DS5, 8,  NOTE_DS5, 32, NOTE_E5, 32,  NOTE_F5, 32,
//  NOTE_F5, 32,  NOTE_FS5, 32,  NOTE_G5, 32,  NOTE_G5, 32, NOTE_GS5, 32,  NOTE_A5, 16, NOTE_B5, 8

// B4,B5,FS5,DS5,C5,C6,G6,E6,E5,F5,G5,GS5,A5
always @(posedge fasterclk) begin

    case(next_state)
        0 : begin
            count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 1;
            end
            end
        1: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 2;
            end
            end
        2: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 3;
            end
            end
        3: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 4;
            end
            end
        4: begin
        count <= count + 1;
            if (count == 1) begin
                count <= 0;
                next_state <= 5;
            end
            end
        5: begin
        count <= count + 1;
            if (count == 3) begin
                count <= 0;
                next_state <= 6;
            end
            end
        6: begin
        count <= count + 1;
            if (count == 4) begin
                count <= 0;
                next_state <= 7;
            end
            end
        7: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 8;
            end
            end
        8: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 9;
            end
            end
        9: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 10;
            end
            end
        10: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 11;
            end
            end
        11: begin
        count <= count + 1;
            if (count == 1) begin
                count <= 0;
                next_state <= 12;
            end
            end
        12: begin
        count <= count + 1;
            if (count == 3) begin
                count <= 0;
                next_state <= 13;
            end
            end
        13: begin
        count <= count + 1;
            if (count == 4) begin
                count <= 0;
                next_state <= 14;
            end
            end
        14: begin
            count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 15;
            end
            end
        15: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 16;
            end
            end
        16: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 17;
            end
            end
        17: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 18;
            end
            end
        18: begin
        count <= count + 1;
            if (count == 1) begin
                count <= 0;
                next_state <= 19;
            end
            end
        19: begin
        count <= count + 1;
            if (count == 3) begin
                count <= 0;
                next_state <= 21;
            end
            end
        20: begin
        count <= count + 1;
            if (count == 4) begin
                count <= 0;
                next_state <= 21;
            end
            end
        21: begin
        count <= count + 1;
            if (count == 1) begin
                count <= 0;
                next_state <= 22;
            end
            end
        22: begin
        count <= count + 1;
            if (count == 1) begin
                count <= 0;
                next_state <= 23;
            end
            end
        23: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 24;
            end
            end                                                                                                                            
        24: begin
        count <= count + 1;
            if (count == 1) begin
                count <= 0;
                next_state <= 25;
            end
            end
        25: begin
        count <= count + 1;
            if (count == 1) begin
                count <= 0;
                next_state <= 26;
            end
            end
        26: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 27;
            end
            end 
        27: begin
        count <= count + 1;
            if (count == 1) begin
                count <= 0;
                next_state <= 28;
            end
            end
        28: begin
        count <= count + 1;
            if (count == 1) begin
                count <= 0;
                next_state <= 29;
            end
            end
        29: begin
        count <= count + 1;
            if (count == 2) begin
                count <= 0;
                next_state <= 30;
            end
            end
        30: begin
        count <= count + 1;
            if (count == 4) begin
                count <= 0;
                next_state <= 31;
            end
            end
        31: begin // rest state
        count <= count + 1;
            if (count == 4) begin
                count <= 0;
                next_state <= 0;
            end
            end
    endcase
end

// frequency for each note
reg [9:0] B4 = 493;
reg [9:0] B5 = 987;
reg [9:0] FS5 = 739;
reg [9:0] DS5 = 622;
reg [9:0] C5 = 523;
reg [10:0] C6 = 1047;
reg [10:0] G6 = 1568;
reg [10:0] E6 = 1279;
reg [9:0] E5 = 659;
reg [9:0] F5 = 698;
reg [9:0] G5 = 784;
reg [9:0] GS5 = 830;
reg [9:0] A5 = 880;

// Output to tone
assign tone = (next_state==0 || next_state==14) ? B4 :
              (next_state==1 || next_state==4 || next_state==15 || next_state==18 || next_state==30) ? B5 :             
              (next_state==2 || next_state==5 || next_state==16 || next_state==19 || next_state==25) ? FS5 :                                
              (next_state==3 || next_state==6 || next_state==17 || next_state==20 || next_state==21) ? DS5 :                                            
              (next_state==7) ? C5 :
              (next_state==8 || next_state==11) ? C6 :
              (next_state==9 || next_state==12 ) ? G6 :
              (next_state==13) ? E6 :
              (next_state==22 ) ? E5 :
              (next_state==23 || next_state==24 ) ? F5 :
              (next_state==26 || next_state==27 ) ? G5 :
              (next_state==28 ) ? GS5 :                                                             
              (next_state==29) ? A5 : 0;                              

// Frequency Divider
sound_generator random(
  .clk(fasterclk),
  .counter(tone),
  .sound(sound)
);

endmodule


module sound_generator( 
    input clk, 
    input [21:0] counter,
    output reg sound );


wire sound_next;
wire sound_invert;

reg [21:0] num;


always@(posedge clk) begin
    if(num == counter)
    begin
        sound <= sound_invert;
        num <= 22'd0;
    end
    else
    begin
        sound <= sound_next;
 
    end
end

assign sound_next = sound;
assign sound_invert = ~sound;

endmodule


module Clock_divider(
    input in_clk,      // 100 MHz clock
    output reg out_clk // 1 Hz clock
    // one whole note 0.625 s which means the smallest note (8th) is 0.625/8 s
);
	
	reg[32:0] count;

	initial begin
		// initialize everything to zero
		count = 0;
		out_clk = 0;
	end
	
	always @(negedge in_clk)
	begin
	   count = count + 1;
		// increment count by one (use blocking assignment)
	   if (count == 2.5 * 5 * (10^7) / 32 )begin
	       out_clk <= ~out_clk;
	       count <= 0;
	       end
		// if count equals to some big number (that you need to calculate),
		//     (Think: how many input clock cycles do you need to see 
		//     for it to be half a second)
		
		//     then flip the output clock,   (use non-blocking assignment)
		//     and reset count to zero.      (use non-blocking assignment)
	end
endmodule