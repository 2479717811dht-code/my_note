module shift_reg8b(
    input wire clk,
    input wire S_L,
    input wire s_in,
    input wire [7:0] p_in,
    output reg [7:0] Q
);

always @(posedge clk)
begin
    if(S_L)
        Q <= p_in;
    else
        Q <= {Q[6:0], s_in};
end

endmodule