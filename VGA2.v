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


module VGA2(
    input in_clk, 
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output reg VGA_HS,
    output reg VGA_VS
    );
    
    reg [5:0] ID0 = 0;
    reg [5:0] ID1= 1;
    reg[5:0]  ID2 =2;
    reg [5:0] ID3 = 3;
    reg [5:0] ID4 = 4;
    reg [5:0] ID5= 5;
    reg[5:0]  ID6 =6;
    reg [5:0] ID7 =7;
    reg [5:0] ID8 = 8; 
    reg[5:0]  ID9 =9;
    reg [5:0] ID10 =10;
    reg [5:0] ID11 = 11;
    reg [5:0] ID12 = 12;
    reg [5:0] ID13= 13;
    reg[5:0]  ID14 =14;
    reg [5:0] ID15 = 15;
    reg [5:0] ID16 = 16;
    reg [5:0] ID17= 17;
    reg[5:0]  ID18=18;
    reg [5:0] ID19 =19;
    reg [5:0] ID20 = 20; 
    reg [5:0] ID21 =21;
    reg [5:0] ID22 = 22;
    
    reg [6:0] lwidth = 50;
    reg [6:0] lheight = 60;
    reg [6:0] wwidth = 40;
    reg [6:0] wheight = 40;
    reg [9:0] xstart1 = 210;
    reg [9:0] xstart2 = 36;
    reg [9:0] xstart3 = 10;
    
    
    wire outP,outLA,outA,outY,outLB,outEA,outV,outEB,outLC,outone,outtwo,outthree;
    wire outW,outH,outAB,outC,outD1,outAC,outD2,outM,outO,outLD,outEC;
    
    Clock_divider CD(in_clk, clock);
    wire [31:0] y;
    wire [31:0] x;   
    reg [31:0] count, vertical_count;
    reg [31:0] vertical_position, horizontal_position;
    assign y = vertical_position;
    assign x = horizontal_position;
    
    
    
    lettermap2 P(.x(x),.y(y),.xstart(xstart1),.ystart(240-(wheight/2)),.ID(ID0),.value(outP),.lwidth(wwidth),.lheight(wheight));
    lettermap2 L1(.x(x),.y(y),.xstart(xstart1+ wwidth +10),.ystart(240-(wheight/2)),.ID(ID1),.value(outLA),.lwidth(wwidth),.lheight(wheight));
    lettermap2 A1(.x(x),.y(y),.xstart(xstart1 + 2*wwidth +10),.ystart(240-(wheight/2)),.ID(ID2),.value(outAA),.lwidth(wwidth),.lheight(wheight));
    lettermap2 Y(.x(x),.y(y),.xstart(xstart1 + 3*wwidth + 10),.ystart(240-(wheight/2)),.ID(ID3),.value(outY),.lwidth(wwidth),.lheight(wheight));
    
    lettermap2 L2(.x(x),.y(y),.xstart(xstart2),.ystart(360-(wheight/2)),.ID(ID4),.value(outLB),.lwidth(wwidth),.lheight(wheight));
    lettermap2 E1(.x(x),.y(y),.xstart(xstart2 + wwidth),.ystart(360-(wheight/2)),.ID(ID5),.value(outEA),.lwidth(wwidth),.lheight(wheight));
    lettermap2 V(.x(x),.y(y),.xstart(xstart2  + 2*wwidth),.ystart(360-(wheight/2)),.ID(ID6),.value(outV),.lwidth(wwidth),.lheight(wheight));
    lettermap2 E2(.x(x),.y(y),.xstart(xstart2 + 3*wwidth),.ystart(360-(wheight/2)),.ID(ID7),.value(outEB),.lwidth(wwidth),.lheight(wheight));
    lettermap2 L3(.x(x),.y(y),.xstart(xstart2 + 4*wwidth),.ystart(360-(wheight/2)),.ID(ID8),.value(outLC),.lwidth(wwidth),.lheight(wheight));
    
    lettermap2 one(.x(x),.y(y),.xstart(xstart2  + 6*wwidth),.ystart(360-(wheight/2)),.ID(ID9),.value(outone),.lwidth(wwidth),.lheight(wheight));
    lettermap2 two(.x(x),.y(y),.xstart(xstart2 + 8*wwidth),.ystart(360-(wheight/2)),.ID(ID10),.value(outtwo),.lwidth(wwidth),.lheight(wheight));
    lettermap2 three(.x(x),.y(y),.xstart(xstart2 + 10*wwidth),.ystart(360-(wheight/2)),.ID(ID11),.value(outthree),.lwidth(wwidth),.lheight(wheight));


    lettermap2 W(.x(x),.y(y),.xstart(xstart3),.ystart(120-(wheight/2)),.ID(ID12),.value(outW),.lwidth(lwidth),.lheight(lheight));
    lettermap2 H(.x(x),.y(y),.xstart(xstart3+lwidth+10),.ystart(120-(wheight/2)),.ID(ID13),.value(outH),.lwidth(lwidth),.lheight(lheight));
    lettermap2 A2(.x(x),.y(y),.xstart(xstart3+2*lwidth+20),.ystart(120-(wheight/2)),.ID(ID14),.value(outAB),.lwidth(lwidth),.lheight(lheight));
    lettermap2 C(.x(x),.y(y),.xstart(xstart3+3*lwidth+30),.ystart(120-(wheight/2)),.ID(ID15),.value(outC),.lwidth(lwidth),.lheight(lheight));
    lettermap2 dash1(.x(x),.y(y),.xstart(xstart3+4*lwidth+30),.ystart(120-(wheight/2)),.ID(ID16),.value(outD1),.lwidth(lwidth),.lheight(lheight));
    lettermap2 A3(.x(x),.y(y),.xstart(xstart3+5*lwidth+40),.ystart(120-(wheight/2)),.ID(ID17),.value(outAC),.lwidth(lwidth),.lheight(lheight));  
    lettermap2 dash2(.x(x),.y(y),.xstart(xstart3+6*lwidth+30),.ystart(120-(wheight/2)),.ID(ID18),.value(outD2),.lwidth(lwidth),.lheight(lheight));
    lettermap2 M(.x(x),.y(y),.xstart(xstart3+7*lwidth+40),.ystart(120-(wheight/2)),.ID(ID19),.value(outM),.lwidth(lwidth),.lheight(lheight));
    lettermap2 O(.x(x),.y(y),.xstart(xstart3+8*lwidth+50),.ystart(120-(wheight/2)),.ID(ID20),.value(outO),.lwidth(lwidth),.lheight(lheight));
    lettermap2 L4(.x(x),.y(y),.xstart(xstart3+9*lwidth+50),.ystart(120-(wheight/2)),.ID(ID21),.value(outLD),.lwidth(lwidth),.lheight(lheight));
    lettermap2 E3(.x(x),.y(y),.xstart(xstart3+10*lwidth+60),.ystart(120-(wheight/2)),.ID(ID22),.value(outEC),.lwidth(lwidth),.lheight(lheight));




    
    





