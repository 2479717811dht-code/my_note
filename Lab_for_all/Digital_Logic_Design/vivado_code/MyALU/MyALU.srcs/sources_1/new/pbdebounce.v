module pbdebounce (
    input wire clk_1ms,
    input wire button,
    output reg pbreg
);
    reg [7:0] pbshift;
    always @(posedge clk_1ms) begin
        pbshift <= {pbshift[6:0], button};
        if (pbshift == 8'b0)
            pbreg <= 1'b0;
        else if (pbshift == 8'hFF)
            pbreg <= 1'b1;
    end
endmodule