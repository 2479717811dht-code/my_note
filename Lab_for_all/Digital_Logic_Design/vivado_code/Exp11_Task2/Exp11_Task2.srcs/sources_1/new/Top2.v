`timescale 1ns / 1ps

module Top2(
    input clk,
    input [3:0] BTN,
    input [15:0] SW,
    output BTNX4,
    output [7:0] LED,
    output [7:0] SEGMENT,
    output [3:0] AN
);
wire Load_A,Load_B,Load_C;
wire [3:0] A_OUT,A_IN, A1;
wire [3:0] B_OUT,B_IN, B1;
wire [3:0] C_OUT,C_IN;
wire [31:0] clk_div;
wire [15:0] num;
wire [3:0] M_OUT;

assign BTNX4 = 1'b0;
//assign LED    = 8'd0;

clkdiv m3(.clk(clk),.rst(1'b0),.clk_div(clk_div));

Load_Gen mA(.clk(clk), .clk_1ms(clk_div[17]),.btn_in(BTN[3]),.Load_out(Load_A));
Load_Gen mB(.clk(clk),.clk_1ms(clk_div[17]),.btn_in(BTN[2]),.Load_out(Load_B));
Load_Gen mC(.clk(clk),.clk_1ms(clk_div[17]),.btn_in(BTN[1]),.Load_out(Load_C));

// 端口名必须和 MyRegister4b 定义一致（大写 IN/Load/OUT）
MyRegister4b RegA(.clk(clk),.IN(A_IN),.Load(Load_A),.OUT(A_OUT));
MyRegister4b RegB(.clk(clk),.IN(B_IN),.Load(Load_B),.OUT(B_OUT));
MyRegister4b RegC(.clk(clk),.IN(C_IN),.Load(Load_C),.OUT(C_OUT));

AddSub4b m4A(.Ctrl(SW[0]), .A(A_OUT),.B(4'b0001),.S(A1));
assign A_IN = (SW[15]==1'b0) ? A1 : M_OUT;

AddSub4b m4B(.Ctrl(SW[1]), .A(B_OUT),.B(4'b0001),.S(B1));
assign B_IN = (SW[15]==1'b0) ? B1 : M_OUT;

assign C_IN = (SW[15]==1'b0) ? 4'b0000 : M_OUT;

// 端口名必须和 Mux4to1b4 定义一致（大写 S）
Mux4to1b4 m124(.S(SW[8:7]),.I0(A_OUT),.I1(B_OUT),.I2(C_OUT),.I3(4'b0000),.O(M_OUT));

// 端口名必须和 DispNum 定义一致（大写 HEXS）
DispNum m8(.scan(clk_div[18:17]),.HEXS(num),.LES(4'b0),.point(4'b0),.AN(AN),.SEGMENT(SEGMENT));

assign num = {A_OUT,B_OUT,C_OUT,M_OUT};

endmodule