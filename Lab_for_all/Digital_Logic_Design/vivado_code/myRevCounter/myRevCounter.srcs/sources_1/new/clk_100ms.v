module clk_100ms #(parameter DIV = 2) (
    input wire clk_in, // 100MHz
    output reg clk_out 
);
    reg [31:0] cnt;
    initial clk_out = 0;

    always @(posedge clk_in) begin
        if (cnt < DIV - 1)
            cnt <= cnt + 1;
        else begin
            cnt <= 0;
            clk_out <= ~clk_out;
        end
    end
endmodule