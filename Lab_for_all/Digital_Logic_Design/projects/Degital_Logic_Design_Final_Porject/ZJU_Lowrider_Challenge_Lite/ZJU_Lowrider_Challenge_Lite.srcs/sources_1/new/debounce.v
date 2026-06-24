`timescale 1ns / 1ps

module debounce(
    input clk,
    input key_in,
    output reg key_out
);

    reg [19:0] cnt = 0;
    reg key_sync = 1'b1;
    initial key_out = 1'b1;

    always @(posedge clk) begin
        if (key_in != key_sync) begin
            cnt <= cnt + 1;
            if (cnt >= 20'd999999) begin
                key_sync <= key_in;
                key_out  <= key_in;
                cnt      <= 0;
            end
        end
        else begin
            cnt <= 0;
        end
    end

endmodule