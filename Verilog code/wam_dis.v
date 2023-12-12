// LED and digital tube display
//
// by nyLiao, April, 2019

module wam_led (            // LED output
    input  wire [7:0] holes,
    output wire [7:0] ld
    );

    assign ld = holes;
endmodule // wam_led

module wam_obd(             // 1-bit digital tube output
    input wire [3:0] num,
    output reg [6:0] a2g
    );

    always @(*) begin
        case(num)
            'h0: a2g=7'b0000001;
            'h1: a2g=7'b1001111;
            'h2: a2g=7'b0010010;
            'h3: a2g=7'b0000110;
            'h4: a2g=7'b1001100;
            'h5: a2g=7'b0100100;
            'h6: a2g=7'b0100000;
            'h7: a2g=7'b0001111;
            'h8: a2g=7'b0000000;
            'h9: a2g=7'b0000100;
            'hA: a2g=7'b0001000;       
            'hB: a2g=7'b1100000;       
            'hC: a2g=7'b0110001;
            'hD: a2g=7'b1000010;
            'hE: a2g=7'b0110000;
            'hF: a2g=7'b0111000;      
            default: a2g=7'b1111111;    // default is blank
        endcase
    end
endmodule // wam_obd

module wam_dis(             // handle digital tube output
    input clk_16,
    input wire [4:0] time_display,
    input wire  [3:0]  hrdn,
    input wire  [11:0] score,
    output reg  [7:0]  an,
    output [6:0]  a2g
    );

    reg [2:0] clk_16_cnt;   // counter
    reg [3:0] dnum;         // displaying number

    always @ (posedge clk_16) begin
        clk_16_cnt <= clk_16_cnt + 1;
    end

    always @(*) begin
        case(clk_16_cnt)    // choose which tube to display
            3'b000: begin
                dnum = score[3:0];
                an = 8'b11111110;
            end
            3'b001: begin
                dnum = score[7:4];
                an = 8'b11111101;
            end
            3'b010: begin
                dnum = score[11:8];
                an = 8'b11111011;
            end
            3'b011: begin
                dnum = hrdn;
                an = 8'b11110111;
            end
            3'b100: begin
                dnum = time_display%10;
                an = 8'b11101111;
            end
            3'b101: begin
                dnum = (time_display-time_display%10)/10;
                an = 8'b11011111;
            end
            3'b110: begin
                dnum = 0;
                an = 8'b10111111;
            end
            3'b111: begin
                dnum = 0;
                an = 8'b01111111;
            end
        endcase
    end
    wam_obd obd( .num(dnum), .a2g(a2g) );
endmodule // wam_dis
