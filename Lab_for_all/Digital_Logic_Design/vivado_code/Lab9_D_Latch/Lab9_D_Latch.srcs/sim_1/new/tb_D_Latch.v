`timescale 1ns / 1ps
module tb_D_Latch;
    reg C;
    reg S;   
    wire Q;
    wire Q_bar;

    // 例化（完全匹配你导出的代码）
    D_Latch uut (
        .C(C),
        .S(S),   // 用 S 不用 D
        .Q(Q),
        .Q_bar(Q_bar)
    );

    initial begin
        C = 1; S = 1; #50;
        C = 1; S = 0; #50;
        C = 0; S = 1; #50;
        C = 0; S = 0; #50;

        $stop;
    end

endmodule