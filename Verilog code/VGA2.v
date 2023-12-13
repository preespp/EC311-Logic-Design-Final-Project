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
    input reset,
    inout ps2c,ps2d,
    input key0,key1, 
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B,
    output reg VGA_HS,
    output reg VGA_VS,
    output reg start,
    output reg [1:0] difficulty,
    output wire [2:0] btn
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
    reg [6:0] lheight = 50;
    reg [6:0] wwidth = 40;
    reg [6:0] wheight = 40;
    reg [6:0] pwidth = 30;
    reg [6:0] pheight = 30;
    reg [9:0] xstart1 = 240;
    reg [9:0] xstart2 = 60;
    reg [9:0] xstart3 = 160;
    reg [9:0] xstart4 = 280;
    
    
    wire outP,outLA,outAA,outY,outLB,outEA,outV,outEB,outLC,outone,outtwo,outthree;
    wire outW,outH,outAB,outC,outD1,outAC,outD2,outM,outO,outLD,outEC,outK;
    
    Clock_divider CD(in_clk, clock);
    wire [31:0] y;
    wire [31:0] x;   
    reg [31:0] count, vertical_count;
    reg [31:0] vertical_position, horizontal_position;
    assign y = vertical_position;
    assign x = horizontal_position;
    
    
    // top corner P (210,220) Y lower corner (340,260)
    lettermap2 P(.x(x),.y(y),.xstart(xstart1),.ystart(300-(pheight/2)),.ID(ID0),.value(outP),.lwidth(pwidth),.lheight(pheight));
    lettermap2 L1(.x(x),.y(y),.xstart(xstart1+ pwidth),.ystart(300-(pheight/2)),.ID(ID1),.value(outLA),.lwidth(pwidth),.lheight(pheight));
    lettermap2 A1(.x(x),.y(y),.xstart(xstart1 + 2*pwidth),.ystart(300-(pheight/2)),.ID(ID2),.value(outAA),.lwidth(pwidth),.lheight(pheight));
    lettermap2 Y(.x(x),.y(y),.xstart(xstart1 + 3*pwidth - 5),.ystart(300-(pheight/2)),.ID(ID3),.value(outY),.lwidth(pwidth),.lheight(pheight));
    lettermap2 L2(.x(x),.y(y),.xstart(xstart2),.ystart(380-(wheight/2)),.ID(ID4),.value(outLB),.lwidth(wwidth),.lheight(wheight));
    lettermap2 E1(.x(x),.y(y),.xstart(xstart2 + wwidth),.ystart(380-(wheight/2)),.ID(ID5),.value(outEA),.lwidth(wwidth),.lheight(wheight));
    lettermap2 V(.x(x),.y(y),.xstart(xstart2  + 2*wwidth),.ystart(380-(wheight/2)),.ID(ID6),.value(outV),.lwidth(wwidth),.lheight(wheight));
    lettermap2 E2(.x(x),.y(y),.xstart(xstart2 + 3*wwidth + 8),.ystart(380-(wheight/2)),.ID(ID7),.value(outEB),.lwidth(wwidth),.lheight(wheight));
    lettermap2 L3(.x(x),.y(y),.xstart(xstart2 + 4*wwidth + 8),.ystart(380-(wheight/2)),.ID(ID8),.value(outLC),.lwidth(wwidth),.lheight(wheight));
    
    //corner coordinate for 1 area: (226,340) and (266,380) 2 area: (356,340) and (396,380) 3 area: (436,340) and (476,380)
   lettermap2 one(.x(x),.y(y),.xstart(xstart2  + 6*wwidth),.ystart(380-(wheight/2)),.ID(ID9),.value(outone),.lwidth(wwidth),.lheight(wheight));
    lettermap2 two(.x(x),.y(y),.xstart(xstart2 + 8*wwidth),.ystart(380-(wheight/2)),.ID(ID10),.value(outtwo),.lwidth(wwidth),.lheight(wheight));
    lettermap2 three(.x(x),.y(y),.xstart(xstart2 + 10*wwidth),.ystart(380-(wheight/2)),.ID(ID11),.value(outthree),.lwidth(wwidth),.lheight(wheight));


   lettermap2 W(.x(x),.y(y),.xstart(xstart3),.ystart(60-(wheight/2)),.ID(ID12),.value(outW),.lwidth(lwidth),.lheight(lheight));
    lettermap2 H(.x(x),.y(y),.xstart(xstart3+lwidth+10),.ystart(60-(wheight/2)),.ID(ID13),.value(outH),.lwidth(lwidth),.lheight(lheight));
    lettermap2 A2(.x(x),.y(y),.xstart(xstart3+2*lwidth+20),.ystart(60-(wheight/2)),.ID(ID14),.value(outAB),.lwidth(lwidth),.lheight(lheight));
    lettermap2 C(.x(x),.y(y),.xstart(xstart3+3*lwidth+30),.ystart(60-(wheight/2)),.ID(ID15),.value(outC),.lwidth(lwidth),.lheight(lheight));
    lettermap2 K(.x(x),.y(y),.xstart(xstart3+4*lwidth+30),.ystart(60-(wheight/2)),.ID(ID16),.value(outD1),.lwidth(lwidth),.lheight(lheight));
    lettermap2 A3(.x(x),.y(y),.xstart(xstart4),.ystart(140-(wheight/2)),.ID(ID17),.value(outAC),.lwidth(lwidth),.lheight(lheight));


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

    
     localparam SIZE=16; //mouse pointer width and height
	 
	 wire[8:0] xm,ym;
	 //wire[2:0] btn;
	 wire m_done_tick;
	 wire video_on = 1;
	 wire mouse_on;
	 wire LOCKED;
	 wire p_tick;
	 reg clk_out;
	 wire new_clk;
	 wire[11:0] pixel_x,pixel_y;
	 reg[9:0] mouse_x_q=0,mouse_x_d; //stores x-value(left part) of mouse, 
	 reg[9:0] mouse_y_q=0,mouse_y_d; //stores y-value(upper part) of mouse, 
	 reg[2:0] mouse_color_q=0,mouse_color_d; //stores current mouse color and can be changed by right/left click 
   
     assign pixel_x = horizontal_position;   
     assign pixel_y = vertical_position;
    
    
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
    
    
          mouse m0
	(
		.clk(in_clk),
		.rst_n(~reset),
		.key0(key0),
		.key1(key1),
		.ps2c(ps2c),
		.ps2d(ps2d),
		.x(xm),
		.y(ym),
		.btn(btn),
		.m_done_tick(m_done_tick)
    );
    
     always @(posedge in_clk,negedge reset) begin
		if(reset) begin
			mouse_x_q<=0;
			mouse_y_q<=0;
			mouse_color_q<=2;
		end
		else begin
			mouse_x_q<=mouse_x_d;
			mouse_y_q<=mouse_y_d;
			mouse_color_q<=mouse_color_d;
		end
	 end
	 
	  //logic for updating mouse location(by dragging the mouse) and mouse pointer color(by left/right click)
	 always @ (*) begin
		mouse_x_d=mouse_x_q;
		mouse_y_d=mouse_y_q;
		mouse_color_d=mouse_color_q;
		if(m_done_tick) begin
			mouse_x_d=xm[8]? mouse_x_q - 1 -{~{xm[7:0]}} : mouse_x_q+xm[7:0] ; //new x value of pointer
			mouse_y_d=ym[8]? mouse_y_q + 1 +{~{ym[7:0]}} : mouse_y_q-ym[7:0] ; //new y value of pointer
			
			mouse_x_d=(mouse_x_d>640)? (xm[8]? 640:0): mouse_x_d; //wraps around when reaches border
			mouse_y_d=(mouse_y_d>480)? (ym[8]? 0:480): mouse_y_d; //wraps around when reaches border
			
			mouse_color_d = 2;
			if (~btn[0]) begin
			     start = 0;
			end
			if (btn[0]) begin
			     if (mouse_x_q <= 330 && mouse_x_q >= 240 && mouse_y_q <= 307 && mouse_y_q >= 285) begin
			         start = 1;
			     end
			     if (mouse_x_q <= 340 && mouse_x_q >= 300 && mouse_y_q <= 400 && mouse_y_q >= 360) begin
			         difficulty = 1;
			     end
			     if (mouse_x_q <= 420 && mouse_x_q >= 380 && mouse_y_q <= 400 && mouse_y_q >= 360) begin
			         difficulty = 2;
			     end
			     if (mouse_x_q <= 500 && mouse_x_q >= 460 && mouse_y_q <= 400 && mouse_y_q >= 360) begin
			         difficulty = 3;
			     end
			     end
			     
			if(btn[1]) mouse_color_d=mouse_color_q+1;//right click to change color(increment)
			else if(btn[0]) mouse_color_d=mouse_color_q-1;//left click to change color(decrement)
		end
	 end
	 
	 assign mouse_on = ((mouse_x_q<=pixel_x) && (pixel_x<=mouse_x_q+SIZE) && (mouse_y_q<=pixel_y) && (pixel_y<=mouse_y_q+SIZE));
	 
	 always @(posedge in_clk or posedge reset)
		if(reset)
		  clk_out <= 0;
		else
		  clk_out <= clk_out + 1;
		 
	assign new_clk = (clk_out == 0) ? 1 : 0; 
    
     reg [63:0] shape1mem [0:51];
   always @(posedge in_clk) begin
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
            shape1mem[14] = 64'b0011100000000000000000000000000000000000000111000000000000011100;
            shape1mem[15] = 64'b0011100000000000111111110000000000000000011100000000000000011100;
            shape1mem[16] = 64'b0011100000000000000111110000000000000001110000000000000000011100;
            shape1mem[17] = 64'b0011100000000000000111110000000000000000011100000000000000011100;
            shape1mem[18] = 64'b0011100000000000000000000000000000000000000111000000000000011100;
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
	 reg [63:0] shape2mem [0:51];
   always @(posedge in_clk) begin
            shape2mem[0] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            shape2mem[1] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            shape2mem[2] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            shape2mem[3] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            shape2mem[4] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            shape2mem[5] = 64'b0000000000000000111111111111111111111111111111110000000000000000;
            shape2mem[6] = 64'b0000000000000111000000000000000000000000000000001110000000000000;
            shape2mem[7] = 64'b0000000000111000000000000000000000000000000000000001110000000000;
            shape2mem[8] = 64'b0000000111000000000000000000000000000000000000000000001110000000;
            shape2mem[9] = 64'b0000011100000000000000000000000000000000000000000000000011100000;
            shape2mem[10] = 64'b0000111000000000000000000000000000000000000000000000000001110000;
            shape2mem[11] = 64'b0001110000000000000000000000000000000000000000000000000000111000;
            shape2mem[12] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[13] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[14] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[15] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[16] = 64'b0011100000111111000000000000000000000000000000001111110000011100;
            shape2mem[17] = 64'b0011100000000011111100000000000000000000000011111100000000011100;
            shape2mem[18] = 64'b0011100000000000000111110000000000000000111110000000000000011100;
            shape2mem[19] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[20] = 64'b0011100000000000111111110000000000000000111111110000000000011100;
            shape2mem[21] = 64'b0011100000000000000111110000000000000000111110000000000000011100;
            shape2mem[22] = 64'b0011100000000000000111110000000000000000111110000000000000011100;
            shape2mem[23] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[24] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[25] = 64'b0011100000000000000011111111111111111111111000000000000000011100;
            shape2mem[26] = 64'b1111111100000000011100000000000000000000000111000000000011111111;
            shape2mem[27] = 64'b0011100011111111110000000000000000000000000001111111111100011100;
            shape2mem[28] = 64'b0011100000000011110000000001111111110000000011111000000000011100;
            shape2mem[29] = 64'b0011100000000111001100000011111111111000000110011100000000011100;
            shape2mem[30] = 64'b1111111111111111110000000001111111110000000000111111111111111111;
            shape2mem[31] = 64'b0011100000001110000000000000011111000000000000001110000000011100;
            shape2mem[32] = 64'b0011100000001111110000000000000000000000000001111110000000011100;
            shape2mem[33] = 64'b0011100000111111000000000000000110000000000000001111110000011100;
            shape2mem[34] = 64'b0011111110000011100000110000111001110001100000011100011111111100;
            shape2mem[35] = 64'b1111100000000001110000001111110000111111000000111000000000011111;
            shape2mem[36] = 64'b0011100000000000011100000000000000000000000111000000000000011100;
            shape2mem[37] = 64'b0011100000000000000011111111111111111111111000000000000000011100;
            shape2mem[38] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[39] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[40] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[41] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[42] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[43] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[44] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape2mem[45] = 64'b0011100000000000000111111111111000000000000000000000000000011100;
            shape2mem[46] = 64'b0011100000000000011111111111111111111111100000000000000000011100;
            shape2mem[47] = 64'b0011100000000001111111111111111111111111111111111110000000011100;
            shape2mem[48] = 64'b0011101111111111111111111111111111111111111111111111100011111100;	
            shape2mem[49] = 64'b0011111111111111111111111111111111111111111111111111111111111100;
            shape2mem[50] = 64'b0011111111111111111111111111111111111111111111111111111111111110;
            shape2mem[51] = 64'b1111111111111111111111111111111111111111111111111111111111111111;
	end

	reg [63:0] shape3mem [0:51];
   always @(posedge in_clk) begin
            shape3mem[0] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            shape3mem[1] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            shape3mem[2] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            shape3mem[3] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            shape3mem[4] = 64'b0000000000000000000000000000110001100000000000000000000000000000;
            shape3mem[5] = 64'b0000000000000000000000000001111111110000000000000000000000000000;
            shape3mem[6] = 64'b0000000000000000000000000000011111000000000000000000000000000000;
            shape3mem[7] = 64'b0000000000000000000000000000000100000000000000000000000000000000;
            shape3mem[8] = 64'b0000000000000000000000000000000000000000000000000000000000000000;
            shape3mem[9] = 64'b0011111100000000000000000000000000000000000000000000000011111100;
            shape3mem[10] = 64'b0110000001100000111111111111111111111111111111110000011000000110;
            shape3mem[11] = 64'b0110001100011111000000000000000000000000000000001111100011000110;
            shape3mem[12] = 64'b0110001111111000000000000000000000000000000000000001111111000110;
            shape3mem[13] = 64'b0011001111000000000000000000000000000000000000000000001111001100;
            shape3mem[14] = 64'b0000111100000000000000000000000000000000000000000000000011110000;
            shape3mem[15] = 64'b0000111000000000000000000000000000000000000000000000000001110000;
            shape3mem[16] = 64'b0001110000000000000000000000000000000000000000000000000000111000;
            shape3mem[17] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape3mem[18] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape3mem[19] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape3mem[20] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape3mem[21] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape3mem[22] = 64'b0011100000000011111100000000000000000000000011111100000000011100;
            shape3mem[23] = 64'b0011100000000111000111110000000000000000111110001111000000011100;
            shape3mem[24] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape3mem[25] = 64'b0011100000000000111111110000000000000000111111110000000000011100;
            shape3mem[26] = 64'b0011100000000000000111110000000000000000111110000000000000011100;
            shape3mem[27] = 64'b0011100000000000000111110000000000000000111110000000000000011100;
            shape3mem[28] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape3mem[29] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape3mem[30] = 64'b0011100000000000000011111111111111111111111000000000000000011100;
            shape3mem[31] = 64'b1111111100000000011100000000000000000000000111000000000011111111;
            shape3mem[32] = 64'b0011100011111111110000000000000000000000000001111111111100011100;
            shape3mem[33] = 64'b0011100000000011110000000001111111110000000011111000000000011100;
            shape3mem[34] = 64'b0011100000000111001100000011111111111000000110011100000000011100;
            shape3mem[35] = 64'b1111111111111111110000000001111111110000000000111111111111111111;
            shape3mem[36] = 64'b0011100000001110000000000000011111000000000000001110000000011100;
            shape3mem[37] = 64'b0011100000001111110000000000000000000000000001111110000000011100;
            shape3mem[38] = 64'b0011100000111111000000000000000000000000000000011111100000011100;
            shape3mem[39] = 64'b0011111110000011100000000000000000000000000000111000011111111100;
            shape3mem[40] = 64'b1111100000000001110000000000000000000000000001110000000000011111;
            shape3mem[41] = 64'b0011100000000000011100000000000000000000000111000000000000011100;
            shape3mem[42] = 64'b0011100000000000000011111111111111111111111000000000000000011100;
            shape3mem[43] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape3mem[44] = 64'b0011100000000000000000000000000000000000000000000000000000011100;
            shape3mem[45] = 64'b0011100000000000000111111111111000000000000000000000000000011100;
            shape3mem[46] = 64'b0011100000000000011111111111111111111111100000000000000000011100;
            shape3mem[47] = 64'b0011100000000001111111111111111111111111111111111110000000011100;
            shape3mem[48] = 64'b0011101111111111111111111111111111111111111111111111100011111100;	
            shape3mem[49] = 64'b0011111111111111111111111111111111111111111111111111111111111100;
            shape3mem[50] = 64'b0011111111111111111111111111111111111111111111111111111111111110;
            shape3mem[51] = 64'b1111111111111111111111111111111111111111111111111111111111111111;
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
               //     VGA_R = 0;  
               //     VGA_G = 0;  
               //     VGA_B = 0;                 

                    VGA_G = ((outW)||(outH)||(outAB)||(outC)||(outK)||(outD1)||(outAC)||(outD2)||(outM)||(outO)||(outLD)||(outEC)||(outP)||(outLA)||(outAA)||(outY)||(outLB)||(outEA)||(outV)||(outEB)||(outLC)||(outone)||(outtwo)||(outthree)) ? 15:0;
                    VGA_B = ((outW)||(outH)||(outAB)||(outC)||(outK)||(outD1)||(outAC)||(outD2)||(outM)||(outO)||(outLD)||(outEC)||(outP)||(outLA)||(outAA)||(outY)||(outLB)||(outEA)||(outV)||(outEB)||(outLC)||(outone)||(outtwo)||(outthree)) ? 15:0;
                    VGA_R = ((outW)||(outH)||(outAB)||(outC)||(outK)||(outD1)||(outAC)||(outD2)||(outM)||(outO)||(outLD)||(outEC)||(outP)||(outLA)||(outAA)||(outY)||(outLB)||(outEA)||(outV)||(outEB)||(outLC)||(outone)||(outtwo)||(outthree)) ? 15:0;

             if ((horizontal_position >=  260 + 5 ) && (horizontal_position <  260 + 69) && (vertical_position >= 250 - 52) && (vertical_position < 250)) begin
                         VGA_R <= (shape1mem[vertical_position - (250 - 52)][horizontal_position - (260 + 5)]) * (135 / 15);
                         VGA_G <= (shape1mem[vertical_position - (250 - 52)][horizontal_position - (260 + 5)]) * (90 / 15);
                         VGA_B <= (shape1mem[vertical_position - (250 - 52)][horizontal_position - (260 + 5)]) * (30 / 15);
             end
             if ((horizontal_position >=  360 + 5 ) && (horizontal_position <  360 + 69) && (vertical_position >= 250 - 52) && (vertical_position < 250)) begin
                         VGA_R <= (shape2mem[vertical_position - (250 - 52)][horizontal_position - (360 + 5)]) * (120 / 15);
                         VGA_G <= (shape2mem[vertical_position - (250 - 52)][horizontal_position - (360 + 5)]) * (90 / 15);
                         VGA_B <= (shape2mem[vertical_position - (250 - 52)][horizontal_position - (360 + 5)]) * (75 / 15);
            end
            if ((horizontal_position >=  160 + 5 ) && (horizontal_position <  160 + 69) && (vertical_position >= 250 - 52) && (vertical_position < 250)) begin
                         VGA_R <= (shape3mem[vertical_position - (250 - 52)][horizontal_position - (160 + 5)]) * (150 / 15);
                         VGA_G <= (shape3mem[vertical_position - (250 - 52)][horizontal_position - (160 + 5)]) * (105 / 15);
                         VGA_B <= (shape3mem[vertical_position - (250 - 52)][horizontal_position - (160 + 5)]) * (60 / 15);
            end
            if ((horizontal_position >=  367 ) && (horizontal_position <  371) && (vertical_position >= 285) && (vertical_position < 307)) begin
                         VGA_R <= 15;
                         VGA_G <= 15;
                         VGA_B <= 15;
            end
           if ((horizontal_position >=  367 ) && (horizontal_position <  371) && (vertical_position >= 311) && (vertical_position < 315)) begin
                         VGA_R <= 15;
                         VGA_G <= 15;
                         VGA_B <= 15;
            end
                    
                    //Display mouse
                    if(video_on) begin
			         if(mouse_on) begin //mouse color
				        VGA_R <={4{mouse_color_q[0]}};
				        VGA_G <={4{mouse_color_q[1]}};
				        VGA_B <={4{mouse_color_q[2]}};
			         end
	               end
                    
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










