`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2023 06:40:32 PM
// Design Name: 
// Module Name: sevensegdecoder
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


module sevensegdecoder (
    input [3:0] num,  // 4-bit input representing a decimal digit
    output reg [6:0] seg   // 7-bit output representing segments to display
);

    always @* begin
        case (num)
            4'b0000: seg = 7'b1111110;  // 0
            4'b0001: seg = 7'b0110000;  // 1
            4'b0010: seg = 7'b1101101;  // 2
            4'b0011: seg = 7'b1111001;  // 3
            4'b0100: seg = 7'b0110011;  // 4
            4'b0101: seg = 7'b1011011;  // 5
            4'b0110: seg = 7'b1011111;  // 6
            4'b0111: seg = 7'b1110000;  // 7
            4'b1000: seg = 7'b1111111;  // 8
            4'b1001: seg = 7'b1111011;  // 9
            default: seg = 7'b0000000;  // Blank for other values
        endcase
    end

endmodule