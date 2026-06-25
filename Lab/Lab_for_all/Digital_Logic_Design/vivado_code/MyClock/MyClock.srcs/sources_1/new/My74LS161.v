module My74LS161 (
    input wire clk,         // 时钟
    input wire CR,          // 异步清零，低有效
    input wire LD,          // 同步并行加载，低有效
    input wire CTP,         // 使能 CTP
    input wire CTT,         // 使能 CTT
    input wire [3:0] D,     // 并行输入 D3..D0
    output reg [3:0] Q,     // 输出 Q3..Q0
    output wire CO          // 进位输出
);

    always @(posedge clk or negedge CR) begin
        if (!CR) begin
            Q <= 4'b0000;
        end else if (!LD) begin
            Q <= D;
        end else if (CTP && CTT) begin
            Q <= Q + 1;
        end
    end

    assign CO = (Q == 4'b1111) && CTT;

endmodule
