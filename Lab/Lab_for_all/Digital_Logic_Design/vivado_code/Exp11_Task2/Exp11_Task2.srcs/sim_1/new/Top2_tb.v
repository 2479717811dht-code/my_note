`timescale 1ns / 1ps

module Top2_tb(
);
    reg clk;
    reg [3:0] BTN;
    reg [15:0] SW;
    wire BTNX4;
    wire [7:0] LED;
    wire [7:0] SEGMENT;
    wire [3:0] AN;

    Top2 uut(
        .clk(clk),
        .BTN(BTN),
        .SW(SW),
        .BTNX4(),
        .LED(),
        .SEGMENT(SEGMENT),
        .AN(AN)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        BTN = 4'b0000;
        SW  = 16'b0;
        #10 SW[15] = 0; SW[8:7] = 2'b10;
        #10 BTN[1] = 1;
        #10 BTN[1] = 0; // C = 0
        #10 SW[15] = 1;
        #10 BTN[2] = 1; BTN[3] = 1;
        #10 BTN[2] = 0; BTN[3] = 0; // A = B = 0
        #10 SW[15] = 0; SW[0] = 0;
        #10 BTN[3] = 1;
        #10 BTN[3] = 0;
        #10 BTN[3] = 1;
        #10 BTN[3] = 0;
        #10 BTN[3] = 1;
        #10 BTN[3] = 0; // A = 3
        #10 SW[15] = 0; SW[1] = 1;
        #10 BTN[2] = 1;
        #10 BTN[2] = 0;
        #10 BTN[2] = 1;
        #10 BTN[2] = 0; // B = e
        #10 SW[15] = 1; SW[8:7] = 2'b00;
        #10 BTN[1] = 1;
        #10 BTN[1] = 0; // C = A
        #10 SW[15] = 1; SW[8:7] = 2'b01;
        #10 BTN[3] = 1;
        #10 BTN[3] = 0; // A = B
        #100;
        $finish;
    end

endmodule