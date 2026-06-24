`timescale 1ns / 1ps

module top_game_system(
    input clk,                  // 100MHz 主时钟 (对应 AC18)
    input rstn,                 // 外部复位按键，低电平有效 (对应 W13)
    input [3:0] BTN,            // 4个方向按键 (对应 W14, V14, V19, V18)
    
    output [7:0] LED,           // 8个LED灯 (对应 W23 ~ AF24)
    output [7:0] SEGMENT,       // 数码管段选 (对应 AB22 ~ AA22)
    output [3:0] AN,            // 数码管位选 (对应 AD21 ~ AC22)
    
    // VGA 接口
    output [3:0] r,             // 红色信号 4位 (对应 N21 ~ P21)
    output [3:0] g,             // 绿色信号 4位 (对应 R22 ~ T25)
    output [3:0] b,             // 蓝色信号 4位 (对应 T20 ~ T23)
    output hs,                  // 行同步 (对应 M22)
    output vs                   // 场同步 (对应 M21)
);

    // --- 1. VGA 25MHz 像素时钟分频 (100MHz 执行 4分频) ---
    reg [1:0] clk_div = 2'b00;
    always @(posedge clk) begin
        clk_div <= clk_div + 1;
    end
    wire vga_clk = clk_div[1]; 

    // --- 2. 按键消抖例化 ---
    wire [3:0] btn_debounced;
    genvar i;
    generate
        for(i = 0; i < 4; i = i + 1) begin: debounce_block
            debounce u_debounce (
                .clk(clk),
                .key_in(BTN[i]),
                .key_out(btn_debounced[i])
            );
        end
    endgenerate

    // --- 3. 核心互连信号定义 ---
    wire [7:0] score;
    wire [1:0] error_cnt;
    wire [3:0] level;
    wire game_over;
    wire [11:0] rgb_pixel_data;
    wire rdn_signal;
    wire [8:0] row_addr;
    wire [9:0] col_addr;

    // --- 4. 模块实例化 ---

    // 游戏核心控制逻辑
    game_core u_game_core (
        .clk(clk),
        .BTN(btn_debounced),
        .LED(LED),
        .score(score),
        .error_cnt(error_cnt),
        .level(level),
        .game_over(game_over)
    );

    // 八段数码管动态扫描驱动
    seg_driver u_seg_driver (
        .clk(clk),
        .score(score),
        .error_cnt(error_cnt),
        .level(level),
        .game_over(game_over),
        .SEGMENT(SEGMENT),
        .AN(AN)
    );

    // VGA 画面像素发生器 (将核心输出的 LED[3:0] 直接作为当前目标提示块)
    vga_game_display u_vga_display (
        .x(col_addr),
        .y(row_addr),
        .read_en_n(rdn_signal),
        .target_led(LED[3:0]), 
        .score(score),
        .error_cnt(error_cnt),
        .level(level),
        .game_over(game_over),
        .rgb_real(rgb_pixel_data)
    );

    // VGA 物理行场时序驱动器
    VGA_Driver u_vga_driver (
        .vga_clk(vga_clk),
        .clrn(rstn),            // K7板载低有效复位直接连接
        .d_in(rgb_pixel_data),
        .row_addr(row_addr),
        .col_addr(col_addr),
        .rdn(rdn_signal),
        .r(r),
        .g(g),
        .b(b),
        .hs(hs),
        .vs(vs)
    );

endmodule