//    reg [31:0] count, vertical_count;
//    reg [31:0] vertical_position, horizontal_position;
    reg [1:0] vertical_state, horizontal_state;
    reg vertical_trigger, vertical_blank; // triggers the vertical state machine
    // states: 0 means pre-blanking; 1 means pixels; 2 means post-blanking; 3 means synchronizing
    // pre-blanking: 48 cycles, HS high
    // pixels: 640 cycles, HS high
    // post-blanking: 16 cycles, HS high
    // synchronization: 96 cycles, HS low
//    wire [31:0] y;
//    wire [31:0] x;   
//    assign y = vertical_position;
//    assign x = horizontal_position;

    
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
                    // modify this line to read an image from a 2D array
                    // index using vertical_position and horizontal_position
                    // from a 640 by 480 array
                    // 480 is the number of lines
                    // 640 is the number of pixels in a line
                    
//                    VGA_B = 0; // right now just displays blue.
//                    if (y >= 61 && y <= 141 && x >= 242 && x <= 364) 
//                    begin
//                        if ((y == 93  && (x >= 270 && x <= 283) ) || (x == 270 && (y >= 93 && y <= 114)) || (x == 283 && (y >=93 && y <= 106)) || (y==106 && (x>=106 && x<=283))) VGA_B = 8;
//                    end
//                    else
//                    begin
//                        VGA_B = 0;
//                    end
                    VGA_G =((outW)||(outH)||(outAB)||(outC)||(outD1)||(outAC)||(outD2)||(outM)||(outO)||(outLD)||(outEC)) ? 8:0;
                    VGA_B = ((outP)||(outLA)||(outAA)||(outY)) ? 8 : 0;
                    VGA_R = ((outLB)||(outEA)||(outV)||(outEB)||(outLC)||(outone)||(outtwo)||(outthree)) ? 8 : 0;
                    
                end
                else
                begin
                    VGA_B <= 0;
                    VGA_R <= 0;
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










