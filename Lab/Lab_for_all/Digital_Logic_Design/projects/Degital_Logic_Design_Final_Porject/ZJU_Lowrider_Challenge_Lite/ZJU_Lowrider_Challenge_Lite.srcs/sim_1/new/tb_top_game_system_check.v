`timescale 1ns / 1ps

module tb_top_game_system_final;

    // ============================================================
    // 100MHz 主时钟
    // K7.xdc: create_clock -period 10.0 [get_ports clk]
    // ============================================================
    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg rstn = 1'b0;
    reg [3:0] BTN = 4'b1111;
    reg ps2_clk = 1'b1;
    reg ps2_data = 1'b1;

    wire [7:0] LED;
    wire [7:0] SEGMENT;
    wire [3:0] AN;
    wire [3:0] r, g, b;
    wire hs, vs;

    top_game_system uut (
        .clk(clk),
        .rstn(rstn),
        .BTN(BTN),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .LED(LED),
        .SEGMENT(SEGMENT),
        .AN(AN),
        .r(r),
        .g(g),
        .b(b),
        .hs(hs),
        .vs(vs)
    );

    // ============================================================
    // 计数变量
    // ============================================================
    integer i;

    integer active_cnt;
    integer rgb_nonblack_cnt;
    integer rgb_x_cnt;

    integer hs_low_cnt;
    integer vs_low_cnt;

    integer menu_on_cnt;
    integer menu_nonblack_cnt;

    integer text_on_cnt;
    integer text_nonblack_cnt;

    integer h_min, h_max;
    integer v_min, v_max;

    // ============================================================
    // 复位任务
    // ============================================================
    task do_reset;
        begin
            $display("\n========== RESET ==========");
            rstn = 1'b0;
            BTN = 4'b1111;
            ps2_clk = 1'b1;
            ps2_data = 1'b1;

            repeat (50) @(posedge clk);
            rstn = 1'b1;
            repeat (50) @(posedge clk);

            // 不等真实 debounce，防止仿真早期 btn_debounced 是 X
            force uut.btn_debounced = 4'b1111;
            repeat (10) @(posedge clk);

            $display("[INFO] reset released");
        end
    endtask

    // ============================================================
    // 模拟 Space 开始游戏
    // 不完整仿真 PS2，只直接 force keyboard_space
    // ============================================================
    task press_space_once;
        begin
            $display("\n========== PRESS SPACE ==========");
            force uut.keyboard_space = 1'b1;
            repeat (5) @(posedge clk);
            release uut.keyboard_space;
            repeat (20) @(posedge clk);
        end
    endtask

    // ============================================================
    // 等待进入有效显示区
    // rdn_signal = 0 表示有效显示区
    // ============================================================
    task wait_active_video;
        integer k;
        begin
            k = 0;
            while (uut.rdn_signal !== 1'b0 && k < 800*100) begin
                @(posedge uut.vga_clk);
                k = k + 1;
            end

            if (uut.rdn_signal === 1'b0) begin
                $display("[PASS] Enter active video area.");
                $display("       h_count=%0d, v_count=%0d, col=%0d, row=%0d",
                         uut.u_vga_driver.h_count,
                         uut.u_vga_driver.v_count,
                         uut.col_addr,
                         uut.row_addr);
            end else begin
                $display("[FAIL] Did not enter active video area.");
            end
        end
    endtask

    // ============================================================
    // 采样一帧 VGA 基础时序
    // 一帧 = 800 * 525 个 vga_clk
    // ============================================================
    task sample_one_vga_frame;
        begin
            $display("\n========== VGA TIMING SAMPLE ==========");

            active_cnt = 0;
            rgb_nonblack_cnt = 0;
            rgb_x_cnt = 0;
            hs_low_cnt = 0;
            vs_low_cnt = 0;

            h_min = 999999;
            h_max = -1;
            v_min = 999999;
            v_max = -1;

            repeat (800 * 525) begin
                @(posedge uut.vga_clk);

                if (uut.u_vga_driver.h_count < h_min)
                    h_min = uut.u_vga_driver.h_count;
                if (uut.u_vga_driver.h_count > h_max)
                    h_max = uut.u_vga_driver.h_count;

                if (uut.u_vga_driver.v_count < v_min)
                    v_min = uut.u_vga_driver.v_count;
                if (uut.u_vga_driver.v_count > v_max)
                    v_max = uut.u_vga_driver.v_count;

                if (hs === 1'b0)
                    hs_low_cnt = hs_low_cnt + 1;

                if (vs === 1'b0)
                    vs_low_cnt = vs_low_cnt + 1;

                if (uut.rdn_signal === 1'b0) begin
                    active_cnt = active_cnt + 1;

                    if ((^{r, g, b}) === 1'bx)
                        rgb_x_cnt = rgb_x_cnt + 1;

                    if ({r, g, b} !== 12'h000 && (^{r, g, b}) !== 1'bx)
                        rgb_nonblack_cnt = rgb_nonblack_cnt + 1;
                end
            end

            $display("h_count range = %0d ~ %0d", h_min, h_max);
            $display("v_count range = %0d ~ %0d", v_min, v_max);
            $display("active pixels sampled = %0d", active_cnt);
            $display("non-black RGB pixels = %0d", rgb_nonblack_cnt);
            $display("RGB X pixels = %0d", rgb_x_cnt);
            $display("hs low count = %0d", hs_low_cnt);
            $display("vs low count = %0d", vs_low_cnt);

            if (h_min == 0 && h_max == 799)
                $display("[PASS] h_count is 0~799.");
            else
                $display("[WARN] h_count range is not 0~799.");

            if (v_min == 0 && v_max == 524)
                $display("[PASS] v_count is 0~524.");
            else
                $display("[WARN] v_count range is not 0~524.");

            if (active_cnt > 0)
                $display("[PASS] rdn_signal has active-low display window.");
            else
                $display("[FAIL] no active display window sampled.");

            if (hs_low_cnt > 0)
                $display("[PASS] hs has low-active sync pulses.");
            else
                $display("[WARN] hs low pulse not observed.");

            if (vs_low_cnt > 0)
                $display("[PASS] vs has low-active sync pulse.");
            else
                $display("[WARN] vs low pulse not observed. Run longer or zoom out.");

            if (rgb_x_cnt == 0)
                $display("[PASS] RGB output has no X in active area.");
            else
                $display("[FAIL] RGB output has X in active area.");

            if (rgb_nonblack_cnt > 0)
                $display("[PASS] RGB has non-black pixels in active area.");
            else
                $display("[WARN] active area is all black.");
        end
    endtask

    // ============================================================
    // 采样菜单文字
    // game_state = 00 时，menu_on 应该有效
    // ============================================================
    task sample_menu_display;
        begin
            $display("\n========== MENU DISPLAY SAMPLE ==========");

            menu_on_cnt = 0;
            menu_nonblack_cnt = 0;

            repeat (800 * 525) begin
                @(posedge uut.vga_clk);

                if (uut.u_vga_display.menu_on === 1'b1) begin
                    menu_on_cnt = menu_on_cnt + 1;

                    if (uut.u_vga_display.menu_rgb_out !== 12'h000 &&
                        (^uut.u_vga_display.menu_rgb_out) !== 1'bx) begin
                        menu_nonblack_cnt = menu_nonblack_cnt + 1;
                    end
                end
            end

            $display("game_state = %b", uut.u_game_core.game_state);
            $display("menu_on pixels = %0d", menu_on_cnt);
            $display("menu non-black pixels = %0d", menu_nonblack_cnt);

            if (uut.u_game_core.game_state == 2'b00)
                $display("[PASS] game_state is STATE_MENU.");
            else
                $display("[WARN] game_state is not STATE_MENU.");

            if (menu_on_cnt > 0)
                $display("[PASS] menu_on appears in menu region.");
            else
                $display("[FAIL] menu_on never appears.");

            if (menu_nonblack_cnt > 0)
                $display("[PASS] menu_rom outputs visible text pixels.");
            else
                $display("[FAIL] menu_rom output seems black. Check menu_data.mem.");
        end
    endtask

    // ============================================================
    // 采样游戏状态下菜单是否消失
    // ============================================================
    task sample_play_display;
        begin
            $display("\n========== PLAY DISPLAY SAMPLE ==========");

            menu_on_cnt = 0;

            repeat (800 * 100) begin
                @(posedge uut.vga_clk);

                if (uut.u_vga_display.menu_on === 1'b1)
                    menu_on_cnt = menu_on_cnt + 1;
            end

            $display("game_state = %b", uut.u_game_core.game_state);
            $display("menu_on pixels after start = %0d", menu_on_cnt);

            if (uut.u_game_core.game_state == 2'b01)
                $display("[PASS] game_state is STATE_PLAY.");
            else
                $display("[WARN] game_state is not STATE_PLAY.");

            if (menu_on_cnt == 0)
                $display("[PASS] menu text disappears after game starts.");
            else
                $display("[FAIL] menu_on still appears after game starts.");
        end
    endtask

    // ============================================================
    // 强制结算状态，检查胜利/失败文字
    // state = 2'b11 胜利
    // state = 2'b10 失败
    // ============================================================
    task sample_result_text;
        input [1:0] state;
        begin
            $display("\n========== RESULT TEXT SAMPLE state=%b ==========", state);

            force uut.u_game_core.game_state = state;
            repeat (100) @(posedge clk);

            text_on_cnt = 0;
            text_nonblack_cnt = 0;

            repeat (800 * 525) begin
                @(posedge uut.vga_clk);

                if (uut.u_vga_display.text_on === 1'b1) begin
                    text_on_cnt = text_on_cnt + 1;

                    if (uut.u_vga_display.text_rgb_out !== 12'h000 &&
                        (^uut.u_vga_display.text_rgb_out) !== 1'bx) begin
                        text_nonblack_cnt = text_nonblack_cnt + 1;
                    end
                end
            end

            $display("forced game_state = %b", state);
            $display("text_on pixels = %0d", text_on_cnt);
            $display("text non-black pixels = %0d", text_nonblack_cnt);

            if (text_on_cnt > 0)
                $display("[PASS] text_on appears in result text region.");
            else
                $display("[FAIL] text_on never appears.");

            if (text_nonblack_cnt > 0)
                $display("[PASS] text_rom outputs visible result text pixels.");
            else
                $display("[FAIL] text_rom output seems black. Check text_data.mem.");

            release uut.u_game_core.game_state;
            repeat (100) @(posedge clk);
        end
    endtask

    // ============================================================
    // 主流程
    // ============================================================
    initial begin
        $timeformat(-6, 3, " us", 10);

        $display("=================================================");
        $display(" tb_top_game_system_final start");
        $display("=================================================");

        do_reset();

        // 1. VGA 时序检查
        wait_active_video();
        sample_one_vga_frame();

        // 2. 菜单显示检查
        sample_menu_display();

        // 3. Space 后进入游戏，菜单消失
        press_space_once();
        sample_play_display();

        // 4. 强制胜利 / 失败，检查结算文字
        sample_result_text(2'b11);   // STATE_WIN
        sample_result_text(2'b10);   // STATE_FAIL

        $display("\n=================================================");
        $display(" tb_top_game_system_final finish");
        $display("=================================================");

        $finish;
    end

endmodule


