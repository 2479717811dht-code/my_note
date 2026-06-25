module counter_1s(clk, clk_1s);
    input wire clk;
    output reg clk_1s;
    reg [31:0] cnt;
    initial clk_1s = 0;
    always @ (posedge clk) begin
       if (cnt < 50000000) begin
           cnt <= cnt + 1'b1;
       end else begin
           cnt <= 0;
           clk_1s <= ~clk_1s;
       end
    end
endmodule
