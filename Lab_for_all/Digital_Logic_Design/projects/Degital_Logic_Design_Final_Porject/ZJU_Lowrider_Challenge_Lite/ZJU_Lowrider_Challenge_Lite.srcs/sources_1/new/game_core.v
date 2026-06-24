`timescale 1ns / 1ps

module game_core(
    input clk,                  // 50MHz 主时钟
    input reset,                // 高电平复位信号
    
    // 键盘 WASD 输入以及开始按键
    input key_w, 
    input key_a, 
    input key_s, 
    input key_d,
    input btn_start,            
    
    // 游戏状态总线
    output reg [1:0] game_state, 
    output reg [7:0] score,
    output reg [1:0] error_cnt,
    output reg [3:0] level,
    
    // 4 颗同屏音符的物理状态总线
    output reg [9:0] note0_x, output reg [1:0] note0_type, output reg note0_active,
    output reg [9:0] note1_x, output reg [1:0] note1_type, output reg note1_active,
    output reg [9:0] note2_x, output reg [1:0] note2_type, output reg note2_active,
    output reg [9:0] note3_x, output reg [1:0] note3_type, output reg note3_active,
    
    // 中央可控小贴图的 X, Y 实时坐标输出
    output reg [9:0] avatar_x,
    output reg [8:0] avatar_y
);

    // 定义中心点常量（基于640x480屏幕，16x16贴图居中）
    localparam [9:0] AVATAR_CENTER_X = 10'd312;
    localparam [8:0] AVATAR_CENTER_Y = 9'd232;
    
    // 定义瞬间弹跳的偏移量（单位：像素）
    localparam [9:0] AVATAR_OFFSET_X = 10'd60; 
    localparam [8:0] AVATAR_OFFSET_Y = 9'd60;

    // 1. 硬件级：按键边沿单脉冲提取器（供音轨判定使用）
    reg w_r1, w_r2; reg a_r1, a_r2; reg s_r1, s_r2; reg d_r1, d_r2;
    always @(posedge clk) begin
        w_r1 <= key_w; w_r2 <= w_r1;
        a_r1 <= key_a; a_r2 <= a_r1;
        s_r1 <= key_s; s_r2 <= s_r1;
        d_r1 <= key_d; d_r2 <= d_r1;
    end
    wire pulse_w = w_r1 && !w_r2; 
    wire pulse_a = a_r1 && !a_r2;
    wire pulse_s = s_r1 && !s_r2; 
    wire pulse_d = d_r1 && !d_r2;
    wire any_key_pulse = pulse_w || pulse_a || pulse_s || pulse_d;

    // =========================================================================
    // 【核心改动】基于按键即时状态的"弹簧式"位置判定逻辑
    // =========================================================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            avatar_x <= AVATAR_CENTER_X;
            avatar_y <= AVATAR_CENTER_Y;
        end else begin
            if (game_state == 2'b01) begin // 仅在游戏进行中响应弹跳
                
                // --- X轴控制逻辑 (A向左移，D向右移，不按或同时按则立刻归中) ---
                if (key_a && !key_d) begin
                    avatar_x <= AVATAR_CENTER_X - AVATAR_OFFSET_X;
                end else if (key_d && !key_a) begin
                    avatar_x <= AVATAR_CENTER_X + AVATAR_OFFSET_X;
                end else begin
                    avatar_x <= AVATAR_CENTER_X; // 键盘松开，瞬间回到原位
                end

                // --- Y轴控制逻辑 (W向上移，S向下移，不按或同时按则立刻归中) ---
                if (key_w && !key_s) begin
                    avatar_y <= AVATAR_CENTER_Y - AVATAR_OFFSET_Y;
                end else if (key_s && !key_w) begin
                    avatar_y <= AVATAR_CENTER_Y + AVATAR_OFFSET_Y;
                end else begin
                    avatar_y <= AVATAR_CENTER_Y; // 键盘松开，瞬间回到原位
                end

            end else begin
                // 非游戏进行状态（如菜单或结算界面），强制死死锁定在屏幕正中央
                avatar_x <= AVATAR_CENTER_X;
                avatar_y <= AVATAR_CENTER_Y;
            end
        end
    end
    // =========================================================================

    // 2. 队列指针与发射间距计数器
    reg [1:0] head_ptr;       
    reg [1:0] tail_ptr;       
    reg [7:0] pixel_count;    

    // 2-Bit 硬件伪随机数发生器
    reg [1:0] rand_counter;
    always @(posedge clk) rand_counter <= rand_counter + 1'b1;

    // 3. 速度节拍发生器（根据 Level 调节音符移动帧率）
    reg [23:0] speed_counter;
    reg [23:0] speed_target;
    always @(*) begin
        case(level)
            4'd1:    speed_target = 24'd600_000; // 100MHz下约6ms移动1像素，约3.5秒从右到判定区
            4'd2:    speed_target = 24'd450_000; // 约4.5ms/像素
            4'd3:    speed_target = 24'd320_000; // 约3.2ms/像素
            default: speed_target = 24'd250_000;  
        endcase
    end
    wire move_tick = (speed_counter >= speed_target);
    always @(posedge clk or posedge reset) begin
        if (reset) speed_counter <= 0;
        else if (game_state == 2'b01) begin
            if (move_tick) speed_counter <= 0;
            else speed_counter <= speed_counter + 1'b1;
        end
    end

    // 4. 动态多目标数据多路复用解调
    reg [9:0] target_x;
    reg [1:0] target_type;
    reg target_active;
    always @(*) begin
        case(head_ptr)
            2'b00: begin target_x = note0_x; target_type = note0_type; target_active = note0_active; end
            2'b01: begin target_x = note1_x; target_type = note1_type; target_active = note1_active; end
            2'b10: begin target_x = note2_x; target_type = note2_type; target_active = note2_active; end
            2'b11: begin target_x = note3_x; target_type = note3_type; target_active = note3_active; end
        endcase
    end

    wire key_match = (target_type == 2'b00 && pulse_w) ||
                     (target_type == 2'b01 && pulse_s) ||
                     (target_type == 2'b10 && pulse_a) ||
                     (target_type == 2'b11 && pulse_d);
                     
    wire perfect_range = (target_x >= 10'd60) && (target_x <= 10'd78);

    // 5. 主状态机逻辑
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            game_state   <= 2'b00; score <= 8'd0; error_cnt <= 2'd0; level <= 4'd1;
            head_ptr     <= 2'b00; tail_ptr <= 2'b00; pixel_count <= 8'd180; 
            note0_active <= 0; note1_active <= 0; note2_active <= 0; note3_active <= 0;
            note0_x <= 0; note1_x <= 0; note2_x <= 0; note3_x <= 0;
            note0_type <= 0; note1_type <= 0; note2_type <= 0; note3_type <= 0;
        end 
        else begin
            case (game_state)
                2'b00: begin 
                    score <= 8'd0; error_cnt <= 2'd0; level <= 4'd1;
                    head_ptr <= 2'b00; tail_ptr <= 2'b00; pixel_count <= 8'd180; 
                    note0_active <= 0; note1_active <= 0; note2_active <= 0; note3_active <= 0;
                    if (btn_start) game_state <= 2'b01;
                end

                2'b01: begin 
                    if (error_cnt >= 2'd3) game_state <= 2'b10;
                    else if (score >= 8'd20) game_state <= 2'b11;

                    if (score >= 8'd5  && score < 8'd12) level <= 4'd2;
                    if (score >= 8'd12 && score < 8'd20) level <= 4'd3;

                    if (move_tick) begin
                        if (note0_active) note0_x <= note0_x - 1'b1;
                        if (note1_active) note1_x <= note1_x - 1'b1;
                        if (note2_active) note2_x <= note2_x - 1'b1;
                        if (note3_active) note3_x <= note3_x - 1'b1;

                        if (pixel_count >= 8'd180) begin 
                            pixel_count <= 8'd0;
                            case(tail_ptr)
                                2'b00: begin note0_x <= 10'd639; note0_type <= rand_counter; note0_active <= 1'b1; end
                                2'b01: begin note1_x <= 10'd639; note1_type <= rand_counter; note1_active <= 1'b1; end
                                2'b10: begin note2_x <= 10'd639; note2_type <= rand_counter; note2_active <= 1'b1; end 
                                2'b11: begin note3_x <= 10'd639; note3_type <= rand_counter; note3_active <= 1'b1; end
                            endcase
                            tail_ptr <= tail_ptr + 1'b1;
                        end else begin
                            pixel_count <= pixel_count + 1'b1;
                        end
                    end

                    if (target_active && (target_x < 10'd60)) begin
                        error_cnt <= error_cnt + 1'b1;
                        case(head_ptr) 
                            2'b00: note0_active <= 1'b0; 2'b01: note1_active <= 1'b0;
                            2'b10: note2_active <= 1'b0; 2'b11: note3_active <= 1'b0;
                        endcase
                        head_ptr <= head_ptr + 1'b1;
                    end
                    else if (any_key_pulse && target_active) begin
                        if (key_match && perfect_range) begin
                            score <= score + 1'b1; 
                        end else begin
                            error_cnt <= error_cnt + 1'b1; 
                        end
                        case(head_ptr) 
                            2'b00: note0_active <= 1'b0; 2'b01: note1_active <= 1'b0;
                            2'b10: note2_active <= 1'b0; 2'b11: note3_active <= 1'b0;
                        endcase
                        head_ptr <= head_ptr + 1'b1;
                    end
                end

                2'b10, 2'b11: begin 
                    if (btn_start) game_state <= 2'b00;
                end
            endcase
        end
    end
endmodule