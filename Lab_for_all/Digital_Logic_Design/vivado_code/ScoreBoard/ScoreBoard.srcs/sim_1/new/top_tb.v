`timescale 1ns / 1ps

module top_tb;

reg clk;
reg [7:0] SW;
reg [3:0] BTN;
wire [3:0] AN;
wire [7:0] SEGMENT;
wire BTNX4;

top uut (
    .clk(clk),
    .SW(SW),
    .BTN(BTN),
    .AN(AN),
    .SEGMENT(SEGMENT),
    .BTNX4(BTNX4)
);

initial begin
    clk = 0;
    SW = 8'b00000000;
    BTN = 4'b0000;
    #100;
    
    BTN[0] = 1;
    #50;
    BTN[0] = 0;
    #200;
    
    BTN[1] = 1;
    #50;
    BTN[1] = 0;
    #200;
    
    $stop;
end

always #10 clk = ~clk;

endmodule