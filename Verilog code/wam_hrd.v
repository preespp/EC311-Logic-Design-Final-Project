// Hardness control
//
// by nyLiao, April, 2019

module wam_par (            // decide hardness parameters 
// we modified difficulty parameter
    input wire [1:0] hrdn,
    output reg [3:0] age,
    output reg [7:0] rto
    );

// More age means more chance of appearing on the same spot (easier)
// More rto means more number to pop up and more chance of reset before reaching age

    always @ ( * ) begin
        case (hrdn)
            'h1: begin
                age <= 4'd09;
                rto <= 120;
            end
            'h2: begin
                age <= 4'd06;
                rto <= 195;
            end
            'h3: begin   
                age <= 4'd04;
                rto <= 255;
            end
        endcase
    end
endmodule // wam_par


module wam_tch (            // input button
    input wire clk_19,
    input wire btn,
    output reg tch              // active high
   );

    reg  btn_pre;               // button last status
    wire btn_edg;               // posedge trigger
    reg  [3:0] btn_cnt;         // counter

    always @(posedge clk_19)    // posedge detection
        btn_pre <= btn;
    assign btn_edg = (~btn_pre) & (btn);

    always @ (posedge clk_19) begin
        if (btn_cnt > 0) begin                  // filtering
            if (btn_cnt > 4'b0100) begin        // stable
                btn_cnt <= 4'b0000;
                tch <= 1;                       // output status
            end
            else begin
                if (btn_edg) begin              // if button then back to idle
                    btn_cnt <= 0;
               end
                else begin                      // count
                    btn_cnt <= btn_cnt + 1;
                end
            end
        end
        else begin                              // idle
            tch <= 0;
            if (btn_edg) begin                  // if button pressed then start filtering
                btn_cnt <= 4'b0001;
            end
        end
    end
 endmodule // wam_tch

 module wam_hrd (            // hardness control
    input wire clk_19,
    input wire start,
    input wire lft,
    input wire rgt,black,
    input wire cout0,
    output reg [1:0] hrdn          // hardness of 0~9 or H (hard) modify to easy medium hard
    );

    wire lfts;      // stable left button
    wire rgts;      // stable right button
    wire cout0s;    // shorter carry signal

    wire harder;
   wire easier;

    wam_tch tchl( .clk_19(clk_19), .btn(lft), .tch(lfts));
    wam_tch tchr( .clk_19(clk_19), .btn(rgt), .tch(rgts));
    wam_tch tchc( .clk_19(clk_19), .btn(cout0), .tch(cout0s));
    assign easier = lfts;
    assign harder = rgts | cout0s;

    always @ (posedge clk_19) begin
        if (start)
            hrdn <= 1;
        else if (easier) begin          // lft: easier
            if (hrdn > 1) begin
                hrdn <= hrdn - 1'd1;
            end
        end
        else if (harder) begin          // rgt or cout0: harder
            if (hrdn < 3) begin
                hrdn <= hrdn + 1'd1;
            end
        end
    end
endmodule // wam_hrd
