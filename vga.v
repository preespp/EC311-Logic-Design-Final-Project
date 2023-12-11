`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/24/2023 06:21:12 PM
// Design Name:
// Module Name: vga
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


module vga(
    input in_clk,
    input reset,
    input [7:0] holes,    // Positions of all 8 holes
    input wire [11:0] score,
    input wire [4:0] time_display,
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output reg VGA_HS,
    output reg VGA_VS
    );
   
    Clock_divider CD(in_clk, clock);
   
    reg [31:0] count, vertical_count;
    reg [31:0] vertical_position, horizontal_position;
    reg [1:0] vertical_state, horizontal_state;
    reg vertical_trigger, vertical_blank; // triggers the vertical state machine
    // states: 0 means pre-blanking; 1 means pixels; 2 means post-blanking; 3 means synchronizing
    // pre-blanking: 48 cycles, HS high
    // pixels: 640 cycles, HS high
    // post-blanking: 16 cycles, HS high
    // synchronization: 96 cycles, HS low
   
    initial begin
        vertical_position = 0;
        count = 1;
        vertical_count = 1;
        horizontal_position = 0;
        vertical_state = 3;
        horizontal_state = 3;
        VGA_HS = 1;
        VGA_VS = 1;
        VGA_R = 0;
        VGA_G = 0;
        VGA_B = 0;
        vertical_trigger = 0;
        vertical_blank = 1; // one means blank line instead of display data
    end
    

    reg [9:0] mole1_x, mole1_y, mole2_x, mole2_y, mole3_x, mole3_y, mole4_x, mole4_y, mole5_x, mole5_y, mole6_x, mole6_y, mole7_x, mole7_y, mole8_x, mole8_y;               // Position of the mole
    reg [3:0] holeandmole;                // Index of the hole with the mole
    integer i,j,k;

    
     always @(posedge in_clk) begin
            if (holes[0] == 1)  begin
                mole1_x = 100;
                mole1_y = 100;
            end
            else if (holes[0] == 0) begin
                mole1_x = 2000;
                mole1_y = 2000;  
            end
            if (holes[1] == 1)  begin
                mole2_x = 250;
                mole2_y = 100;
            end
            else if (holes[1] == 0) begin
                mole2_x = 2000;
                mole2_y = 2000;  
            end
            if (holes[2] == 1)  begin
                mole3_x = 400;
                mole3_y = 100;
            end
            else if (holes[2] == 0) begin
                mole3_x = 2000;
                mole3_y = 2000;  
            end
            if (holes[3] == 1)  begin
                mole4_x = 175;
                mole4_y = 225;
            end
            else if (holes[3] == 0) begin
                mole4_x = 2000;
                mole4_y = 2000;  
            end
            if (holes[4] == 1)  begin
                mole5_x = 325;
                mole5_y = 225;
            end
            else if (holes[4] == 0) begin
                mole5_x = 2000;
                mole5_y = 2000;  
            end
            if (holes[5] == 1)  begin
                mole6_x = 100;
                mole6_y = 350;
            end
            else if (holes[5] == 0) begin
                mole6_x = 2000;
                mole6_y = 2000;  
            end
             if (holes[6] == 1)  begin
                mole7_x = 250;
                mole7_y = 350;
            end
            else if (holes[6] == 0) begin
                mole7_x = 2000;
                mole7_y = 2000;  
            end
            if (holes[7] == 1)  begin
                mole8_x = 400;
                mole8_y = 350;
            end
            else if (holes[7] == 0) begin
                mole8_x = 2000;
                mole8_y = 2000;  
            end
   end
 reg [63:0] shape1mem [0:51];
   always @(posedge in_clk) begin
		if (reset) begin
            shape1mem[0] = 64'b0000000000000000111111111111111111111111111111110000000000000000;
            shape1mem[1] = 64'b0000000000000111000000000000000000000000000000001110000000000000;
            shape1mem[2] = 64'b0000000000111000000000000000000000000000000000000001110000000000;
            shape1mem[3] = 64'b0000000111000000000000000000000000000000000000000000001110000000;
            shape1mem[4] = 64'b0000011100000000000000000000000000000000000000000000000011100000;
            shape1mem[5] = 64'b0000111000000000000000000000000000000000000000000000000001110000;
            shape1mem[6] = 64'b0001110000000000000000000000000000000000000000000000000000111000;
            shape1mem[7] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[8] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[9] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[10] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[11] = 64'b0011100000111111000000000000000000000000000000001111110000011100;
            shape1mem[12] = 64'b0011100000000011111100000000000000000000000011111100000000011100;
            shape1mem[13] = 64'b0011100000000000000111110000000000000000111110000000000000011100;
            shape1mem[14] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[15] = 64'b0011100000000000111111110000000000000000111111110000000000011100;
            shape1mem[16] = 64'b0011100000000000000111110000000000000000111110000000000000011100;
            shape1mem[17] = 64'b0011100000000000000111110000000000000000111110000000000000011100;
            shape1mem[18] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[19] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[20] = 64'b0011100000000000000011111111111111111111111000000000000000011100;
            shape1mem[21] = 64'b1111111100000000011100000000000000000000000111000000000011111111;
            shape1mem[22] = 64'b0011100011111111110000000000000000000000000001111111111100011100;
            shape1mem[23] = 64'b0011100000000011110000000001111111110000000011111000000000011100;
            shape1mem[24] = 64'b0011100000000111001100000011111111111000000110011100000000011100;
            shape1mem[25] = 64'b1111111111111111110000000001111111110000000000111111111111111111;
            shape1mem[26] = 64'b0011100000001110000000000000011111000000000000001110000000011100;
            shape1mem[27] = 64'b0011100000001111110000000000000000000000000001111110000000011100;
            shape1mem[28] = 64'b0011100000111111000000000000000000000000000000011111100000011100;
            shape1mem[29] = 64'b0011111110000011100000000000000000000000000000111000011111111100;
            shape1mem[30] = 64'b1111100000000001110000000000000000000000000001110000000000011111;
            shape1mem[31] = 64'b0011100000000000011100000000000000000000000111000000000000011100;
            shape1mem[32] = 64'b0011100000000000000011111111111111111111111000000000000000011100;
            shape1mem[33] = 64'b0011100000000000000000001100011011000110000000000000000000011100;
            shape1mem[34] = 64'b0011100000000000000000001100011011000110000000000000000000011100;
            shape1mem[35] = 64'b0011100000000000000000001100011011000110000000000000000000011100;
            shape1mem[36] = 64'b0011100000000000000000000111110001111100000000000000000000011100;
            shape1mem[37] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[38] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[39] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[40] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[41] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[42] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[43] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[44] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape1mem[45] = 64'b0011100000000000000111111111111000000000000000000000000000011100;
            shape1mem[46] = 64'b0011100000000000011111111111111111111111100000000000000000011100;
            shape1mem[47] = 64'b0011100000000001111111111111111111111111111111111110000000011100;
            shape1mem[48] = 64'b0011101111111111111111111111111111111111111111111111100011111100;	
            shape1mem[49] = 64'b0011111111111111111111111111111111111111111111111111111111111100;
            shape1mem[50] = 64'b0011111111111111111111111111111111111111111111111111111111111110;
            shape1mem[51] = 64'b1111111111111111111111111111111111111111111111111111111111111111;
		end
	end
    integer mole = 0;  

    
    reg [3:0] ones;
    reg [3:0] tens;
    reg [3:0] huns;
    reg [3:0] time_ones;
    reg [3:0] time_tens;
    always @(*) begin
    ones = score%10;
    tens = ((score-ones)/10)%10;
    huns = (score - (tens*10) - ones)/100;
    time_ones = time_display%10;
    time_tens = (time_display - time_ones)/10;
    end
    
  wire [6:0] seg1;
  wire [6:0] seg2; 
  wire [6:0] seg3; 
  wire [6:0] time1;
  wire [6:0] time2;
  sevensegdecoder SSD1(ones, seg1);
  sevensegdecoder SSD2(tens, seg2); 
  sevensegdecoder SSD3(huns, seg3); 
  sevensegdecoder SSD4(time_ones, time1);
  sevensegdecoder SSD5(time_tens, time2); 
    
    /////////// BEGIN HORIZONTAL STATE MACHINE //////////////
    always @(posedge clock)
    begin
        if (horizontal_state == 0)
        begin
            // blank for 48 cycles
            if (count == 47) begin
                count <= 1;
                horizontal_state <= 1;
                // vertical_position <= vertical_position + 1;
                vertical_trigger <= 1; // to trigger the veritcal FSM on rising edge
            end
            else
            begin
                vertical_trigger <= 0;
                count <= count + 1;
            end
        end
        else if (horizontal_state == 1)
        begin
            // shift out 640 pixels
            if (horizontal_position == 640)
            begin
                // reached end of line
                VGA_R <= 0;
                VGA_G <= 0;
                VGA_B <= 0;
                horizontal_position <= 0;
                horizontal_state <= 2;
            end
            else
            begin
                if (vertical_blank == 0)
                begin
                    VGA_R = 0;  
                    VGA_G = 0;  
                    VGA_B = 0; 
                    mole = 0;
                    
                // Display the top holes with a white color
                if ((horizontal_position >= 100) && (horizontal_position < 175) && ((vertical_position >= 100) && (vertical_position < 110))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                end
           
                if ((horizontal_position >= 250)  && (horizontal_position < 325) &&((vertical_position >= 100) && (vertical_position < 110))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                end
                
                 if ((horizontal_position >= 400)  && (horizontal_position < 475) && ((vertical_position >= 100) && (vertical_position < 110))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                end

                // Display the Last Holes
                if ((horizontal_position >= 100) && (horizontal_position < 175) && ((vertical_position >= 350) && (vertical_position < 360))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                end
                
                if ((horizontal_position >= 250) && (horizontal_position < 325) && ((vertical_position >= 350) && (vertical_position < 360))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                end
               
                 if ((horizontal_position >= 400) && (horizontal_position < 475) && ((vertical_position >= 350) && (vertical_position < 360))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                end

                 // Display the Middle Holes
                 if ((horizontal_position >= 175) && (horizontal_position < 250) && ((vertical_position >= 225) && (vertical_position < 235))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                end

                 if ((horizontal_position >= 325) && (horizontal_position < 400) && ((vertical_position >= 225) && (vertical_position < 235))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                end
 
                // Display the mole at the selected hole with a different color
                 if ((horizontal_position >= mole1_x + 5 ) && (horizontal_position < mole1_x + 69) && (vertical_position >= mole1_y - 52) && (vertical_position < mole1_y)) begin
                         VGA_R <= (shape1mem[vertical_position - (mole1_y - 52)][horizontal_position - (mole1_x + 5)]) * (135 / 15);
                         VGA_G <= (shape1mem[vertical_position - (mole1_y - 52)][horizontal_position - (mole1_x + 5)]) * (90 / 15);
                         VGA_B <= (shape1mem[vertical_position - (mole1_y - 52)][horizontal_position - (mole1_x + 5)]) * (30 / 15);
                         mole <= 1;
                 end
                 if ((horizontal_position >= mole2_x + 5 ) && (horizontal_position < mole2_x + 69) && (vertical_position >= mole2_y - 52) && (vertical_position < mole2_y)) begin
                         VGA_R <= (shape1mem[vertical_position - (mole2_y - 52)][horizontal_position - (mole2_x + 5)]) * (150 / 15);
                         VGA_G <= (shape1mem[vertical_position - (mole2_y - 52)][horizontal_position - (mole2_x + 5)]) * (105 / 15);
                         VGA_B <= (shape1mem[vertical_position - (mole2_y - 52)][horizontal_position - (mole2_x + 5)]) * (60 / 15);
                 end
                 if ((horizontal_position >= mole3_x + 5 ) && (horizontal_position < mole3_x + 69) && (vertical_position >= mole3_y - 52) && (vertical_position < mole3_y)) begin
                         VGA_R <= (shape1mem[vertical_position - (mole3_y - 52)][horizontal_position - (mole3_x + 5)]) * (105 / 15);
                         VGA_G <= (shape1mem[vertical_position - (mole3_y - 52)][horizontal_position - (mole3_x + 5)]) * (75 / 15);
                         VGA_B <= (shape1mem[vertical_position - (mole3_y - 52)][horizontal_position - (mole3_x + 5)]) * (60 / 15);
                 end
                 if ((horizontal_position >= mole4_x + 5 ) && (horizontal_position < mole4_x + 69) && (vertical_position >= mole4_y - 52) && (vertical_position < mole4_y)) begin
                         VGA_R <= (shape1mem[vertical_position - (mole4_y - 52)][horizontal_position - (mole4_x + 5)]) * (120 / 15);
                         VGA_G <= (shape1mem[vertical_position - (mole4_y - 52)][horizontal_position - (mole4_x + 5)]) * (90 / 15);
                         VGA_B <= (shape1mem[vertical_position - (mole4_y - 52)][horizontal_position - (mole4_x + 5)]) * (75 / 15);
                 end
                 if ((horizontal_position >= mole5_x + 5 ) && (horizontal_position < mole5_x + 69) && (vertical_position >= mole5_y - 52) && (vertical_position < mole5_y)) begin
                         VGA_R <= (shape1mem[vertical_position - (mole5_y - 52)][horizontal_position - (mole5_x + 5)]) * (105 / 15);
                         VGA_G <= (shape1mem[vertical_position - (mole5_y - 52)][horizontal_position - (mole5_x + 5)]) * (90 / 15);
                         VGA_B <= (shape1mem[vertical_position - (mole5_y - 52)][horizontal_position - (mole5_x + 5)]) * (45 / 15);
                 end
                 if ((horizontal_position >= mole6_x + 5 ) && (horizontal_position < mole6_x + 69) && (vertical_position >= mole6_y - 52) && (vertical_position < mole6_y)) begin
                         VGA_R <= (shape1mem[vertical_position - (mole6_y - 52)][horizontal_position - (mole6_x +5)]) * (120 / 15);
                         VGA_G <= (shape1mem[vertical_position - (mole6_y - 52)][horizontal_position - (mole6_x +5)]) * (60 / 15);
                         VGA_B <= (shape1mem[vertical_position - (mole6_y - 52)][horizontal_position - (mole6_x +5)]) * (30 / 15);
                 end
                 if ((horizontal_position >= mole7_x + 5 ) && (horizontal_position < mole7_x + 69) && (vertical_position >= mole7_y - 52) && (vertical_position < mole7_y)) begin
                         VGA_R <= (shape1mem[vertical_position - (mole7_y - 52)][horizontal_position - (mole7_x + 5)]) * (135 / 15);
                         VGA_G <= (shape1mem[vertical_position - (mole7_y - 52)][horizontal_position - (mole7_x + 5)]) * (75 / 15);
                         VGA_B <= (shape1mem[vertical_position - (mole7_y - 52)][horizontal_position - (mole7_x + 5)]) * (30 / 15);
                 end
                 if ((horizontal_position >= mole8_x + 5) && (horizontal_position < mole8_x + 69) && (vertical_position >= mole8_y - 52) && (vertical_position < mole8_y)) begin
                         VGA_R <= (shape1mem[vertical_position - (mole8_y - 52)][horizontal_position - (mole8_x + 5)]) * (120 / 15);
                         VGA_G <= (shape1mem[vertical_position - (mole8_y - 52)][horizontal_position - (mole8_x + 5)]) * (75 / 15);
                         VGA_B <= (shape1mem[vertical_position - (mole8_y - 52)][horizontal_position - (mole8_x + 5)]) * (30 / 15);
                 end
                 
                  //Display Score in the ones digit
                 if (horizontal_position >= 600 && horizontal_position < 610 && ((vertical_position >= 13) && (vertical_position < 15))) begin
                        VGA_R <= seg1[6] ? 15 : 0;
                        VGA_G <= seg1[6] ? 15 : 0;
                        VGA_B <= seg1[6] ? 15 : 0;
                  end
                 if (horizontal_position >= 610 && horizontal_position < 612 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                        VGA_R <= seg1[5] ? 15 : 0;
                        VGA_G <= seg1[5] ? 15 : 0;
                        VGA_B <= seg1[5] ? 15 : 0;
                 end
                 if (horizontal_position >= 610 && horizontal_position < 612 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                        VGA_R <= seg1[4] ? 15 : 0;
                        VGA_G <= seg1[4] ? 15 : 0;
                        VGA_B <= seg1[4] ? 15 : 0;
                  end
                 if (horizontal_position >= 600 && horizontal_position < 610 && ((vertical_position >= 37) && (vertical_position < 39))) begin
                        VGA_R <= seg1[3] ? 15 : 0;
                        VGA_G <= seg1[3] ? 15 : 0;
                        VGA_B <= seg1[3] ? 15 : 0;
                 end
                 if (horizontal_position >= 598 && horizontal_position < 600 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                        VGA_R <= seg1[2] ? 15 : 0;
                        VGA_G <= seg1[2] ? 15 : 0;
                        VGA_B <= seg1[2] ? 15 : 0;
                  end
                 if (horizontal_position >= 598 && horizontal_position < 600 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                        VGA_R <= seg1[1] ? 15 : 0;
                        VGA_G <= seg1[1] ? 15 : 0;
                        VGA_B <= seg1[1] ? 15 : 0;
                 end
                 if (horizontal_position >= 600 && horizontal_position < 610 && ((vertical_position >= 25) && (vertical_position < 27))) begin
                        VGA_R <= seg1[0] ? 15 : 0;
                        VGA_G <= seg1[0] ? 15 : 0;
                        VGA_B <= seg1[0] ? 15 : 0;
                 end
                 
                  //Display Score in the tens digit
                 if (horizontal_position >= 585 && horizontal_position < 595 && ((vertical_position >= 13) && (vertical_position < 15))) begin
                        VGA_R <= seg2[6] ? 15 : 0;
                        VGA_G <= seg2[6] ? 15 : 0;
                        VGA_B <= seg2[6] ? 15 : 0;
                  end
                 if (horizontal_position >= 595 && horizontal_position < 597 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                        VGA_R <= seg2[5] ? 15 : 0;
                        VGA_G <= seg2[5] ? 15 : 0;
                        VGA_B <= seg2[5] ? 15 : 0;
                 end
                 if (horizontal_position >= 595 && horizontal_position < 597 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                        VGA_R <= seg2[4] ? 15 : 0;
                        VGA_G <= seg2[4] ? 15 : 0;
                        VGA_B <= seg2[4] ? 15 : 0;
                  end
                 if (horizontal_position >= 585 && horizontal_position < 595 && ((vertical_position >= 37) && (vertical_position < 39))) begin
                        VGA_R <= seg2[3] ? 15 : 0;
                        VGA_G <= seg2[3] ? 15 : 0;
                        VGA_B <= seg2[3] ? 15 : 0;
                 end
                 if (horizontal_position >= 583 && horizontal_position < 585 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                        VGA_R <= seg2[2] ? 15 : 0;
                        VGA_G <= seg2[2] ? 15 : 0;
                        VGA_B <= seg2[2] ? 15 : 0;
                  end
                 if (horizontal_position >= 583 && horizontal_position < 585 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                        VGA_R <= seg2[1] ? 15 : 0;
                        VGA_G <= seg2[1] ? 15 : 0;
                        VGA_B <= seg2[1] ? 15 : 0;
                 end
                 if (horizontal_position >= 585 && horizontal_position < 595 && ((vertical_position >= 25) && (vertical_position < 27))) begin
                        VGA_R <= seg2[0] ? 15 : 0;
                        VGA_G <= seg2[0] ? 15 : 0;
                        VGA_B <= seg2[0] ? 15 : 0;
                 end
                 
                 //Display Score in the hundreds digit 
                 if (horizontal_position >= 570 && horizontal_position < 580 && ((vertical_position >= 13) && (vertical_position < 15))) begin
                        VGA_R <= seg3[6] ? 15 : 0;
                        VGA_G <= seg3[6] ? 15 : 0;
                        VGA_B <= seg3[6] ? 15 : 0;
                  end
                 if (horizontal_position >= 580 && horizontal_position < 582 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                        VGA_R <= seg3[5] ? 15 : 0;
                        VGA_G <= seg3[5] ? 15 : 0;
                        VGA_B <= seg3[5] ? 15 : 0;
                 end
                 if (horizontal_position >= 580 && horizontal_position < 582 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                        VGA_R <= seg3[4] ? 15 : 0;
                        VGA_G <= seg3[4] ? 15 : 0;
                        VGA_B <= seg3[4] ? 15 : 0;
                  end
                 if (horizontal_position >= 570 && horizontal_position < 580 && ((vertical_position >= 37) && (vertical_position < 39))) begin
                        VGA_R <= seg3[3] ? 15 : 0;
                        VGA_G <= seg3[3] ? 15 : 0;
                        VGA_B <= seg3[3] ? 15 : 0;
                 end
                 if (horizontal_position >= 568 && horizontal_position < 570 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                        VGA_R <= seg3[2] ? 15 : 0;
                        VGA_G <= seg3[2] ? 15 : 0;
                        VGA_B <= seg3[2] ? 15 : 0;
                  end
                 if (horizontal_position >= 568 && horizontal_position < 570 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                        VGA_R <= seg3[1] ? 15 : 0;
                        VGA_G <= seg3[1] ? 15 : 0;
                        VGA_B <= seg3[1] ? 15 : 0;
                 end
                 if (horizontal_position >= 570 && horizontal_position < 580 && ((vertical_position >= 25) && (vertical_position < 27))) begin
                        VGA_R <= seg3[0] ? 15 : 0;
                        VGA_G <= seg3[0] ? 15 : 0;
                        VGA_B <= seg3[0] ? 15 : 0;
                 end

                 //Display time in the rightmost digit
                 if (horizontal_position >= 80 && horizontal_position < 90 && ((vertical_position >= 13) && (vertical_position < 15))) begin
                        VGA_R <= time1[6] ? 15 : 0;
                        VGA_G <= time1[6] ? 15 : 0;
                        VGA_B <= time1[6] ? 15 : 0;
                  end
                 if (horizontal_position >= 90 && horizontal_position < 92 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                        VGA_R <= time1[5] ? 15 : 0;
                        VGA_G <= time1[5] ? 15 : 0;
                        VGA_B <= time1[5] ? 15 : 0;
                 end
                 if (horizontal_position >= 90 && horizontal_position < 92 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                        VGA_R <= time1[4] ? 15 : 0;
                        VGA_G <= time1[4] ? 15 : 0;
                        VGA_B <= time1[4] ? 15 : 0;
                  end
                 if (horizontal_position >= 80 && horizontal_position < 90 && ((vertical_position >= 37) && (vertical_position < 39))) begin
                        VGA_R <= time1[3] ? 15 : 0;
                        VGA_G <= time1[3] ? 15 : 0;
                        VGA_B <= time1[3] ? 15 : 0;
                 end
                 if (horizontal_position >= 78 && horizontal_position < 80 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                        VGA_R <= time1[2] ? 15 : 0;
                        VGA_G <= time1[2] ? 15 : 0;
                        VGA_B <= time1[2] ? 15 : 0;
                  end
                 if (horizontal_position >= 78 && horizontal_position < 80 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                        VGA_R <= time1[1] ? 15 : 0;
                        VGA_G <= time1[1] ? 15 : 0;
                        VGA_B <= time1[1] ? 15 : 0;
                 end
                 if (horizontal_position >= 80 && horizontal_position < 90 && ((vertical_position >= 25) && (vertical_position < 27))) begin
                        VGA_R <= time1[0] ? 15 : 0;
                        VGA_G <= time1[0] ? 15 : 0;
                        VGA_B <= time1[0] ? 15 : 0;
                 end
                 
                 //Display time in the second rightmost digit
                 if (horizontal_position >= 65 && horizontal_position < 75 && ((vertical_position >= 13) && (vertical_position < 15))) begin
                        VGA_R <= time2[6] ? 15 : 0;
                        VGA_G <= time2[6] ? 15 : 0;
                        VGA_B <= time2[6] ? 15 : 0;
                  end
                 if (horizontal_position >= 75 && horizontal_position < 77 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                        VGA_R <= time2[5] ? 15 : 0;
                        VGA_G <= time2[5] ? 15 : 0;
                        VGA_B <= time2[5] ? 15 : 0;
                 end
                 if (horizontal_position >= 75 && horizontal_position < 77 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                        VGA_R <= time2[4] ? 15 : 0;
                        VGA_G <= time2[4] ? 15 : 0;
                        VGA_B <= time2[4] ? 15 : 0;
                  end
                 if (horizontal_position >= 65 && horizontal_position < 75 && ((vertical_position >= 37) && (vertical_position < 39))) begin
                        VGA_R <= time2[3] ? 15 : 0;
                        VGA_G <= time2[3] ? 15 : 0;
                        VGA_B <= time2[3] ? 15 : 0;
                 end
                 if (horizontal_position >= 63 && horizontal_position < 65 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                        VGA_R <= time2[2] ? 15 : 0;
                        VGA_G <= time2[2] ? 15 : 0;
                        VGA_B <= time2[2] ? 15 : 0;
                  end
                 if (horizontal_position >= 63 && horizontal_position < 65 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                        VGA_R <= time2[1] ? 15 : 0;
                        VGA_G <= time2[1] ? 15 : 0;
                        VGA_B <= time2[1] ? 15 : 0;
                 end
                 if (horizontal_position >= 65 && horizontal_position < 75 && ((vertical_position >= 25) && (vertical_position < 27))) begin
                        VGA_R <= time2[0] ? 15 : 0;
                        VGA_G <= time2[0] ? 15 : 0;
                        VGA_B <= time2[0] ? 15 : 0;
                 end
                 
                    //Display the two dots between minute and second
                 if (horizontal_position >= 59 && horizontal_position < 61 && ((vertical_position >= 19) && (vertical_position < 21))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                  end
                  if (horizontal_position >= 59 && horizontal_position < 61 && ((vertical_position >= 31) && (vertical_position < 33))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                  end
                  
                  //Display time in the second lefttmost digit
                 if (horizontal_position >= 45 && horizontal_position < 55 && ((vertical_position >= 13) && (vertical_position < 15))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                  end
                 if (horizontal_position >= 55 && horizontal_position < 57 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                 end
                 if (horizontal_position >= 55 && horizontal_position < 57 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                  end
                 if (horizontal_position >= 45 && horizontal_position < 55 && ((vertical_position >= 37) && (vertical_position < 39))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                 end
                 if (horizontal_position >= 43 && horizontal_position < 45 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                  end
                 if (horizontal_position >= 43 && horizontal_position < 45 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                 end
                 if (horizontal_position >= 45 && horizontal_position < 55 && ((vertical_position >= 25) && (vertical_position < 27))) begin
                    VGA_R <= 0;  
                    VGA_G <= 0;  
                    VGA_B <= 0;  
                 end
                 
                 //Display time in the lefttmost digit
                 if (horizontal_position >= 30 && horizontal_position < 40 && ((vertical_position >= 13) && (vertical_position < 15))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                  end
                 if (horizontal_position >= 40 && horizontal_position < 42 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                 end
                 if (horizontal_position >= 40 && horizontal_position < 42 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                  end
                 if (horizontal_position >= 30 && horizontal_position < 40 && ((vertical_position >= 37) && (vertical_position < 39))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                 end
                 if (horizontal_position >= 28 && horizontal_position < 30 && ((vertical_position >= 27) && (vertical_position < 37))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                  end
                 if (horizontal_position >= 28 && horizontal_position < 30 && ((vertical_position >= 15) && (vertical_position < 25))) begin
                    VGA_R <= 15;  
                    VGA_G <= 15;  
                    VGA_B <= 15;  
                 end
                 if (horizontal_position >= 30 && horizontal_position < 40 && ((vertical_position >= 25) && (vertical_position < 27))) begin
                    VGA_R <= 0;  
                    VGA_G <= 0;  
                    VGA_B <= 0;  
                 end 
                end
                else
                begin
                    VGA_B <= 0;
                end
             horizontal_position <= horizontal_position + 1;
            end
        end
        else if (horizontal_state == 2)
        begin
            // blank for 16 cycles
            if (count == 16) begin
                count <= 1;
                VGA_HS <= 0;
                horizontal_state <= 3;
            end
            else
            begin
                count <= count + 1;
            end
        end
        else // 3
        begin
            // sync for 96 cycles
            if (count == 96) begin
                VGA_HS <= 1;
                count <= 1;
                horizontal_state <= 0;
            end
            else
            begin
                count <= count + 1;
            end
        end
    end
   
    /////////// BEGIN VERTICAL STATE MACHINE //////////////
 always @(posedge vertical_trigger)
    begin
        if (vertical_state == 0)
        begin
            // blank for 33 lines
            if (vertical_count == 32) begin
                vertical_count <= 1;
                vertical_state <= 1;
            end
            else
            begin
                vertical_count <= vertical_count + 1;
            end
        end
        else if (vertical_state == 1)
        begin
            // shift out 480 lines
            if (vertical_position == 480)
            begin
                // reached end of frame
                vertical_position <= 0;
                vertical_state <= 2;
                vertical_blank <= 1;
            end
            else
            begin
                vertical_blank <= 0; // start displaying data instead of blanking
                vertical_position <= vertical_position + 1;
            end
        end
        else if (vertical_state == 2)
        begin
            // blank for 10 lines
            if (vertical_count == 10) begin
                vertical_count <= 1;
                VGA_VS <= 0;
                vertical_state <= 3;
            end
            else
            begin
                vertical_count <= vertical_count + 1;
            end
        end
        else // 3
        begin
            // sync for 2 lines
            if (vertical_count == 2) begin
                VGA_VS <= 1;
                vertical_count <= 1;
                vertical_state <= 0;
            end
            else
            begin
                vertical_count <= vertical_count + 1;
            end
        end
    end
endmodule

