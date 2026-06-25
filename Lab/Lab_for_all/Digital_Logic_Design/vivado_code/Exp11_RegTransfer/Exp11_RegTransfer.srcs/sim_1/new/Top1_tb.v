`timescale 1ns / 1ps

module Top1_tb();
    reg clk = 0;
    always begin
        #10 clk = ~clk;
    end

    reg btn3, sw15, sw0;
    wire [3:0] BTN;
    wire [15:0] SW;

    assign BTN[3] = btn3;
    assign SW[0]  = sw0;
    assign SW[15] = sw15;

    wire BTNX4;
    wire [7:0] LED;
    wire [7:0] SEGMENT;
    wire [3:0] AN;

    Top1 uut(
        .clk(clk),
        .BTN(BTN),
        .SW(SW),
        .BTNX4(BTNX4),
        .LED(LED),
        .SEGMENT(SEGMENT),
        .AN(AN)
    );

    initial begin
        btn3 = 0; sw0 = 0; sw15 = 1; // 初始状态：SW15=1，清零模式
        #20 btn3 = 1;
        #20 btn3 = 0; // 按一次按键，清零

        #20 sw15 = 0; sw0 = 0; // 进入加计数模式
        #20 btn3 = 1;
        #20 btn3 = 0; // 按一次 +1
        #20 btn3 = 1;
        #20 btn3 = 0; // 再按一次 +1

        #20 sw0 = 1; // 切换到减计数模式
        #20 btn3 = 1;
        #20 btn3 = 0; // 按一次 -1
        #20 btn3 = 1;
        #20 btn3 = 0; // 再按一次 -1
        #20 btn3 = 1;
        #20 btn3 = 0; // 再按一次 -1

        #300 $finish;
    end
endmodule
