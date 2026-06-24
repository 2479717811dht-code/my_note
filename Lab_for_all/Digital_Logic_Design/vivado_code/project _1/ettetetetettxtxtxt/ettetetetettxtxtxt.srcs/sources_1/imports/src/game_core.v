`timescale 1ns / 1ps

module game_core(
    input  wire clk,
    input  wire rst_n,
    input  wire [3:0] BTN,      // debounced, high-active button level

    output reg  [7:0] LED,      // internal high-active LED state
    output reg  [7:0] score,
    output reg  [1:0] error_cnt,
    output reg  [3:0] level,
    output reg  game_over
);

reg [7:0] lfsr;
reg [1:0] target_dir;
reg [3:0] btn_last;
reg [23:0] err_flash;

reg [3:0] history_addr;
reg [1:0] history_ram [0:15];

wire [3:0] btn_posedge = BTN & ~btn_last;

wire key_valid = (btn_posedge == 4'b0001) ||
                 (btn_posedge == 4'b0010) ||
                 (btn_posedge == 4'b0100) ||
                 (btn_posedge == 4'b1000);

reg [1:0] key_dir;

always @(*) begin
    case (btn_posedge)
        4'b0001: key_dir = 2'd0;
        4'b0010: key_dir = 2'd1;
        4'b0100: key_dir = 2'd2;
        4'b1000: key_dir = 2'd3;
        default: key_dir = 2'd0;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        lfsr         <= 8'hA5;
        target_dir   <= 2'd0;
        btn_last     <= 4'b0000;
        err_flash    <= 24'd0;
        history_addr <= 4'd0;
        score        <= 8'd0;
        error_cnt    <= 2'd0;
        level        <= 4'd1;
        game_over    <= 1'b0;
    end
    else begin
        btn_last <= BTN;

        lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3]};

        if (!game_over && key_valid) begin
            if (key_dir == target_dir) begin
                score <= score + 8'd1;
                history_ram[history_addr] <= key_dir;
                history_addr <= history_addr + 4'd1;

                if (((score + 8'd1) % 8'd5) == 8'd0 && level < 4'd9)
                    level <= level + 4'd1;

                target_dir <= lfsr[1:0];
            end
            else begin
                err_flash <= 24'd10000000;

                if (error_cnt >= 2'd2)
                    game_over <= 1'b1;
                else
                    error_cnt <= error_cnt + 2'd1;
            end
        end

        if (err_flash > 24'd0)
            err_flash <= err_flash - 24'd1;
    end
end

always @(*) begin
    LED = 8'b0000_0000;

    if (game_over) begin
        LED = 8'b1111_1111;
    end
    else begin
        case (target_dir)
            2'd0: LED[3:0] = 4'b0001;
            2'd1: LED[3:0] = 4'b0010;
            2'd2: LED[3:0] = 4'b0100;
            2'd3: LED[3:0] = 4'b1000;
            default: LED[3:0] = 4'b0001;
        endcase

        LED[5:4] = error_cnt;

        if (err_flash > 24'd0)
            LED[7] = 1'b1;
    end
end

endmodule
