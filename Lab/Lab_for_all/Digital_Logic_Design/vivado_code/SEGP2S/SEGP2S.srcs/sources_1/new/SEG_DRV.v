`timescale 1ns / 1ps

module SEG_DRV(
    input  wire        clk,      // 系统时钟（移位时钟）
    input  wire [63:0] SEG,      // 并行输入数据
    input  wire        start,    // 并行装载启动信号，高有效
    output wire        SEGDT,   // 串行数据输出
    output wire        SEGCLK,  // 串行移位时钟
    output wire        SEGEN,   // 输出使能，高有效
    output wire        SEGCLR   // 清除信号，低有效
);

    wire finish;
    // 实例化 16 位并行装载／串行移出移位寄存器
    ShiftReg64 u_shift (
        .clk    (clk),       // 上升沿移位或装载
        .S_L    (start),     // start=1 并行装载，start=0 左移
        .p_in   (SEG),       // 并行数据
        .finish (finish),    // 低 16 位全 1 时置 1
        .s_out  (SEGDT)     // 串行输出（最高位）
    );

    // 直接用系统时钟作为移位时钟输出
    assign SEGCLK = clk | finish;
    // 使能外部 LED 驱动
    assign SEGEN  = 1;
    // 清除信号，低有效
    assign SEGCLR = 1;

endmodule