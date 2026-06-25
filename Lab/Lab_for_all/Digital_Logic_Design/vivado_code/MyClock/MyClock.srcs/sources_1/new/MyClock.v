`timescale 1ns / 1ps

module top(
    input wire clk,
    input wire [15:0] SW,
    output wire SEGCLK,
    output wire SEGCLR,
    output wire SEGDT,
    output wire SEGEN
    );
    wire [31:0] num;
    wire [31:0] clk_div;
    clkdiv c0(.clk(clk),.rst(0),.clk_div(clk_div));
    ClockNumber n0(.clk(clk_div[25]),.SW(SW[15]),.Q(num));
    wire [63:0] seg;
    MyMC14495 m0(.D(num[3:0]),.point(0),.LE(0),.SEG(seg[7:0])),
              m1(.D(num[7:4]),.point(0),.LE(0),.SEG(seg[15:8])),
              m2(.D(num[11:8]),.point(0),.LE(0),.SEG(seg[23:16])),
              m3(.D(num[15:12]),.point(0),.LE(0),.SEG(seg[31:24])),
              m4(.D(num[19:16]),.point(0),.LE(0),.SEG(seg[39:32])),
              m5(.D(num[23:20]),.point(0),.LE(0),.SEG(seg[47:40])),
              m6(.D(num[27:24]),.point(0),.LE(0),.SEG(seg[55:48])),
              m7(.D(num[31:28]),.point(0),.LE(0),.SEG(seg[63:56]));
              reg start_d;
    always @(posedge clk_div[0]) start_d <= clk_div[7];
    wire start_pulse = clk_div[7] & ~start_d;
    SEG_DRV s0(.clk(clk_div[0]),.SEG(seg),.start(start_pulse),.SEGCLK(SEGCLK),.SEGCLR(SEGCLR),.SEGDT(SEGDT),.SEGEN(SEGEN));
endmodule
//    SEG_DRV s0(.clk(clk_div[0]),.SEG(seg),.start(clk_div[6]),.SEGCLK(SEGCLK),.SEGCLR(SEGCLR),.SEGDT(SEGDT),.SEGEN(SEGEN));//
//