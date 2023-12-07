`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2023 02:10:46 PM
// Design Name: 
// Module Name: time_counter
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


module time_counter(
    input wire clk,
    input wire start,
    output [4:0] time_display,
    output reg pause
    );
    
  integer i;
  reg count=0;
  
  Clock_divider clock_divider(
    clk,      // 100 MHz clock
    time_signal // 1 Hz clock (real time)
);
    
  always @(posedge clk) begin
    if (start) begin
      pause = 0;
      count= 5'b11110;      // Reset count to 30 sec
        end
    if (count == 0) begin
       pause = 1;
    end
  end
  
  always @(posedge time_signal) begin
        if (count > 0) begin
        count = count - 1;
        end
  end
assign time_display = count;
  
endmodule

module Clock_divider(
    input in_clk,      // 100 MHz clock
    output reg out_clk // 1 Hz clock
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

	   if (count == 5 * (10^7) )begin
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