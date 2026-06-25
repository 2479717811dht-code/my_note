`timescale 1ns / 1ps

module game_core(
    input clk,
    input [3:0] BTN,
    output reg [7:0] LED,
    output reg [7:0] score,
    output reg [1:0] error_cnt,
    output reg [3:0] level,
    output reg game_over
);

    reg [7:0] lfsr = 8'hA5;
    reg [1:0] target_dir = 0;
    reg [3:0] btn_last = 0;
    reg [23:0] err_flash = 0;

    reg [3:0] history_addr = 0;
    reg [1:0] history_ram [0:15];
    reg [7:0] dir_rom [0:3];

    initial begin
        score = 0;
        error_cnt = 0;
        level = 1;
        game_over = 0;

        dir_rom[0] = 8'b0000_0001;
        dir_rom[1] = 8'b0000_0010;
        dir_rom[2] = 8'b0000_0100;
        dir_rom[3] = 8'b0000_1000;
    end

    wire [3:0] btn_posedge = BTN & ~btn_last;
    wire key_valid = |btn_posedge;
    reg [1:0] key_dir;

    always @(*) begin
        case(btn_posedge)
            4'b0001: key_dir = 2'd0;
            4'b0010: key_dir = 2'd1;
            4'b0100: key_dir = 2'd2;
            4'b1000: key_dir = 2'd3;
            default: key_dir = 2'd0;
        endcase
    end

    always @(posedge clk) begin
        btn_last <= BTN;

        lfsr <= { lfsr[6:0], lfsr[7]^lfsr[5]^lfsr[4]^lfsr[3] };

        if(!game_over && key_valid) begin
            if(key_dir == target_dir) begin
                score <= score + 1;
                history_ram[history_addr] <= key_dir;
                history_addr <= history_addr + 1;

                // 修复：改成精确的余数判定，防止连续触发升级Bug
                if(score % 5 == 4)
                    level <= level + 1;

                target_dir <= lfsr[1:0];
            end
            else begin
                err_flash <= 24'd10000000;
                if(error_cnt == 2)
                    game_over <= 1'b1;
                else
                    error_cnt <= error_cnt + 1;
            end
        end

        if(err_flash > 0)
            err_flash <= err_flash - 1;
    end

    always @(*) begin
        LED = 8'b0;
        if(game_over) begin
            LED = 8'b11111111;
        end
        else begin
            LED[3:0] = dir_rom[target_dir];
            LED[5:4] = error_cnt;
            if(err_flash > 0)
                LED[7] = 1'b1;
        end
    end

endmodule