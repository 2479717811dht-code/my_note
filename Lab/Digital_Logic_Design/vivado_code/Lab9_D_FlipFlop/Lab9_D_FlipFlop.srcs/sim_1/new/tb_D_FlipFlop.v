`timescale 1ns / 1ps
module tb_D_FlipFlop;

    // 输入信号
    reg D;
    reg C_p;
    reg S_bar;
    reg R_bar;

    // 输出信号
    wire Q;
    wire Q_bar;

    // 例化触发器
    D_FlipFlop uut (
        .D(D),
        .C_p(C_p),
        .S_bar(S_bar),
        .R_bar(R_bar),
        .Q(Q),
        .Q_bar(Q_bar)
    );

    // 时钟：01010101... 持续翻转
    always #50 C_p = ~C_p;

    initial begin
        // === 初始化：全部长时间保持 1，D=高阻态 ===
        C_p = 0;
        D = 0;    // D 一开始高阻
        S_bar = 1;
        R_bar = 1;
        #300;        // 长时间保持稳定

        // === 第一步：R_bar 短暂变0，再变回1 ===
        R_bar = 0;
        #100;
        R_bar = 1;
        #100;

        // === 第二步：S_bar 变 0（你要求的顺序）===
        S_bar = 0;
        #200;
        S_bar = 1;
        #200;

        // === 后续正常测试 ===
        D = 1;
        #200;
        D = 0;
        #200;

        $stop;
    end

endmodule