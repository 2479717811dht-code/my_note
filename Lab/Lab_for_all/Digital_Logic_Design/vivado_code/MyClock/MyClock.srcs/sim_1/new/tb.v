`timescale 1ns / 1ps

module tb(

    );
    reg clk;
    reg [15:0] SW;
    wire SEGCLK;
    wire SEGCLR;
    wire SEGDT;
    wire SEGEN;
    top uut(.clk(clk),.SW(SW),.SEGCLK(SEGCLK),.SEGCLR(SEGCLR),.SEGDT(SEGDT),.SEGEN(SEGEN));
    initial begin
        clk=0;
        SW=0;
        SW[15]=1;
        #3000;
        SW[15]=0;
        #240000000;
        $finish;
    end
    always #10 clk=~clk;
endmodule