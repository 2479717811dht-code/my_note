`timescale 1ns / 1ps

module top_game_system(
    input clk,                  // FPGA物理主时钟引脚
    input rstn,                 // 物理复位拨码开关（低电平复位）
    input [3:0] BTN,            // 板载物理轻触按键
    
    // PS2 键盘物理线
    input ps2_clk,              
    input ps2_data,             
    
    output [7:0] LED,           // 板载指示灯
    output [7:0] SEGMENT,       // 数码管段选管脚
    output [3:0] AN,            // 数码管位选管脚
    
    // VGA 12位色彩及同步管脚
    output [3:0] r,             
    output [3:0] g,             
    output [3:0] b,             
    output hs,                  
    output vs                   
);

    // 1. VGA 时钟硬件 2 分频发生器 (50M -> 25MHz)
    reg [1:0] clk_div = 2'b00;
    always @(posedge clk) clk_div <= clk_div + 1;
    wire vga_clk = clk_div[1]; 

    // 2. 4路物理按键硬件级消抖电路例化组
    wire [3:0] btn_debounced;
    genvar i;
    generate
        for(i = 0; i < 4; i = i + 1) begin: debounce_block
            debounce u_debounce (.clk(clk), .key_in(BTN[i]), .key_out(btn_debounced[i]));
        end
    endgenerate

    // 3. PS2 键盘标准解码驱动核心例化
    wire [3:0] keyboard_wasd; 
    wire keyboard_space;
    ps2_keyboard u_ps2_keyboard (
        .clk(clk), 
        .rstn(rstn), 
        .ps2_clk(ps2_clk), 
        .ps2_data(ps2_data),
        .key_wasd(keyboard_wasd), 
        .key_space(keyboard_space)
    );

    // 4. 双控并联通路组合
    wire [3:0] combined_ctrl_status = (~btn_debounced) | keyboard_wasd;

    // 5. 内部高速互连专用总线声明
    wire [1:0] game_state; 
    wire [7:0] score; 
    wire [1:0] error_cnt; 
    wire [3:0] level;
    wire game_over = (game_state == 2'b10);
    
    wire rdn_signal; 
    wire [8:0] row_addr; 
    wire [9:0] col_addr; 
    wire [11:0] rgb_pixel_data;

    // 4路流水线专用网络线
    wire [9:0] n0_x, n1_x, n2_x, n3_x;
    wire [1:0] n0_t, n1_t, n2_t, n3_t;
    wire n0_a, n1_a, n2_a, n3_a;

    // 【新增】顶层骨架贴图坐标传输互连总线
    wire [9:0] av_x;
    wire [8:0] av_y;

    // 6. 核心游戏控制逻辑中央处理器例化
    game_core u_game_core (
        .clk(clk), 
        .reset(~rstn), 
        .key_w(combined_ctrl_status[2]), 
        .key_a(combined_ctrl_status[0]),
        .key_s(combined_ctrl_status[1]), 
        .key_d(combined_ctrl_status[3]),
        .btn_start(keyboard_space),
        .game_state(game_state), 
        .score(score), 
        .error_cnt(error_cnt), 
        .level(level),
        
        .note0_x(n0_x), .note0_type(n0_t), .note0_active(n0_a),
        .note1_x(n1_x), .note1_type(n1_t), .note1_active(n1_a),
        .note2_x(n2_x), .note2_type(n2_t), .note2_active(n2_a),
        .note3_x(n3_x), .note3_type(n3_t), .note3_active(n3_a),
        
        // 连出坐标线
        .avatar_x(av_x),
        .avatar_y(av_y)
    );

    assign LED = {level, game_state, error_cnt};

    // 7. 物理数码管动态扫描驱动模块例化
    seg_driver u_seg_driver (
        .clk(clk), 
        .score(score), 
        .error_cnt(error_cnt), 
        .level(level),
        .game_over(game_over), 
        .SEGMENT(SEGMENT), 
        .AN(AN)
    );

    // 8. 终极流式高速 VGA 渲染图层叠加引擎例化
    vga_game_display u_vga_display (
        .vga_clk(vga_clk),
        .x(col_addr), 
        .y(row_addr), 
        .read_en_n(rdn_signal),
        .game_state(game_state), 
        .score(score), 
        .error_cnt(error_cnt), 
        .level(level),
        
        .note0_x(n0_x), .note0_type(n0_t), .note0_active(n0_a),
        .note1_x(n1_x), .note1_type(n1_t), .note1_active(n1_a),
        .note2_x(n2_x), .note2_type(n2_t), .note2_active(n2_a),
        .note3_x(n3_x), .note3_type(n3_t), .note3_active(n3_a),
        
        // 连入坐标线
        .avatar_x(av_x),
        .avatar_y(av_y),
        
        .rgb_real(rgb_pixel_data)
    );

    // 9. 底层 VGA 时序同步发生驱动器例化
    VGA_Driver u_vga_driver (
        .vga_clk(vga_clk), 
        .clrn(rstn), 
        .d_in(rgb_pixel_data),
        .row_addr(row_addr), 
        .col_addr(col_addr), 
        .rdn(rdn_signal),
        .r(r), .g(g), .b(b), 
        .hs(hs), .vs(vs)
    );

endmodule