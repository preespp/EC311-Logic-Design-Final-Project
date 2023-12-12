`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/24/2023 06:21:12 PM
// Design Name:
// Module Name: vga_last
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

module vga_last(
    input in_clk,
    input wire [11:0] score,    // Final Score
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
   // reg [31:0] dot_counter = 0;


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

    reg [3:0] ones;
    reg [3:0] tens;
    reg [3:0] huns;
    
    always @(*) begin
    ones = score%10;
    tens = ((score-ones)/10)%10;
    huns = (score - (tens*10) - ones)/100;
    end

 
  wire [6:0] seg1;
  wire [6:0] seg2;
  wire [6:0] seg3;
  sevensegdecoder SSD6(ones, seg1);
  sevensegdecoder SSD7(tens, seg2);
  sevensegdecoder SSD8(huns, seg3);

    reg [7:0] final_score_pixels_F [0:8];
    reg [7:0] final_score_pixels_I [0:8];
    reg [7:0] final_score_pixels_N [0:8];
    reg [7:0] final_score_pixels_A [0:8];
    reg [7:0] final_score_pixels_L [0:8];
    reg [7:0] final_score_pixels_S [0:8];
    reg [7:0] final_score_pixels_C [0:8];
    reg [7:0] final_score_pixels_O [0:8];
    reg [7:0] final_score_pixels_R [0:8];
    reg [7:0] final_score_pixels_E [0:8];
    reg [6:0] char_width;
    reg [3:0] char_counter;
    reg [7:0] restart_pixels_T [0:8];

always @* begin
        // Initialize character width and counter
        char_width = 8; // 8 pixels for each character
        char_counter = 0;

        // ASCII value for 'F'
        final_score_pixels_F[char_counter * char_width ]    = 8'b11111000;
        final_score_pixels_F[char_counter * char_width + 1] = 8'b00001000;
        final_score_pixels_F[char_counter * char_width + 2] = 8'b00001000;
        final_score_pixels_F[char_counter * char_width + 3] = 8'b01111000;
        final_score_pixels_F[char_counter * char_width + 4] = 8'b00001000;
        final_score_pixels_F[char_counter * char_width + 5] = 8'b00001000;
        final_score_pixels_F[char_counter * char_width + 6] = 8'b00001000;
        final_score_pixels_F[char_counter * char_width + 7] = 8'b00000000;


        // ASCII value for 'I'
        final_score_pixels_I[char_counter * char_width ]    = 8'b00111000;
        final_score_pixels_I[char_counter * char_width + 1] = 8'b00010000;
        final_score_pixels_I[char_counter * char_width + 2] = 8'b00010000;
        final_score_pixels_I[char_counter * char_width + 3] = 8'b00010000;
        final_score_pixels_I[char_counter * char_width + 4] = 8'b00010000;
        final_score_pixels_I[char_counter * char_width + 5] = 8'b00010000;
        final_score_pixels_I[char_counter * char_width + 6] = 8'b00111000;
        final_score_pixels_I[char_counter * char_width + 7] = 8'b00000000;

        
        /// ASCII value for 'N'
        final_score_pixels_N[char_counter * char_width + 0] = 8'b01000010;
        final_score_pixels_N[char_counter * char_width + 1] = 8'b01000110;
        final_score_pixels_N[char_counter * char_width + 2] = 8'b01001010;
        final_score_pixels_N[char_counter * char_width + 3] = 8'b01010010;
        final_score_pixels_N[char_counter * char_width + 4] = 8'b01100010;
        final_score_pixels_N[char_counter * char_width + 5] = 8'b01000010;
        final_score_pixels_N[char_counter * char_width + 6] = 8'b01000010;
        final_score_pixels_N[char_counter * char_width + 7] = 8'b00000000;

        
        // ASCII value for 'A'
        final_score_pixels_A[char_counter * char_width + 0] = 8'b00111110;
        final_score_pixels_A[char_counter * char_width + 1] = 8'b01000001;
        final_score_pixels_A[char_counter * char_width + 2] = 8'b01000001;
        final_score_pixels_A[char_counter * char_width + 3] = 8'b01111111;
        final_score_pixels_A[char_counter * char_width + 4] = 8'b01000001;
        final_score_pixels_A[char_counter * char_width + 5] = 8'b01000001;
        final_score_pixels_A[char_counter * char_width + 6] = 8'b01000001;
        final_score_pixels_A[char_counter * char_width + 7] = 8'b00000000;


        // ASCII value for 'L'
        final_score_pixels_L[char_counter * char_width + 0] = 8'b00000001;
        final_score_pixels_L[char_counter * char_width + 1] = 8'b00000001;
        final_score_pixels_L[char_counter * char_width + 2] = 8'b00000001;
        final_score_pixels_L[char_counter * char_width + 3] = 8'b00000001;
        final_score_pixels_L[char_counter * char_width + 4] = 8'b00000001;
        final_score_pixels_L[char_counter * char_width + 5] = 8'b00000001;
        final_score_pixels_L[char_counter * char_width + 6] = 8'b00111111;
        final_score_pixels_L[char_counter * char_width + 7] = 8'b00000000;

        // ASCII value for 'S'
        final_score_pixels_S[char_counter * char_width + 0] = 8'b00111110;
        final_score_pixels_S[char_counter * char_width + 1] = 8'b01000001;
        final_score_pixels_S[char_counter * char_width + 2] = 8'b00000001;
        final_score_pixels_S[char_counter * char_width + 3] = 8'b00111110;
        final_score_pixels_S[char_counter * char_width + 4] = 8'b01000000;
        final_score_pixels_S[char_counter * char_width + 5] = 8'b01000001;
        final_score_pixels_S[char_counter * char_width + 6] = 8'b00111110;
        final_score_pixels_S[char_counter * char_width + 7] = 8'b00000000;

       
        // ASCII value for 'C'
        final_score_pixels_C[char_counter * char_width + 0] = 8'b00111100;
        final_score_pixels_C[char_counter * char_width + 1] = 8'b01000010;
        final_score_pixels_C[char_counter * char_width + 2] = 8'b00000001;
        final_score_pixels_C[char_counter * char_width + 3] = 8'b00000001;
        final_score_pixels_C[char_counter * char_width + 4] = 8'b00000001;
        final_score_pixels_C[char_counter * char_width + 5] = 8'b01000010;
        final_score_pixels_C[char_counter * char_width + 6] = 8'b00111100;
        final_score_pixels_C[char_counter * char_width + 7] = 8'b00000000;


        // ASCII value for 'O'
        final_score_pixels_O[char_counter * char_width + 0] = 8'b01111100;
        final_score_pixels_O[char_counter * char_width + 1] = 8'b10000010;
        final_score_pixels_O[char_counter * char_width + 2] = 8'b10000010;
        final_score_pixels_O[char_counter * char_width + 3] = 8'b10000010;
        final_score_pixels_O[char_counter * char_width + 4] = 8'b10000010;
        final_score_pixels_O[char_counter * char_width + 5] = 8'b10000010;
        final_score_pixels_O[char_counter * char_width + 6] = 8'b01111100;
        final_score_pixels_O[char_counter * char_width + 7] = 8'b00000000;


        // ASCII value for 'R'
        final_score_pixels_R[char_counter * char_width + 0] = 8'b00011111;
        final_score_pixels_R[char_counter * char_width + 1] = 8'b00100001;
        final_score_pixels_R[char_counter * char_width + 2] = 8'b00100001;
        final_score_pixels_R[char_counter * char_width + 3] = 8'b00011111;
        final_score_pixels_R[char_counter * char_width + 4] = 8'b00010001;
        final_score_pixels_R[char_counter * char_width + 5] = 8'b00100001;
        final_score_pixels_R[char_counter * char_width + 6] = 8'b01000001;
        final_score_pixels_R[char_counter * char_width + 7] = 8'b00000000;


        // ASCII value for 'E'
        final_score_pixels_E[char_counter * char_width + 0] = 8'b01111110;
        final_score_pixels_E[char_counter * char_width + 1] = 8'b00000010;
        final_score_pixels_E[char_counter * char_width + 2] = 8'b00000010;
        final_score_pixels_E[char_counter * char_width + 3] = 8'b01111110;
        final_score_pixels_E[char_counter * char_width + 4] = 8'b00000010;
        final_score_pixels_E[char_counter * char_width + 5] = 8'b00000010;
        final_score_pixels_E[char_counter * char_width + 6] = 8'b01111110;
        final_score_pixels_E[char_counter * char_width + 7] = 8'b00000000;

	   end


    always @* begin
    // Initialize character width and counter
    char_width = 8; // Assuming 8 pixels for each character
    char_counter = 0;

    // Display "Restart"

	   // ASCII value for 'T'
        restart_pixels_T[char_counter * char_width + 0] = 8'b01111111;
        restart_pixels_T[char_counter * char_width + 1] = 8'b00001000;
        restart_pixels_T[char_counter * char_width + 2] = 8'b00001000;
        restart_pixels_T[char_counter * char_width + 3] = 8'b00001000;
        restart_pixels_T[char_counter * char_width + 4] = 8'b00001000;
        restart_pixels_T[char_counter * char_width + 5] = 8'b00001000;
        restart_pixels_T[char_counter * char_width + 6] = 8'b00001000;
        restart_pixels_T[char_counter * char_width + 7] = 8'b00000000;

    end

        integer linear_position;
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


                  // Display the word "final score"
                  if ((horizontal_position >= 240 ) && (horizontal_position < 248) && (vertical_position >= 160) && (vertical_position < 168)) begin
                         VGA_R <= (final_score_pixels_F[vertical_position - 160][horizontal_position - 240]) * (135 / 15);
                         VGA_G <= (final_score_pixels_F[vertical_position - 160][horizontal_position - 240]) * (135 / 15);
                         VGA_B <= (final_score_pixels_F[vertical_position - 160][horizontal_position - 240]) * (135 / 15);
                 end
                  if ((horizontal_position >= 256 ) && (horizontal_position < 264) && (vertical_position >= 160) && (vertical_position < 168)) begin
                         VGA_R <= (final_score_pixels_I[vertical_position - 160][horizontal_position - 256]) * (135 / 15);
                         VGA_G <= (final_score_pixels_I[vertical_position - 160][horizontal_position - 256]) * (135 / 15);
                         VGA_B <= (final_score_pixels_I[vertical_position - 160][horizontal_position - 256]) * (135 / 15);
                 end
                  if ((horizontal_position >= 272 ) && (horizontal_position < 280) && (vertical_position >= 160) && (vertical_position < 168)) begin
                         VGA_R <= (final_score_pixels_N[vertical_position - 160][horizontal_position - 272]) * (135 / 15);
                         VGA_G <= (final_score_pixels_N[vertical_position - 160][horizontal_position - 272]) * (135 / 15);
                         VGA_B <= (final_score_pixels_N[vertical_position - 160][horizontal_position - 272]) * (135 / 15);
                 end
                  if ((horizontal_position >= 288 ) && (horizontal_position < 296) && (vertical_position >= 160) && (vertical_position < 168)) begin
                         VGA_R <= (final_score_pixels_A[vertical_position - 160][horizontal_position - 288]) * (135 / 15);
                         VGA_G <= (final_score_pixels_A[vertical_position - 160][horizontal_position - 288]) * (135 / 15);
                         VGA_B <= (final_score_pixels_A[vertical_position - 160][horizontal_position - 288]) * (135 / 15);
                 end
                  if ((horizontal_position >= 304 ) && (horizontal_position < 312) && (vertical_position >= 160) && (vertical_position < 168)) begin
                         VGA_R <= (final_score_pixels_L[vertical_position - 160][horizontal_position - 304]) * (135 / 15);
                         VGA_G <= (final_score_pixels_L[vertical_position - 160][horizontal_position - 304]) * (135 / 15);
                         VGA_B <= (final_score_pixels_L[vertical_position - 160][horizontal_position - 304]) * (135 / 15);
                 end
                 
                 
                 if ((horizontal_position >= 328 ) && (horizontal_position < 336) && (vertical_position >= 160) && (vertical_position < 168)) begin
                         VGA_R <= (final_score_pixels_S[vertical_position - 160][horizontal_position - 328]) * (135 / 15);
                         VGA_G <= (final_score_pixels_S[vertical_position - 160][horizontal_position - 328]) * (135 / 15);
                         VGA_B <= (final_score_pixels_S[vertical_position - 160][horizontal_position - 328]) * (135 / 15);
                 end
                  if ((horizontal_position >= 344 ) && (horizontal_position < 352) && (vertical_position >= 160) && (vertical_position < 168)) begin
                         VGA_R <= (final_score_pixels_C[vertical_position - 160][horizontal_position - 344]) * (135 / 15);
                         VGA_G <= (final_score_pixels_C[vertical_position - 160][horizontal_position - 344]) * (135 / 15);
                         VGA_B <= (final_score_pixels_C[vertical_position - 160][horizontal_position - 344]) * (135 / 15);
                 end
                  if ((horizontal_position >= 360 ) && (horizontal_position < 368) && (vertical_position >= 160) && (vertical_position < 168)) begin
                         VGA_R <= (final_score_pixels_O[vertical_position - 160][horizontal_position - 360]) * (135 / 15);
                         VGA_G <= (final_score_pixels_O[vertical_position - 160][horizontal_position - 360]) * (135 / 15);
                         VGA_B <= (final_score_pixels_O[vertical_position - 160][horizontal_position - 360]) * (135 / 15);
                 end
                  if ((horizontal_position >= 376 ) && (horizontal_position < 384) && (vertical_position >= 160) && (vertical_position < 168)) begin
                         VGA_R <= (final_score_pixels_R[vertical_position - 160][horizontal_position - 376]) * (135 / 15);
                         VGA_G <= (final_score_pixels_R[vertical_position - 160][horizontal_position - 376]) * (135 / 15);
                         VGA_B <= (final_score_pixels_R[vertical_position - 160][horizontal_position - 376]) * (135 / 15);
                 end
                  if ((horizontal_position >= 392 ) && (horizontal_position < 400) && (vertical_position >= 160) && (vertical_position < 168)) begin
                         VGA_R <= (final_score_pixels_E[vertical_position - 160][horizontal_position - 392]) * (135 / 15);
                         VGA_G <= (final_score_pixels_E[vertical_position - 160][horizontal_position - 392]) * (135 / 15);
                         VGA_B <= (final_score_pixels_E[vertical_position - 160][horizontal_position - 392]) * (135 / 15);
                 end
                 //Display Score in the ones digit

                 if (horizontal_position >= 370 && horizontal_position < 420 && ((vertical_position >= 215) && (vertical_position < 225))) begin
                        VGA_R <= seg1[6] ? 15 : 0;
                        VGA_G <= seg1[6] ? 15 : 0;
                        VGA_B <= seg1[6] ? 15 : 0;
                  end
                 //Display Score in the ones digit

                 if (horizontal_position >= 370 && horizontal_position < 420 && ((vertical_position >= 215) && (vertical_position < 225))) begin
                        VGA_R <= seg1[6] ? 15 : 0;
                        VGA_G <= seg1[6] ? 15 : 0;
                        VGA_B <= seg1[6] ? 15 : 0;
                  end

                  
                 if (horizontal_position >= 420 && horizontal_position < 430 && ((vertical_position >= 225) && (vertical_position < 275))) begin
                        VGA_R <= seg1[5] ? 15 : 0;
                        VGA_G <= seg1[5] ? 15 : 0;
                        VGA_B <= seg1[5] ? 15 : 0;
                 end

                 if (horizontal_position >= 420 && horizontal_position < 430 && ((vertical_position >= 285) && (vertical_position < 335))) begin
                        VGA_R <= seg1[4] ? 15 : 0;
                        VGA_G <= seg1[4] ? 15 : 0;
                        VGA_B <= seg1[4] ? 15 : 0;
                  end

                 if (horizontal_position >= 370 && horizontal_position < 420 && ((vertical_position >= 335) && (vertical_position < 345))) begin
                        VGA_R <= seg1[3] ? 15 : 0;
                        VGA_G <= seg1[3] ? 15 : 0;
                        VGA_B <= seg1[3] ? 15 : 0;
                 end

                 if (horizontal_position >= 360 && horizontal_position < 370 && ((vertical_position >= 285) && (vertical_position < 335))) begin
                        VGA_R <= seg1[2] ? 15 : 0;
                        VGA_G <= seg1[2] ? 15 : 0;
                        VGA_B <= seg1[2] ? 15 : 0;
                  end

                 if (horizontal_position >= 360 && horizontal_position < 370 && ((vertical_position >= 225) && (vertical_position < 275))) begin
                        VGA_R <= seg1[1] ? 15 : 0;
                        VGA_G <= seg1[1] ? 15 : 0;
                        VGA_B <= seg1[1] ? 15 : 0;

                 end

                 if (horizontal_position >= 370 && horizontal_position < 420 && ((vertical_position >= 275) && (vertical_position < 285))) begin
                        VGA_R <= seg1[0] ? 15 : 0;
                        VGA_G <= seg1[0] ? 15 : 0;
                        VGA_B <= seg1[0] ? 15 : 0;
                 end

                 

                  //Display Score in the tens digit

                 if (horizontal_position >= 295 && horizontal_position < 345 && ((vertical_position >= 215) && (vertical_position < 225))) begin
                        VGA_R <= seg2[6] ? 15 : 0;
                        VGA_G <= seg2[6] ? 15 : 0;
                        VGA_B <= seg2[6] ? 15 : 0;
                  end

                 if (horizontal_position >= 345 && horizontal_position < 355 && ((vertical_position >= 225) && (vertical_position < 275))) begin
                        VGA_R <= seg2[5] ? 15 : 0;
                        VGA_G <= seg2[5] ? 15 : 0;
                        VGA_B <= seg2[5] ? 15 : 0;
                 end

                 if (horizontal_position >= 345 && horizontal_position < 355 && ((vertical_position >= 285) && (vertical_position < 335))) begin
                        VGA_R <= seg2[4] ? 15 : 0;
                        VGA_G <= seg2[4] ? 15 : 0;
                        VGA_B <= seg2[4] ? 15 : 0;
                  end

                 if (horizontal_position >= 295 && horizontal_position < 345 && ((vertical_position >= 335) && (vertical_position < 345))) begin
                        VGA_R <= seg2[3] ? 15 : 0;
                        VGA_G <= seg2[3] ? 15 : 0;
                        VGA_B <= seg2[3] ? 15 : 0;
                 end

                 if (horizontal_position >= 285 && horizontal_position < 295 && ((vertical_position >= 285) && (vertical_position < 335))) begin
                        VGA_R <= seg2[2] ? 15 : 0;
                        VGA_G <= seg2[2] ? 15 : 0;
                        VGA_B <= seg2[2] ? 15 : 0;
                  end

                 if (horizontal_position >= 285 && horizontal_position < 295 && ((vertical_position >= 225) && (vertical_position < 275))) begin
                        VGA_R <= seg2[1] ? 15 : 0;
                        VGA_G <= seg2[1] ? 15 : 0;
                        VGA_B <= seg2[1] ? 15 : 0;
                 end

                 if (horizontal_position >= 295 && horizontal_position < 345 && ((vertical_position >= 275) && (vertical_position < 285))) begin
                        VGA_R <= seg2[0] ? 15 : 0;
                        VGA_G <= seg2[0] ? 15 : 0;
                        VGA_B <= seg2[0] ? 15 : 0;
                 end

                 

                 //Display Score in the hundreds digit
                 if (horizontal_position >= 220 && horizontal_position < 270 && ((vertical_position >= 215) && (vertical_position < 225))) begin
                        VGA_R <= seg3[6] ? 15 : 0;
                        VGA_G <= seg3[6] ? 15 : 0;
                        VGA_B <= seg3[6] ? 15 : 0;
                  end
                  
                 if (horizontal_position >= 270 && horizontal_position < 280 && ((vertical_position >= 225) && (vertical_position < 275))) begin
                        VGA_R <= seg3[5] ? 15 : 0;
                        VGA_G <= seg3[5] ? 15 : 0;
                        VGA_B <= seg3[5] ? 15 : 0;
                 end
                 
                  if (horizontal_position >= 270 && horizontal_position < 280 && ((vertical_position >= 285) && (vertical_position < 335))) begin
                        VGA_R <= seg3[4] ? 15 : 0;
                        VGA_G <= seg3[4] ? 15 : 0;
                        VGA_B <= seg3[4] ? 15 : 0;
                  end

                 if (horizontal_position >= 220 && horizontal_position < 270 && ((vertical_position >= 335) && (vertical_position < 345))) begin
                        VGA_R <= seg3[3] ? 15 : 0;
                        VGA_G <= seg3[3] ? 15 : 0;
                        VGA_B <= seg3[3] ? 15 : 0;
                 end

                 if (horizontal_position >= 210 && horizontal_position < 220 && ((vertical_position >= 285) && (vertical_position < 335))) begin
                        VGA_R <= seg3[2] ? 15 : 0;
                        VGA_G <= seg3[2] ? 15 : 0;
                        VGA_B <= seg3[2] ? 15 : 0;
                  end

                 if (horizontal_position >= 210 && horizontal_position < 220 && ((vertical_position >= 225) && (vertical_position < 275))) begin
                        VGA_R <= seg3[1] ? 15 : 0;
                        VGA_G <= seg3[1] ? 15 : 0;
                        VGA_B <= seg3[1] ? 15 : 0;
                 end

                 if (horizontal_position >= 220 && horizontal_position < 270 && ((vertical_position >= 275) && (vertical_position < 285))) begin
                        VGA_R <= seg3[0] ? 15 : 0;
                        VGA_G <= seg3[0] ? 15 : 0;
                        VGA_B <= seg3[0] ? 15 : 0;
                 end
    
            
    // Display cute little dot
             //   dot_counter <= (dot_counter == 1) ? 0 : dot_counter + 1;
                
               // if (dot_counter >= 1) begin
                   // if ((horizontal_position >= 480 && horizontal_position < 490) && (vertical_position >= 280 && vertical_position < 282)) begin
                    //    VGA_R <= 15; // Set the color of the dot (adjust as needed)
                    //    VGA_G <= 15;
                      //  VGA_B <= 15;
                    //end 
                  //  else if (dot_counter == 0) begin
                    //    if ((horizontal_position >= 480 && horizontal_position < 490) && (vertical_position >= 280 && vertical_position < 282)) begin
                       //     VGA_R <= 0; // Set the color of the dot (adjust as needed)
                        //    VGA_G <= 0;
                        //    VGA_B <= 0;
                      //  end 
                  //  end
               // end


	// Display a box around the word
       
  		    if (horizontal_position >= 279 && horizontal_position < 370 && ((vertical_position >= 380) && (vertical_position < 400))) begin

         		   // Display the box with colors
	    			    linear_position = horizontal_position + vertical_position;
                        VGA_R <= (linear_position - 659) * 8'hFF / 321; // Red gradient
                        VGA_G <= (659 - linear_position) * 8'hFF / 321; // Green gradient
                        VGA_B <= (321 - (linear_position - 659)) * 8'hFF / 321; // Blue gradient
                        
                   if ((horizontal_position >= 285 ) && (horizontal_position < 292) && (vertical_position >= 386) && (vertical_position < 394)) begin
                         VGA_R <= (final_score_pixels_R[vertical_position - 386][horizontal_position - 285]) ? 15 :(linear_position - 659) * 8'hFF / 321; 
                         VGA_G <= (final_score_pixels_R[vertical_position - 386][horizontal_position - 285]) ? 15 : (659 - linear_position) * 8'hFF / 321;
                         VGA_B <= (final_score_pixels_R[vertical_position - 386][horizontal_position - 285]) ? 15 :(321 - (linear_position - 659)) * 8'hFF / 321;
                   end
                   if ((horizontal_position >= 296 ) && (horizontal_position < 304) && (vertical_position >= 386) && (vertical_position < 394)) begin
                         VGA_R <= (final_score_pixels_E[vertical_position - 386][horizontal_position - 296]) ? 15 :(linear_position - 659) * 8'hFF / 321; 
                         VGA_G <= (final_score_pixels_E[vertical_position - 386][horizontal_position - 296]) ? 15 : (659 - linear_position) * 8'hFF / 321;
                         VGA_B <= (final_score_pixels_E[vertical_position - 386][horizontal_position - 296]) ? 15 :(321 - (linear_position - 659)) * 8'hFF / 321;
       		 	   end
                   if ((horizontal_position >= 308 ) && (horizontal_position < 316) && (vertical_position >= 386) && (vertical_position < 394)) begin
                         VGA_R <= (final_score_pixels_S[vertical_position - 386][horizontal_position - 308]) ? 15 :(linear_position - 659) * 8'hFF / 321; 
                         VGA_G <= (final_score_pixels_S[vertical_position - 386][horizontal_position - 308]) ? 15 :(659 - linear_position) * 8'hFF / 321;
                         VGA_B <= (final_score_pixels_S[vertical_position - 386][horizontal_position - 308]) ? 15 :(321 - (linear_position - 659)) * 8'hFF / 321;
                   end
                   if ((horizontal_position >= 320 ) && (horizontal_position < 328) && (vertical_position >= 386) && (vertical_position < 394)) begin
                         VGA_R <= (restart_pixels_T[vertical_position - 386][horizontal_position - 320]) ? 15 :(linear_position - 659) * 8'hFF / 321; 
                         VGA_G <= (restart_pixels_T[vertical_position - 386][horizontal_position - 320]) ? 15 :(659 - linear_position) * 8'hFF / 321;
                         VGA_B <= (restart_pixels_T[vertical_position - 386][horizontal_position - 320]) ? 15 :(321 - (linear_position - 659)) * 8'hFF / 321;
       		       end
       		 	   if ((horizontal_position >= 332 ) && (horizontal_position < 340) && (vertical_position >= 386) && (vertical_position < 394)) begin
                         VGA_R <= (final_score_pixels_A[vertical_position - 386][horizontal_position - 332]) ? 15 :(linear_position - 659) * 8'hFF / 321; 
                         VGA_G <= (final_score_pixels_A[vertical_position - 386][horizontal_position - 332]) ? 15 :(659 - linear_position) * 8'hFF / 321;
                         VGA_B <= (final_score_pixels_A[vertical_position - 386][horizontal_position - 332]) ? 15 :(321 - (linear_position - 659)) * 8'hFF / 321;
                   end
       		 	   if ((horizontal_position >= 344 ) && (horizontal_position < 352) && (vertical_position >= 386) && (vertical_position < 394)) begin
                         VGA_R <= (final_score_pixels_R[vertical_position - 386][horizontal_position - 344]) ? 15 :(linear_position - 659) * 8'hFF / 321; 
                         VGA_G <= (final_score_pixels_R[vertical_position - 386][horizontal_position - 344]) ? 15 : (659 - linear_position) * 8'hFF / 321;
                         VGA_B <= (final_score_pixels_R[vertical_position - 386][horizontal_position - 344]) ? 15 :(321 - (linear_position - 659)) * 8'hFF / 321;
                   end
                   if ((horizontal_position >= 356 ) && (horizontal_position < 364) && (vertical_position >= 386) && (vertical_position < 394)) begin
                         VGA_R <= (restart_pixels_T[vertical_position - 386][horizontal_position - 356]) ? 15 :(linear_position - 659) * 8'hFF / 321; 
                         VGA_G <= (restart_pixels_T[vertical_position - 386][horizontal_position - 356]) ? 15 :(659 - linear_position) * 8'hFF / 321;
                         VGA_B <= (restart_pixels_T[vertical_position - 386][horizontal_position - 356]) ? 15 :(321 - (linear_position - 659)) * 8'hFF / 321;
       		 	  end
        		end
        end
     
		else
                begin
                    VGA_B <= 0;
                end
             horizontal_position <= horizontal_position + 1;
            end

        end
        else 
        if (horizontal_state == 2)
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
