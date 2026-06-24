`timescale 1ns / 1ps

module Top(
    input  wire        clk,
    input  wire [3:0]  BTN,
    input  wire [15:0] SW,
    output wire        BTNX4,
    output wire [7:0]  SEGMENT,
    output wire [3:0]  AN,
    output wire        LED_DO,   // 串行数据输出
    output wire        LED_CLK,  // 串行移位时钟
    output wire        LED_EN,   // 输出使能，高有效
    output wire        LED_CLR   // 清除信号，低有效
);

    // 时钟分频，用于 1ms 刷新和数码管扫描
    wire [31:0] clk_div;

    // 4 个 4-bit 计数器输出合并成 16 位
    wire [15:0] num;
    // 来自 4 个 Load_Gen 的并行装载使能
    wire [3:0] Load;

    // 给未用的按键脚输出 0
    assign BTNX4 = 1'b0;

    // 四个 4-bit 计数器
    Counter_4b m1(.SubMode(SW[0]), .En(Load[0]), .clk(clk), .num(num[3:0]));
    Counter_4b m2(.SubMode(SW[1]), .En(Load[1]), .clk(clk), .num(num[7:4]));
    Counter_4b m3(.SubMode(SW[2]), .En(Load[2]), .clk(clk), .num(num[11:8]));
    Counter_4b m4(.SubMode(SW[3]), .En(Load[3]), .clk(clk), .num(num[15:12]));

    // 四路消抖／按键产生 Load 信号
    Load_Gen m5(.clk(clk), .clk_1ms(clk_div[17]), .btn_in(BTN[3]), .Load_out(Load[3]));
    Load_Gen m6(.clk(clk), .clk_1ms(clk_div[17]), .btn_in(BTN[2]), .Load_out(Load[2]));
    Load_Gen m7(.clk(clk), .clk_1ms(clk_div[17]), .btn_in(BTN[1]), .Load_out(Load[1]));
    Load_Gen m8(.clk(clk), .clk_1ms(clk_div[17]), .btn_in(BTN[0]), .Load_out(Load[0]));

    // 时钟分频模块
    clkdiv m9(.clk(clk), .rst(1'b0), .clk_div(clk_div));

    // 数码管驱动
    DispNum m10(
        .scan   (clk_div[18:17]),
        .HEXES  (num),
        .LES    (4'b0),
        .point  (4'b0),
        .AN     (AN),
        .SEGMENT(SEGMENT)
    );

    // SW[15] 控制并行装载数据 
    wire start_led;
    Load_Gen m66(.clk(clk), .clk_1ms(clk_div[17]), .btn_in(SW[15]), .Load_out(start_led));
    // 串行 LED 驱动
    LED_DRV u_led (
        .clk     (clk),         // 串行时钟，同系统时钟
        .LED     (num),         // 要输出的 16 位并行数据
        .start   (start_led),   // 并行装载启动
        .LED_DO  (LED_DO),      // 串行数据输出
        .LED_CLK (LED_CLK),     // 串行时钟输出
        .LED_EN  (LED_EN),      // 输出使能，高有效
        .LED_CLR (LED_CLR)      // 清除信号，高有效
    );

endmodule