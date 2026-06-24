`timescale 1ns / 1ps


module DispNumber_sch(
    input  [15:0] SW,      // 16位开关输入
    output [ 7:0] SEGMENT, // 段选输出 (a~g, dp)
    output [ 3:0] AN       // 位选输出 (4个数码管)
);

    // 控制哪个数码管点亮（低电平有效）
    assign AN = ~SW[7:4];
    
    // 实例化你的译码器模块
    MyMC14495 u_mc14495(
        .D3    (SW[3]),
        .D2    (SW[2]),
        .D1    (SW[1]),
        .D0    (SW[0]),
        .point (SW[15]), // 小数点控制
        .LE    (SW[14]), // 锁存使能
        .a     (SEGMENT[0]),
        .b     (SEGMENT[1]),
        .c     (SEGMENT[2]),
        .d     (SEGMENT[3]),
        .e     (SEGMENT[4]),
        .f     (SEGMENT[5]),
        .g     (SEGMENT[6]),
        .p     (SEGMENT[7])
    );

endmodule
