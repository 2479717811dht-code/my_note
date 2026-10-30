module pbdebounce(
    input clk,
    input btn_in,
    output reg btn_out
);
    reg [15:0] cnt;
    reg sync_0, sync_1;
    
    always @(posedge clk) begin
        sync_0 <= btn_in;
        sync_1 <= sync_0;
    end
    
    always @(posedge clk) begin
        if(sync_1 != btn_out) begin
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
            if(cnt == 16'hffff)
                btn_out <= sync_1;
        end
    end
endmodule
