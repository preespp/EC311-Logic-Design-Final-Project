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
    
  reg [4:0]count=5'b11110;
  reg [32:0] time_signal = 0;
  reg activate = 0; // to keep the time count
  
//  Clock_divider clock_divider(
  //  .in_clk(clk),      // 100 MHz clock
    //.out_clk(time_signal) // 1 Hz clock (real time)
//);
    
  always @(posedge clk or posedge start or posedge activate) begin
    if (!start & !activate) begin
       pause = 1;
       count = 5'b11110; //Reset to 30 sec
       time_signal = 0;
    end
    else begin
        activate = 1;
        pause = 0;
        if (time_signal == 100000000) begin
            time_signal = 0;
            count = count - 1; 
            if (count == 0) begin
                pause = 1;
                activate = 0;
                time_signal = 0;
            end
        end
        else
            // since psg_flag will be flipped when  
            begin
            time_signal = time_signal + 1;
        end
     end
    end 
    
  
assign time_display = count;
  
endmodule


//unused modules

// change the way of timer because the old version causes conflict when implementing
// the port for time_display have multiple drivers (2 always block)

// module Clock_divider(
//    input in_clk,      // 100 MHz clock
//    output reg out_clk // 1 Hz clock
//);

//	reg[32:0] count;

//	initial begin

		// initialize everything to zero
//		count = 0;
	//	out_clk = 0;
//	end

//	always @(negedge in_clk)
//	begin
//	   count = count + 1;

		// increment count by one (use blocking assignment)

//	   if (count == 5 * (10^7) )begin
	//       out_clk <= ~out_clk;
	  //     count <= 0;
	    //   end
		// if count equals to some big number (that you need to calculate),
		//     (Think: how many input clock cycles do you need to see 
		//     for it to be half a second)
		//     then flip the output clock,   (use non-blocking assignment)
		//     and reset count to zero.      (use non-blocking assignment)

	//end

// endmodule