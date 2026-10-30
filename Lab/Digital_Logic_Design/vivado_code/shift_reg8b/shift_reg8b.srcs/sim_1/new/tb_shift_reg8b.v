module tb_shift_reg8b;

reg clk;
reg S_L;
reg s_in;
reg [7:0] p_in;

wire [7:0] Q;

shift_reg8b uut(
    .clk(clk),
    .S_L(S_L),
    .s_in(s_in),
    .p_in(p_in),
    .Q(Q)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;

    S_L = 1;
    p_in = 8'b10110011;

    #10;

    S_L = 0;
    s_in = 1;

    #100;

    $finish;
end

endmodule
