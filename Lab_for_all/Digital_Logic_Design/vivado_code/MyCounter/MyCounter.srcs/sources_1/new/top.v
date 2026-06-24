module top( 
    input wire clk, 
	output wire [3:0] AN,
	output wire [7:0] SEGMENT,
	output wire BTNX4,
	output wire RC
);
	wire [3:0] num;
	wire clk_1s;
    counter_1s c1(.clk(clk), .clk_1s(clk_1s));
    counter_4bit c4b(
        .clk(clk_1s),
        .QA(num[3]),
        .QB(num[2]),
        .QC(num[1]),
        .QD(num[0]),
        .RC(RC)
      );
    MyMC14495 s0(
        .D3(num[3]), .D2(num[2]),  .D1(num[1]), .D0(num[0]),
        .point(0), .LE(0),
        .a(SEGMENT[0]),
        .b(SEGMENT[1]),
        .c(SEGMENT[2]),
        .d(SEGMENT[3]),
        .e(SEGMENT[4]),
        .f(SEGMENT[5]),
        .g(SEGMENT[6]),
        .p(SEGMENT[7])
    );
    assign AN[3:0] = 4'b1110;
    assign BTNX4 = 1'b0;
endmodule
