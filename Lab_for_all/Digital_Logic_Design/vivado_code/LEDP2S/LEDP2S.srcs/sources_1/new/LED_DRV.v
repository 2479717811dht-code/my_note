`timescale 1ns / 1ps

module LED_DRV(
    input  wire        clk,      // 系统时钟
    input  wire [15:0] LED,      // 并行输入数据（高电平亮，但 LED 实际低电平亮）
    input  wire        start,    // 启动移位（一个时钟周期的高脉冲）
    output wire        LED_DO,   // 串行数据输出
    output wire        LED_CLK,  // 串行移位时钟
    output wire        LED_EN,   // 输出使能，高有效
    output wire        LED_CLR   // 清除信号，低有效
);

    wire finish;

    // 实例化移位寄存器，注意数据取反（因为 LED 低电平亮）
    ShiftReg16 u_shift (
        .clk    (clk),
        .S_L    (start),         // start=1 时装载，start=0 时左移
        .p_in   (~LED),          // 取反：板子要求 0 亮，所以 LED=1 时 p_in=0
        .finish (finish),
        .s_out  (LED_DO)
    );

    // 关键修正：门控时钟，只在移位期间输出时钟，完成后时钟为 0
    assign LED_CLK = clk & (~finish);

    // 使能常开，清零常无效（高电平）
    assign LED_EN  = 1'b1;
    assign LED_CLR = 1'b1;

endmodule
