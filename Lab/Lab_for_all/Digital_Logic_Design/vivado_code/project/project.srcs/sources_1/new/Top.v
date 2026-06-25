module Top(
    input clk,
    input [3:0] BTN,

    output [7:0] LED,

    output [7:0] SEGMENT,
    output [3:0] AN
);

wire [3:0] BTN_DB;

wire [7:0] score;
wire [1:0] error_cnt;
wire [3:0] level;
wire game_over;

debounce D0(
    .clk(clk),
    .key_in(BTN[0]),
    .key_out(BTN_DB[0])
);

debounce D1(
    .clk(clk),
    .key_in(BTN[1]),
    .key_out(BTN_DB[1])
);

debounce D2(
    .clk(clk),
    .key_in(BTN[2]),
    .key_out(BTN_DB[2])
);

debounce D3(
    .clk(clk),
    .key_in(BTN[3]),
    .key_out(BTN_DB[3])
);

game_core U_GAME(
    .clk(clk),
    .BTN(BTN_DB),

    .LED(LED),

    .score(score),
    .error_cnt(error_cnt),
    .level(level),
    .game_over(game_over)
);

seg_driver U_SEG(
    .clk(clk),

    .score(score),
    .error_cnt(error_cnt),
    .level(level),
    .game_over(game_over),

    .SEGMENT(SEGMENT),
    .AN(AN)
);

endmodule