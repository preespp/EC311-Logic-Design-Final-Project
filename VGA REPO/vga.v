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
                 if ((horizontal_position >= mole1_x + 7) && (horizontal_position < mole1_x + 67) && (vertical_position >= mole1_y - 60) && (vertical_position < mole1_y)) begin
                         VGA_R <= 5;  // Set the red component for the mole
                         VGA_G <= 0;  // Set the green component for the mole
                         VGA_B <= 5;  // Set the blue component for the mole
                 end
                 if ((horizontal_position >= mole2_x + 7) && (horizontal_position < mole2_x + 67) && (vertical_position >= mole2_y - 60) && (vertical_position < mole2_y)) begin
                         VGA_R <= 15;  // Set the red component for the mole
                         VGA_G <= 0;  // Set the green component for the mole
                         VGA_B <= 15;  // Set the blue component for the mole
                 end
                 if ((horizontal_position >= mole3_x + 7) && (horizontal_position < mole3_x + 67) && (vertical_position >= mole3_y - 60) && (vertical_position < mole3_y)) begin
                         VGA_R <= 0;  // Set the red component for the mole
                         VGA_G <= 1;  // Set the green component for the mole
                         VGA_B <= 2;  // Set the blue component for the mole
                 end
                 if ((horizontal_position >= mole4_x + 7) && (horizontal_position < mole4_x + 67) && (vertical_position >= mole4_y - 60) && (vertical_position < mole4_y)) begin
                         VGA_R <= 0;  // Set the red component for the mole
                         VGA_G <= 0;  // Set the green component for the mole
                         VGA_B <= 5;  // Set the blue component for the mole
                 end
                 if ((horizontal_position >= mole5_x + 7) && (horizontal_position < mole5_x + 67) && (vertical_position >= mole5_y - 60) && (vertical_position < mole5_y)) begin
                         VGA_R <= 3;  // Set the red component for the mole
                         VGA_G <= 0;  // Set the green component for the mole
                         VGA_B <= 1;  // Set the blue component for the mole
                 end
                 if ((horizontal_position >= mole6_x + 7) && (horizontal_position < mole6_x + 67) && (vertical_position >= mole6_y - 60) && (vertical_position < mole6_y)) begin
                         VGA_R <= 1;  // Set the red component for the mole
                         VGA_G <= 4;  // Set the green component for the mole
                         VGA_B <= 0;  // Set the blue component for the mole
                 end
                   if ((horizontal_position >= mole7_x + 7) && (horizontal_position < mole7_x + 67) && (vertical_position >= mole7_y - 60) && (vertical_position < mole7_y)) begin
                         VGA_R <= 5;  // Set the red component for the mole
                         VGA_G <= 0;  // Set the green component for the mole
                         VGA_B <= 0;  // Set the blue component for the mole
                 end
                   if ((horizontal_position >= mole8_x + 7) && (horizontal_position < mole8_x + 67) && (vertical_position >= mole8_y - 60) && (vertical_position < mole8_y)) begin
                         VGA_R <= 0;  // Set the red component for the mole
                         VGA_G <= 2;  // Set the green component for the mole
                         VGA_B <= 5;  // Set the blue component for the mole
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

