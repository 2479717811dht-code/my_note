`timescale 1ns / 1ps

module Top(
    input clk,
    input [3:0] BTN,
    input [15:0] SW,
    output BTNX4,
    output [7:0] LED,
    output [7:0] SEGMENT,
    output [3:0] AN
);

wire Load_A, Co; // Load_A 是1位，不是4位！
wire [3:0] A, A_IN, A1;
wire [31:0] clk_div;
wire [15:0] num;

assign BTNX4 = 1'b0;
assign LED = {4'b0, A}; // 用LED同步显示A的值，方便调试

// 显示逻辑：和你原来一样，A、A1、A_IN 各4位
assign num = {A, A1, A_IN, 4'b0000};

// 寄存器模块（注意：端口名大小写要和你模块定义一致，这里用你图里的写法）
MyRegister4b RegA(
    .clk(clk),
    .in(A_IN),
    .load(Load_A),
    .out(A)
);

// 按键消抖模块，保持你原来的 BTN[3]
Load_Gen m0(
    .clk(clk),
    .clk_1ms(clk_div[17]), // 1ms时钟，和原设计一致
    .btn_in(BTN[3]),
    .Load_out(Load_A)
);

// 时钟分频模块（带复位，和原设计一致）
clkdiv m3(
    .clk(clk),
    .rst(1'b0),
    .clk_div(clk_div)
);

// 加减法器模块（和原设计一致）
AddSub4b m4(
    .A(A),
    .B(4'b0001),
    .Ctrl(SW[0]),
    .S(A1),
    .Co(Co)
);

// 输入选择逻辑（和你原代码一致，只修正语法格式）
assign A_IN = (SW[15] == 1'b0) ? A1 : 4'b0000;

// 数码管扫描：你原来写的是 clk_div[1:0]，这里改成正确的高位扫描时钟
DispNum m8(
    .scan(clk_div[18:17]), // 正确的数码管扫描时钟
    .HEXES(num),
    .LES(4'b0),
    .point(4'b0),
    .AN(AN),
    .SEGMENT(SEGMENT)
);

endmodule
