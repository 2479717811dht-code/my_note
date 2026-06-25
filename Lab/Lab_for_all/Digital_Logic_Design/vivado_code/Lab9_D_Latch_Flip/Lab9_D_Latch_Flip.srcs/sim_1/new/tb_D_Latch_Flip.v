`timescale 1ns / 1ps
module tb_D_Latch_Flip;
    reg EN;
    reg C;
    wire Q;
    wire Q_bar;

    // 例化你的空翻测试电路
    D_Latch_Flip uut (
        .EN(EN),
        .C(C),
        .Q(Q),
        .Q_bar(Q_bar)
    );

    initial begin
        // 初始化
        EN = 0;
        C = 0;
        #50;

        // 打开时钟，但EN=0，不发生空翻
        C = 1;
        #50;

        // 关键：EN=1，C=1，开始空翻
        EN = 1;
        #200;  // 加长时间，让你看到多次翻转

        // 关闭EN，停止空翻
        EN = 0;
        #100;

        $stop;
    end
endmodule
