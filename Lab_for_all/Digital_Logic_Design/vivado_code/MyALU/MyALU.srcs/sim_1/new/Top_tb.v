`timescale 1ns / 1ps
module Top_tb;

    reg clk;
    reg [15:0] SW;
    reg [3:0] BTN;

    wire [3:0] AN;
    wire [7:0] SEGMENT;
    wire BTNX4;

    // 注意：这里的模块名必须和你工程里的顶层模块名完全一致！
    Top uut(
        .clk(clk),
        .SW(SW),
        .BTN(BTN),
        .AN(AN),
        .SEGMENT(SEGMENT),
        .BTNX4(BTNX4)
    );

    // 100MHz 时钟（周期10ns）
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 严格按照目标波形时序赋值
    initial begin
        // 初始化
        SW = 16'h0000;
        BTN = 4'b0000;
        #10;

        // 0~100ns: SW=0000, BTN[3]在50~100ns为1
        #40;    // 50ns 时按下BTN3
        BTN[3] = 1;
        #50;    // 100ns 时松开
        BTN[3] = 0;

        // 100~200ns: SW=0001, BTN[2]在150~200ns为1
        SW = 16'h0001;
        #50;    // 150ns 时按下BTN2
        BTN[2] = 1;
        #50;    // 200ns 时松开
        BTN[2] = 0;

        // 200~300ns: SW=4001
        SW = 16'h4001;
        #100;

        // 300~400ns: SW=8001
        SW = 16'h8001;
        #100;

        $stop;
    end

endmodule