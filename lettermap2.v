`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2023 12:46:12 PM
// Design Name: 
// Module Name: lettermap
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


module lettermap2(
input [6:0] lheight,
input [6:0] lwidth,
input [9:0] xstart,
input [8:0] ystart,
input [9:0] x,
input [8:0] y,
input [5:0] ID,
output reg value 
    );
    
 wire P1,P2,P3,P4,L1,L2,A1,A2,A3,A4,Y1,Y2,Y3,Y4,Y5,L3,L4,E1,E2,E3,E4,V1,V2,V3,V4,V5,E5,E6,E7,E8,L5,L6,one,two1,two2,two3,two4,two5,three1,three2,three3,three4;
 wire W1,W2,W3,W4,H1,H2,H3,A5,A6,A7,A8,C1,C2,C3,dash1,A9,A10,A11,A12,dash2,M1,M2,M3,M4,O1,O2,O3,O4,L7,L8,E9,E10,E11,E12;
 
 //reg outp, outl, outa, outy;
 //P
 assign P1 = ((x > xstart) & (y > ystart) & (y < ystart+lheight) & (x < xstart+(lwidth/5))) ? 1 : 0;
 assign P2 = ((x > xstart+(3*lwidth/5)) & (y > ystart) & (x < xstart+(4*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;
 assign P3 = ((x > xstart+(1*lwidth/5)) & (y > ystart) & (x < xstart+(3*lwidth/5)) & (y < ystart+(1*lheight/5))) ? 1:0;
 assign P4 = ((x > xstart+(1*lwidth/5)) & (y > ystart+(2*lwidth/5)) & (x < xstart+(3*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;
 
 //L1
 assign L1 = ((x > xstart) & (y > ystart) & (x < xstart+(lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 assign L2 = ((x > xstart+(lwidth/5)) & (y > ystart+(4*lheight/5)) & (x < xstart+(4*lwidth/5)) & (y < ystart+lheight)) ? 1:0;

//A2
assign A1 = ((x > xstart) & (y > ystart) & (y < ystart+lheight) & (x < xstart+(lwidth/5))) ? 1 : 0;
assign A2 = ((x > xstart+(2*lwidth/5)) & (y > ystart) & (x < xstart+(3*lwidth/5)) & (y < ystart+lheight)) ? 1:0;
assign A3 = ((x > xstart+(lwidth/5)) & (y > ystart) & (x < xstart+(2*lwidth/5)) & (y < ystart+(lwidth/5))) ? 1:0;
assign A4 = ((x > xstart+(lwidth/5)) & (y > ystart+(2*lheight/5)) & (x < xstart+(2*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;


//Y
assign Y1 = ((x > xstart) & (y > ystart) & (y < ystart+(lwidth/5)) & (x < xstart+(lheight/5))) ? 1:0;
assign Y2 = ((x > xstart+(lwidth/5)) & (y > ystart+(lheight/5)) & (x < xstart+(2*lwidth/5)) & (y < ystart+(2*lheight/5))) ? 1:0;
assign Y3 = ((x > xstart+(2*lheight/5)) & (y > ystart+(2*lheight/5)) & (x < xstart+(3*lwidth/5)) & (y < (ystart+lheight))) ? 1:0;
assign Y4 = ((x > xstart+(3*lwidth/5)) & (y > ystart+(lheight/5)) & (x < xstart+(4*lwidth/5)) & (y < (ystart+2*lheight/5))) ? 1:0;
assign Y5 = ((x > xstart+(4*lwidth/5)) & (y > ystart) & (y < ystart+(lheight/5)) & (x < xstart+lwidth)) ? 1:0;



//L2
 assign L3 = ((x > xstart) & (y > ystart) & (x < xstart+(lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 assign L4 = ((x > xstart+(lwidth/5)) & (y > ystart+(4*lheight/5)) & (x < xstart+(4*lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 
 //E1
 assign E1 = ((x > xstart) & (y > ystart) & (x < xstart+(lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 assign E2 = ((x > xstart+(lwidth/5)) & (y > ystart) & (x<xstart+(4*lwidth/5)) & (y < ystart+lheight/5)) ? 1:0;
 assign E3 = ((x > xstart+(lwidth/5)) & (y > ystart+(2*lheight/5)) & (x<xstart+(3*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;
 assign E4 = ((x > xstart+(lwidth/5)) & (y > ystart+(4*lheight/5)) & (x<xstart+(4*lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 
 //v
 assign V1 = ((x > xstart) & (y > ystart) & (x < xstart+(lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;
 assign V2 = ((x > xstart+(4*lwidth/5)) & (y > ystart) & (x < xstart+lwidth) & (y < ystart+(3*lheight/5))) ? 1:0;
 assign V3 = ((x > xstart+lwidth/5) & (y > ystart+(3*lheight/5)) & (x < xstart+(2*lwidth/5)) & (y < ystart+(4*lheight/5))) ? 1:0;
 assign V4 = ((x > xstart+(2*lwidth/5)) & (y > ystart+(4*lheight/5)) & (x < xstart+(3*lwidth/5)) & (y < ystart+lheight)) ? 1:0;  
 assign V5 = ((x > xstart+(3*lwidth/5)) & (y > ystart+(3*lheight/5)) & (x < xstart+(4*lwidth/5)) & (y < ystart+(4*lheight/5))) ? 1:0;
  
//E2
 assign E5 = ((x > xstart) & (y > ystart) & (x < xstart+(lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 assign E6 = ((x > xstart+(lwidth/5)) & (y > ystart) & (x<xstart+(4*lwidth/5)) & (y < ystart+lheight/5)) ? 1:0;
 assign E7 = ((x > xstart+(lwidth/5)) & (y > ystart+(2*lheight/5)) & (x<xstart+(3*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;
 assign E8 = ((x > xstart+(lwidth/5)) & (y > ystart+(4*lheight/5)) & (x<xstart+(4*lwidth/5)) & (y < ystart+lheight)) ? 1:0;   
   
 //L3
 assign L5 = ((x > xstart) & (y > ystart) & (x < xstart+(lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 assign L6 = ((x > xstart+(lwidth/5)) & (y > ystart+(4*lheight/5)) & (x < xstart+(4*lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 
 
 
 //1
 assign one = ((x > xstart+(2*lwidth/5)) & (y > ystart) & (x < xstart+(3*lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 
 //2
 assign two1 = ((x > xstart) & (y > ystart) & (x < xstart+lwidth) & (y < ystart+lheight/5)) ? 1:0;
 assign two2 = ((x > xstart) & (y > ystart+(4*lheight/5)) & (x < xstart+lwidth) & (y < ystart+lheight)) ? 1:0;
 assign two3 = ((x > xstart) & (y > ystart+(2*lheight/5)) & (x < xstart+lwidth) & (y < ystart+(3*lheight/5))) ? 1:0;
 assign two4 = ((x > xstart+(4*lwidth/5)) & (y > ystart) & (x < xstart+lwidth) & (y < ystart+(2*lheight/5))) ? 1:0;
 assign two5 = ((x > xstart) & (y > ystart+(3*lheight/5)) & (x < xstart+lwidth/5) & (y < ystart+(4*lheight/5))) ? 1:0;

//3
assign three1 = ((x > xstart+(4*lwidth/5)) & (y>ystart) & (x<xstart+lwidth) & (y < ystart+lheight)) ? 1:0; 
assign three2 = ((x > xstart) & (y>ystart) & (x<xstart+lwidth) & (y < ystart+lheight/5)) ? 1:0; 
assign three3 = ((x > xstart+(2*lwidth/5)) & (y>ystart+(2*lheight/5)) & (x<xstart+(4*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0; 
assign three4 = ((x > xstart) & (y>ystart+(4*lheight/5)) & (x<xstart+(4*lwidth/5)) & (y < ystart+lheight)) ? 1:0; 

 
 //W
 assign W1 = ((x > xstart) & (y > ystart) & (x < xstart+lwidth/5) & (y < ystart+lheight)) ? 1:0;
 assign W2 = ((x > xstart+(4*lwidth/5)) & (y > ystart) & (x < xstart+lwidth) & (y < ystart+lheight)) ? 1:0;
assign W3 = ((x > xstart+lwidth/5) & (y > ystart+(4*lheight/5)) & (x < xstart+(4*lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 assign W4 = ((x > xstart+(2*lwidth/5)) & (y > ystart+(3*lheight/5)) & (x < xstart+(3*lwidth/5)) & (y < ystart+(4*lheight/5))) ? 1:0;
 
 //H
 assign H1 = ((x > xstart) & (y > ystart) & (x < xstart+lwidth/5) & (y < ystart+lheight)) ? 1:0;
 assign H2 = ((x > xstart+(4*lwidth/5)) & (y > ystart) & (x < xstart+lwidth) & (y < ystart+lheight)) ? 1:0;
 assign H3 = ((x > xstart+lwidth/5) & (y> ystart+(2*lheight/5)) & (x < xstart+(4*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;
 
 //A2
assign A5 = ((x > xstart) & (y > ystart) & (y < ystart+lheight) & (x < xstart+(lwidth/5))) ? 1 : 0;
assign A6 = ((x > xstart+(4*lwidth/5)) & (y > ystart) & (x < xstart+lwidth) & (y < ystart+lheight)) ? 1:0;
assign A7 = ((x > xstart+lwidth/5) & (y > ystart) & (x < xstart+(4*lwidth/5)) & (y < ystart+lwidth/5)) ? 1:0;
assign A8 = ((x > xstart+lwidth/5) & (y > ystart+(2*lheight/5)) & (x < xstart+(4*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;

//C 

assign C1 = ((x > xstart) & (y > ystart) & (x < xstart+lwidth) & (y < ystart+lheight/5)) ? 1:0;
assign C2 = ((x > xstart) & (y > ystart+(4*lheight/5)) & (x < xstart+lwidth) & (y < ystart+lheight)) ? 1:0;
assign C3 = ((x > xstart) & (y > ystart+lheight/5) & (x < xstart+lwidth/5) & (y < ystart+(4*lheight/5))) ? 1:0;

//dash1 

assign dash1 = ((x> xstart+lwidth/5) & (y>ystart+(2*lheight/5)) & (x<xstart+(4*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;

//A3
assign A9 = ((x > xstart) & (y > ystart) & (y < ystart+lheight) & (x < xstart+(lwidth/5))) ? 1 : 0;
assign A10 = ((x > xstart+(2*lwidth/5)) & (y > ystart) & (x < xstart+(3*lwidth/5)) & (y < ystart+lheight)) ? 1:0;
assign A11 = ((x > xstart+(lwidth/5)) & (y > ystart) & (x < xstart+(2*lwidth/5)) & (y < ystart+(lwidth/5))) ? 1:0;
assign A12 = ((x > xstart+(lwidth/5)) & (y > ystart+(2*lheight/5)) & (x < xstart+(2*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;


//dash2 

assign dash2 = ((x> xstart+lwidth/5) & (y>ystart+(2*lheight/5)) & (x<xstart+(4*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;


//M
 assign M1 = ((x > xstart) & (y > ystart) & (x < xstart+lwidth/5) & (y < ystart+lheight)) ? 1:0;
 assign M2 = ((x > xstart+(4*lwidth/5)) & (y > ystart) & (x < xstart+lwidth) & (y < ystart+lheight)) ? 1:0;
 assign M3 = ((x>xstart+lwidth/5) & (y>ystart) & (x<xstart+(4*lwidth/5)) & (y<ystart+lheight/5)) ?1:0;
 assign M4 = ((x>xstart+(2*lwidth/5)) & (y>ystart+(lheight/5)) & (x<xstart+(3*lwidth/5)) & (y<ystart+(3*lheight/5))) ?1:0;
 
 //O
 assign O1 = ((x>xstart+lwidth/5) & (y>ystart) & (x<xstart+(4*lwidth/5)) & (y<ystart+lheight/5)) ?1:0;
 assign O2 = ((x>xstart+(4*lwidth/5)) & (y>ystart+lheight/5) & (x<xstart+lwidth) & (y<ystart+(4*lheight/5))) ?1:0;
 assign O3 = ((x>xstart+lwidth/5) & (y>ystart+(4*lheight/5)) & (x<xstart+(4*lwidth/5)) & (y<ystart+lheight)) ?1:0;
 assign O4 = ((x>xstart) & (y>ystart+lheight/5) & (x<xstart+lwidth/5) & (y<ystart+(4*lheight/5))) ?1:0;


//L4
 assign L7 = ((x > xstart) & (y > ystart) & (x < xstart+(lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 assign L8 = ((x > xstart+(lwidth/5)) & (y > ystart+(4*lheight/5)) & (x < xstart+(4*lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 
 
//E3
 assign E9 = ((x > xstart) & (y > ystart) & (x < xstart+(lwidth/5)) & (y < ystart+lheight)) ? 1:0;
 assign E10 = ((x > xstart+(lwidth/5)) & (y > ystart) & (x<xstart+(4*lwidth/5)) & (y < ystart+lheight/5)) ? 1:0;
 assign E11 = ((x > xstart+(lwidth/5)) & (y > ystart+(2*lheight/5)) & (x<xstart+(3*lwidth/5)) & (y < ystart+(3*lheight/5))) ? 1:0;
 assign E12 = ((x > xstart+(lwidth/5)) & (y > ystart+(4*lheight/5)) & (x<xstart+(4*lwidth/5)) & (y < ystart+lheight)) ? 1:0;   





 
 always @(x,y) begin 
 case (ID)
 0: value = P1+P2+P3+P4;
 1: value = L1+L2;
 2: value = A1+ A2+A3+A4;
 3: value = Y1+Y2+Y3+Y4+Y5; 
 4: value = L3+L4;
 5: value = E1+E2+E3+E4;
 6: value = V1+V2+V3+V4+V5;
 7: value = E5+E6+E7+E8;
 8: value = L5+L6;
 9: value = one;
 10: value = two1+two2+two3+two4+two5;
 11: value = three1+three2+three3+three4;
 12: value = W1+W2+W3+W4;
 13: value = H1+H2+H3;
 14: value = A5+A6+A7+A8;
 15: value = C1+C2+C3;
 16: value = dash1;
 17: value = A9+A10+A11+A12;
 18: value = dash2;
 19: value = M1+M2+M3+M4;
 20: value = O1+O2+O3+O4;
 21: value = L7+L8;
 22: value = E9+E10+E11+E12;
 
 
 
 endcase
 end
    
    
endmodule
