module clkdiv(
    input clk,
    input rst,
    output reg [31:0] clk_div
);
    initial clk_div = 0;
    always @(posedge clk or posedge rst) begin
        if(rst) clk_div <= 0;
        else clk_div <= clk_div + 1;
    end
endmodule
