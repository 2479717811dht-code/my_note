`timescale 1ns / 1ps

module game_core_tb;

reg clk;
reg [3:0] BTN;

wire [7:0] LED;
wire [7:0] score;
wire [1:0] error_cnt;
wire [3:0] level;
wire game_over;

game_core uut(
    .clk(clk),
    .BTN(BTN),
    .LED(LED),
    .score(score),
    .error_cnt(error_cnt),
    .level(level),
    .game_over(game_over)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;   // 100MHz
end

initial begin
    BTN = 4'b0000;

    #100;

    // 测试1：正确输入
    // 初始 target_dir = 0，按 BTN[0] 正确，score 应加 1
    uut.target_dir = 2'd0;
    press_btn(4'b0001);

    #300;

    // 测试2：连续三次错误输入
    // 每次都强制 target_dir = 0，然后按 BTN[1]，保证一定错误
    uut.target_dir = 2'd0;
    press_btn(4'b0010);

    #300;

    uut.target_dir = 2'd0;
    press_btn(4'b0010);

    #300;

    uut.target_dir = 2'd0;
    press_btn(4'b0010);

    #5000;

    $stop;
end

task press_btn;
    input [3:0] key;
    begin
        BTN = key;
        #50;
        BTN = 4'b0000;
        #100;
    end
endtask

endmodule
