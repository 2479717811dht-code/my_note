`timescale 1ns / 1ps

module ShiftReg64(
    input  wire        clk,     // 时钟上升沿触发
    input  wire        S_L,     // 1: 并行装载，0: 串行左移
    input  wire [63:0] p_in,    // 并行输入
    output wire        finish,  // 低64位全1时置1
    output wire        s_out    // 串行输出（最高位）
);

    // 65 位移位寄存器：
    //   s[64] 作为输出位
    //   s[63:0] 存储数据或移位产生的状态
    reg [64:0] s;
    initial s = -1;
    // 串行输出取自最高位
    assign s_out = s[64];
    // finish 在低 16 位全部为 1 时有效
    assign finish = &s[63:0];

    always @(posedge clk) begin
        if (S_L) begin
            // 并行装载：高 16 位装 p_in，最低位补 0
            s <= {p_in, 1'b0};
        end else begin
            // 串行左移：左侧舍弃最高位，右端补 1
            s <= {s[63:0], 1'b1};
        end
    end

endmodule