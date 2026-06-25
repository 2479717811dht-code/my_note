`timescale 1ns / 1ps

module vga_game_display(
    input vga_clk,
    input [9:0] x,
    input [8:0] y,
    input read_en_n,

    input [1:0] game_state,
    input [7:0] score,
    input [1:0] error_cnt,
    input [3:0] level,

    input [9:0] note0_x, input [1:0] note0_type, input note0_active,
    input [9:0] note1_x, input [1:0] note1_type, input note1_active,
    input [9:0] note2_x, input [1:0] note2_type, input note2_active,
    input [9:0] note3_x, input [1:0] note3_type, input note3_active,

    input [9:0] avatar_x,
    input [8:0] avatar_y,

    output reg [11:0] rgb_real
);

    // 你的 VGA_Driver 按 BGR444 解释颜色：
    // [11:8] = B，[7:4] = G，[3:0] = R
    localparam [11:0] BLACK    = 12'h000;
    localparam [11:0] WHITE    = 12'hFFF;
    localparam [11:0] CYAN     = 12'hFF0;
    localparam [11:0] GREEN    = 12'h0F0;
    localparam [11:0] ORANGE   = 12'h06F;
    localparam [11:0] PINK     = 12'hF0F;
    localparam [11:0] TRACK_BG = 12'h111;

    localparam [1:0] STATE_MENU = 2'b00;
    localparam [1:0] STATE_PLAY = 2'b01;
    localparam [1:0] STATE_FAIL = 2'b10;
    localparam [1:0] STATE_WIN  = 2'b11;

    // ============================================================
    // 区域判断函数
    // ============================================================
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

    // ============================================================
    // 七段风格数字绘制函数，区域约 20x40
    // ============================================================
    function draw_digit;
        input [3:0] num;
        input [9:0] dx;
        input [8:0] dy;
        reg [6:0] seg;
        begin
            // seg = {a,b,c,d,e,f,g}
            case (num)
                4'd0: seg = 7'b1111110;
                4'd1: seg = 7'b0110000;
                4'd2: seg = 7'b1101101;
                4'd3: seg = 7'b1111001;
                4'd4: seg = 7'b0110011;
                4'd5: seg = 7'b1011011;
                4'd6: seg = 7'b1011111;
                4'd7: seg = 7'b1110000;
                4'd8: seg = 7'b1111111;
                4'd9: seg = 7'b1111011;
                default: seg = 7'b0000000;
            endcase

            draw_digit =
                // a: top
                (seg[6] && (dy <= 3)  && (dx >= 2  && dx <= 18)) ||
                // b: upper-right
                (seg[5] && (dx >= 17) && (dy <= 20))             ||
                // c: lower-right
                (seg[4] && (dx >= 17) && (dy >= 20))             ||
                // d: bottom
                (seg[3] && (dy >= 37) && (dx >= 2  && dx <= 18)) ||
                // e: lower-left
                (seg[2] && (dx <= 3)  && (dy >= 20))             ||
                // f: upper-left
                (seg[1] && (dx <= 3)  && (dy <= 20))             ||
                // g: middle
                (seg[0] && (dy >= 18 && dy <= 21) && (dx >= 2 && dx <= 18));
        end
    endfunction

    // ============================================================
    // 背景 ROM：640x480 原生显示，不再放大
    // bg_data.mem 必须是 640*480 = 307200 行
    // ============================================================
    wire [11:0] bg_rgb_out;
    bg_rom u_bg_rom (
        .clk(vga_clk),
        .row(y),
        .col(x),
        .rgb(bg_rgb_out)
    );

    // ============================================================
    // 菜单文字 ROM：640x128 原生显示
    // menu_data.mem 必须是 640*128 = 81920 行
    // 只在 STATE_MENU 显示，黑色 000 当透明
    // ============================================================
    wire menu_on = (game_state == STATE_MENU) &&
                   (x >= 10'd0)   && (x < 10'd640) &&
                   (y >= 9'd100)  && (y < 9'd228);

    wire [6:0] menu_rom_row = y - 9'd100;
    wire [9:0] menu_rom_col = x;
    wire [11:0] menu_rgb_out;

    menu_rom u_menu_rom (
        .clk(vga_clk),
        .row(menu_rom_row),
        .col(menu_rom_col),
        .rgb(menu_rgb_out)
    );

    // ============================================================
    // 结算文字 ROM：640x256
    // text_data.mem 必须是 640*256 = 163840 行
    // 0~127 行：胜利文字；128~255 行：失败文字
    // 屏幕显示区域 640x128，原生显示，不再放大
    // ============================================================
    wire text_on = (x >= 10'd0)   && (x < 10'd640) &&
                   (y >= 9'd176)  && (y < 9'd304);

    wire [7:0] text_local_row = y - 9'd176;
    wire [7:0] text_rom_row = (game_state == STATE_WIN) ? text_local_row
                                                         : (text_local_row + 8'd128);
    wire [9:0] text_rom_col = x;
    wire [11:0] text_rgb_out;

    text_rom u_text_rom (
        .clk(vga_clk),
        .row(text_rom_row),
        .col(text_rom_col),
        .rgb(text_rgb_out)
    );

    // ============================================================
    // 跑道、判定框、HUD
    // ============================================================
    wire bottom_track = in_box(x, y, 10'd0, 10'd640, 9'd400, 9'd450);

    wire judge_box_border = in_box(x, y, 10'd50, 10'd110, 9'd400, 9'd450) &&
                            !in_box(x, y, 10'd54, 10'd106, 9'd404, 9'd446);

    // 左上：score；中上：level；右上：error_cnt
    wire score_box = in_box(x, y, 10'd30, 10'd95,  9'd20, 9'd80) &&
                    !in_box(x, y, 10'd32, 10'd93,  9'd22, 9'd78);
    wire level_box = in_box(x, y, 10'd290,10'd330, 9'd20, 9'd80) &&
                    !in_box(x, y, 10'd292,10'd328, 9'd22, 9'd78);
    wire error_box = in_box(x, y, 10'd550,10'd590, 9'd20, 9'd80) &&
                    !in_box(x, y, 10'd552,10'd588, 9'd22, 9'd78);

    wire score_pix = in_box(x, y, 10'd40, 10'd60, 9'd30, 9'd70) ?
                     draw_digit(score / 10, x - 10'd40, y - 9'd30) :
                     in_box(x, y, 10'd65, 10'd85, 9'd30, 9'd70) ?
                     draw_digit(score % 10, x - 10'd65, y - 9'd30) : 1'b0;

    wire level_pix = in_box(x, y, 10'd300,10'd320, 9'd30, 9'd70) ?
                     draw_digit(level, x - 10'd300, y - 9'd30) : 1'b0;

    wire error_pix = in_box(x, y, 10'd560,10'd580, 9'd30, 9'd70) ?
                     draw_digit({2'b00, error_cnt}, x - 10'd560, y - 9'd30) : 1'b0;

    // ============================================================
    // 音符箭头绘制
    // note_type：00=W 上，01=S 下，10=A 左，11=D 右
    // ============================================================
    reg arrow_active;
    reg [4:0] dx;
    reg [4:0] dy;
    reg [1:0] cur_type;
    reg arrow_pixel;

    always @(*) begin
        arrow_active = 1'b0;
        dx = 5'd0;
        dy = 5'd0;
        cur_type = 2'd0;

        if (note0_active && (x >= note0_x) && (x < note0_x + 10'd32) &&
            (y >= 9'd409) && (y < 9'd441)) begin
            arrow_active = 1'b1;
            dx = x - note0_x;
            dy = y - 9'd409;
            cur_type = note0_type;
        end else if (note1_active && (x >= note1_x) && (x < note1_x + 10'd32) &&
                     (y >= 9'd409) && (y < 9'd441)) begin
            arrow_active = 1'b1;
            dx = x - note1_x;
            dy = y - 9'd409;
            cur_type = note1_type;
        end else if (note2_active && (x >= note2_x) && (x < note2_x + 10'd32) &&
                     (y >= 9'd409) && (y < 9'd441)) begin
            arrow_active = 1'b1;
            dx = x - note2_x;
            dy = y - 9'd409;
            cur_type = note2_type;
        end else if (note3_active && (x >= note3_x) && (x < note3_x + 10'd32) &&
                     (y >= 9'd409) && (y < 9'd441)) begin
            arrow_active = 1'b1;
            dx = x - note3_x;
            dy = y - 9'd409;
            cur_type = note3_type;
        end
    end

    always @(*) begin
        case (cur_type)
            // 上箭头
            2'b00: arrow_pixel = (dy < 16 && dx + dy >= 15 && dx <= 16 + dy) ||
                                  (dy >= 16 && dx >= 13 && dx <= 18);
            // 下箭头
            2'b01: arrow_pixel = (dy >= 16 && dx + (5'd31 - dy) >= 15 && dx <= 16 + (5'd31 - dy)) ||
                                  (dy < 16 && dx >= 13 && dx <= 18);
            // 左箭头
            2'b10: arrow_pixel = (dx < 16 && dy + dx >= 15 && dy <= 16 + dx) ||
                                  (dx >= 16 && dy >= 13 && dy <= 18);
            // 右箭头
            2'b11: arrow_pixel = (dx >= 16 && dy + (5'd31 - dx) >= 15 && dy <= 16 + (5'd31 - dx)) ||
                                  (dx < 16 && dy >= 13 && dy <= 18);
            default: arrow_pixel = 1'b0;
        endcase
    end

    // ============================================================
    // 中央 Avatar，16x16 菱形
    // ============================================================
    wire avatar_on = (x >= avatar_x) && (x < avatar_x + 10'd16) &&
                     (y >= avatar_y) && (y < avatar_y + 9'd16);

    wire [3:0] ax = x - avatar_x;
    wire [3:0] ay = y - avatar_y;
    reg avatar_pixel;

    always @(*) begin
        case (ay)
            4'd0,  4'd15: avatar_pixel = (ax >= 7 && ax <= 8);
            4'd1,  4'd14: avatar_pixel = (ax >= 6 && ax <= 9);
            4'd2,  4'd13: avatar_pixel = (ax >= 5 && ax <= 10);
            4'd3,  4'd12: avatar_pixel = (ax >= 4 && ax <= 11);
            4'd4,  4'd11: avatar_pixel = (ax >= 3 && ax <= 12);
            4'd5,  4'd10: avatar_pixel = (ax >= 2 && ax <= 13);
            4'd6,  4'd9:  avatar_pixel = (ax >= 1 && ax <= 14);
            4'd7,  4'd8:  avatar_pixel = (ax >= 0 && ax <= 15);
            default:      avatar_pixel = 1'b0;
        endcase
    end

    // ============================================================
    // 图层混合
    // ============================================================
    always @(*) begin
        if (read_en_n) begin
            rgb_real = BLACK;
        end else begin
            // 先放高清背景
            rgb_real = bg_rgb_out;

            if (game_state == STATE_MENU) begin
                // 如果背景太花，可以取消下面两行注释，给菜单加暗底
                // if ((y >= 9'd90) && (y < 9'd238))
                //     rgb_real = BLACK;

                if (menu_on && (menu_rgb_out != BLACK))
                    rgb_real = menu_rgb_out;

            end else if (game_state == STATE_PLAY) begin
                if (bottom_track)
                    rgb_real = TRACK_BG;

                if (judge_box_border)
                    rgb_real = CYAN;

                if (arrow_active && arrow_pixel)
                    rgb_real = WHITE;

                if (avatar_on && avatar_pixel)
                    rgb_real = PINK;

                if (score_box) rgb_real = CYAN;
                if (score_pix) rgb_real = CYAN;

                if (level_box) rgb_real = GREEN;
                if (level_pix) rgb_real = GREEN;

                if (error_box) rgb_real = ORANGE;
                if (error_pix) rgb_real = ORANGE;

            end else if (game_state == STATE_FAIL || game_state == STATE_WIN) begin
                // 结算文字区域加黑底，提高对比度
                if (text_on)
                    rgb_real = BLACK;

                if (text_on && (text_rgb_out != BLACK))
                    rgb_real = text_rgb_out;
            end
        end
    end

endmodule
