`timescale 1ns / 1ps
module Top_tb();

    reg  clk_100m;
reg [1:0] sw;
    wire [3:0] AN;
    wire [7:0] SEGMENT;
    wire [7:0] LED;

    Top #(
        .CLK_DIV_100MS (10),
        .SCAN_DIV (2) 
    ) u_top (
        .clk_100m(clk_100m),
        .SW      (sw),   // 👈 只改了这里：大写 SW
        .AN      (AN),
        .SEGMENT (SEGMENT),
        .LED     (LED)
    );

    always #5 clk_100m = ~clk_100m;

    initial begin
        clk_100m = 0;
        sw = 1;  
        #5000;    
        sw = 0;
        #5000;
        $finish;
    end

    initial
        $monitor("Time=%t, cnt=%d, Rc=%b", $time, u_top.u_counter.cnt, LED[0]);

endmodule