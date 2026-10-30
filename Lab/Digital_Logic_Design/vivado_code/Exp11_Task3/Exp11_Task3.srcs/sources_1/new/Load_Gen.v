module Load_Gen(
    input clk,
    input clk_1ms,
    input btn_in,
    output reg Load_out
);
    wire btn_out;
    reg old_btn;
    
 
    assign btn_out = btn_in;  // 仿真直通

    
    always @(posedge clk) begin
        if(old_btn == 0 && btn_out == 1)
            Load_out <= 1;
        else
            Load_out <= 0;
        old_btn <= btn_out;
    end
endmodule