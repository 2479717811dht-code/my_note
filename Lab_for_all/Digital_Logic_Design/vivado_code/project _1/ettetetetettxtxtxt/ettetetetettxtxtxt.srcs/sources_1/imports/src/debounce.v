`timescale 1ns / 1ps

module debounce(
    input  wire clk,
    input  wire rst_n,
    input  wire key_in,
    output reg  key_out
);

// Two-stage sync inside debouncer, then require stable level for about 10 ms
// at 100 MHz: 1,000,000 cycles.
reg key_meta = 1'b0;
reg key_sync = 1'b0;
reg key_last = 1'b0;
reg [19:0] cnt = 20'd0;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        key_meta <= 1'b0;
        key_sync <= 1'b0;
        key_last <= 1'b0;
        key_out  <= 1'b0;
        cnt      <= 20'd0;
    end
    else begin
        key_meta <= key_in;
        key_sync <= key_meta;

        if (key_sync != key_last) begin
            key_last <= key_sync;
            cnt <= 20'd0;
        end
        else if (cnt < 20'd999999) begin
            cnt <= cnt + 20'd1;
        end
        else begin
            key_out <= key_sync;
        end
    end
end

endmodule
