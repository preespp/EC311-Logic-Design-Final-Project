`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2023 06:12:01 PM
// Design Name: 
// Module Name: wam_scr_tb
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


module wam_scr_tb(

    );
    reg clk;         // synchronize clock
    reg clr;
    reg [7:0] hit;
    wire [11:0] num;
    wire cout0; 
    wam_scr testb(.clk(clk),.clr(clr),
.hit(hit),
.num(num),
.cout0(cout0));
    
    always #1 clk = ~clk;
    always #1 hit[0] = ~hit[0];

initial
        #100 $finish;
initial begin
        #1 clk = 0; hit=0; clr = 1;
        #1 clr = 0;

    end
  
endmodule
