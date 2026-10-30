`timescale 1ns / 1ps

module vga_game_display(
    input [9:0] x,
    input [8:0] y,
    input read_en_n,

    input [3:0] target_led,
    input [7:0] score,
    input [1:0] error_cnt,
    input [3:0] level,
    input game_over,

    output reg [11:0] rgb_real
);

// 颜色格式：{Blue[3:0], Green[3:0], Red[3:0]}
localparam [11:0] BLACK   = 12'h000;
localparam [11:0] WHITE   = 12'hFFF;
localparam [11:0] GRAY    = 12'h555;
localparam [11:0] DGRAY   = 12'h222;
localparam [11:0] RED     = 12'h00F;
localparam [11:0] GREEN   = 12'h0F0;
localparam [11:0] BLUE    = 12'hF00;
localparam [11:0] YELLOW  = 12'h0FF;
localparam [11:0] CYAN    = 12'hFF0;
localparam [11:0] MAGENTA = 12'hF0F;
localparam [11:0] ORANGE  = 12'h06F;

wire [3:0] score_tens = (score / 10) % 10;
wire [3:0] score_ones = score % 10;

function in_box;
    input [9:0] px;
    input [8:0] py;
    input [9:0] x0;
    input [9:0] x1;
    input [8:0] y0;
    input [8:0] y1;
    begin
        in_box = (px >= x0) && (px < x1) && (py >= y0) && (py < y1);
    end
endfunction

// seg7 返回 {a,b,c,d,e,f,g}
function [6:0] seg7;
    input [3:0] d;
    begin
        case (d)
            4'd0: seg7 = 7'b1111110;
            4'd1: seg7 = 7'b0110000;
            4'd2: seg7 = 7'b1101101;
            4'd3: seg7 = 7'b1111001;
            4'd4: seg7 = 7'b0110011;
            4'd5: seg7 = 7'b1011011;
            4'd6: seg7 = 7'b1011111;
            4'd7: seg7 = 7'b1110000;
            4'd8: seg7 = 7'b1111111;
            4'd9: seg7 = 7'b1111011;
            default: seg7 = 7'b0000001;
        endcase
    end
endfunction

function digit_pixel;
    input [9:0] px;
    input [8:0] py;
    input [9:0] x0;
    input [8:0] y0;
    input [3:0] digit;
    reg [6:0] s;
    begin
        s = seg7(digit);
        digit_pixel =
            (s[6] && in_box(px, py, x0 + 10'd6,  x0 + 10'd34, y0,          y0 + 9'd6 )) || // a
            (s[5] && in_box(px, py, x0 + 10'd34, x0 + 10'd40, y0 + 9'd6,   y0 + 9'd34)) || // b
            (s[4] && in_box(px, py, x0 + 10'd34, x0 + 10'd40, y0 + 9'd40,  y0 + 9'd68)) || // c
            (s[3] && in_box(px, py, x0 + 10'd6,  x0 + 10'd34, y0 + 9'd68,  y0 + 9'd74)) || // d
            (s[2] && in_box(px, py, x0,          x0 + 10'd6,  y0 + 9'd40,  y0 + 9'd68)) || // e
            (s[1] && in_box(px, py, x0,          x0 + 10'd6,  y0 + 9'd6,   y0 + 9'd34)) || // f
            (s[0] && in_box(px, py, x0 + 10'd6,  x0 + 10'd34, y0 + 9'd34,  y0 + 9'd40));   // g
    end
endfunction

wire score_digit0 = digit_pixel(x, y, 10'd80,  9'd25, score_tens);
wire score_digit1 = digit_pixel(x, y, 10'd130, 9'd25, score_ones);
wire level_digit  = digit_pixel(x, y, 10'd310, 9'd25, level);
wire error_digit  = digit_pixel(x, y, 10'd500, 9'd25, {2'b00, error_cnt});

wire lane0 = in_box(x, y, 10'd70,  10'd170, 9'd170, 9'd430);
wire lane1 = in_box(x, y, 10'd200, 10'd300, 9'd170, 9'd430);
wire lane2 = in_box(x, y, 10'd330, 10'd430, 9'd170, 9'd430);
wire lane3 = in_box(x, y, 10'd460, 10'd560, 9'd170, 9'd430);

wire lane0_border = in_box(x, y, 10'd68,  10'd172, 9'd168, 9'd432) && !lane0;
wire lane1_border = in_box(x, y, 10'd198, 10'd302, 9'd168, 9'd432) && !lane1;
wire lane2_border = in_box(x, y, 10'd328, 10'd432, 9'd168, 9'd432) && !lane2;
wire lane3_border = in_box(x, y, 10'd458, 10'd562, 9'd168, 9'd432) && !lane3;

wire hit_zone = in_box(x, y, 10'd55, 10'd575, 9'd355, 9'd415);

// 4个方向提示块：哪个 target_led 亮，就把对应轨道画亮
wire target0 = target_led[0];
wire target1 = target_led[1];
wire target2 = target_led[2];
wire target3 = target_led[3];

wire gameover_cross1 = (x > 10'd150 && x < 10'd490 && y > 9'd180 && y < 9'd420 && ((x - 10'd150) > (y - 9'd180)) && ((x - 10'd150) < (y - 9'd180) + 10'd35));
wire gameover_cross2 = (x > 10'd150 && x < 10'd490 && y > 9'd180 && y < 9'd420 && ((x - 10'd150) + (y - 9'd180) > 10'd300) && ((x - 10'd150) + (y - 9'd180) < 10'd335));

always @(*) begin
    if (read_en_n) begin
        rgb_real = BLACK;
    end
    else if (game_over) begin
        if (gameover_cross1 || gameover_cross2)
            rgb_real = WHITE;
        else if (score_digit0 || score_digit1 || level_digit || error_digit)
            rgb_real = YELLOW;
        else
            rgb_real = RED;
    end
    else begin
        // 默认背景
        rgb_real = 12'h111;

        // 上方计分区：左边 score，中间 level，右边 error
        if (in_box(x, y, 10'd40, 10'd210, 9'd15, 9'd115))
            rgb_real = 12'h112;
        if (in_box(x, y, 10'd270, 10'd380, 9'd15, 9'd115))
            rgb_real = 12'h121;
        if (in_box(x, y, 10'd460, 10'd570, 9'd15, 9'd115))
            rgb_real = 12'h211;

        if (score_digit0 || score_digit1)
            rgb_real = CYAN;
        if (level_digit)
            rgb_real = GREEN;
        if (error_digit)
            rgb_real = ORANGE;

        // 命中判定区
        if (hit_zone)
            rgb_real = 12'h333;

        // 轨道边框
        if (lane0_border || lane1_border || lane2_border || lane3_border)
            rgb_real = GRAY;

        // 轨道内部
        if (lane0)
            rgb_real = target0 ? RED : DGRAY;
        if (lane1)
            rgb_real = target1 ? GREEN : DGRAY;
        if (lane2)
            rgb_real = target2 ? BLUE : DGRAY;
        if (lane3)
            rgb_real = target3 ? YELLOW : DGRAY;

        // 每个轨道底部画一个亮的“按键区”
        if (in_box(x, y, 10'd80,  10'd160, 9'd365, 9'd405)) rgb_real = target0 ? WHITE : 12'h444;
        if (in_box(x, y, 10'd210, 10'd290, 9'd365, 9'd405)) rgb_real = target1 ? WHITE : 12'h444;
        if (in_box(x, y, 10'd340, 10'd420, 9'd365, 9'd405)) rgb_real = target2 ? WHITE : 12'h444;
        if (in_box(x, y, 10'd470, 10'd550, 9'd365, 9'd405)) rgb_real = target3 ? WHITE : 12'h444;
    end
end

endmodule
