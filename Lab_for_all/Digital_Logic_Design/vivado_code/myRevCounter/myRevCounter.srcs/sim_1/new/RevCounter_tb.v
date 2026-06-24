`timescale 1ns / 1ps

module RevCounter_tb();

    reg clk;
    reg sw;
    wire [15:0] cnt;
    wire RC;

    RevCounter uut (
        .clk (clk),
        .cnt (cnt),
        .s(sw),
        .Rc(RC)
    );

    always #10 clk = ~clk;

   initial begin
        clk = 0;
        sw = 1;
        #40; sw = 0;
        #100;
        sw = 1;
        #100;
        $finish;
    end

endmodule