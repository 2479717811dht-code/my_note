`timescale 1ns/1ps

module Top_tb;
    reg clk;
    reg [3:0] BTN;
    reg [15:0] SW;

    wire BTNX4;
    wire SEGDO;
    wire SEGCLK;
    wire SEGEN;
    wire SEGCLR;

    Top dut (
        .clk     (clk),
        .BTN     (BTN),
        .SW      (SW),
        .BTNX4   (BTNX4),
        .SEGDO  (SEGDO),
        .SEGCLK (SEGCLK),
        .SEGEN  (SEGEN),
        .SEGCLR (SEGCLR)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    task press;
        input integer idx;
        input integer count;
        integer j;
        begin
            for (j = 0; j < count; j = j + 1) begin
                SW[idx - 1] = 1;
                @(posedge clk);
                SW[idx - 1] = 0;
                @(posedge clk);
            end
        end
    endtask
    
   initial begin
    BTN = 4'b0000;
    SW  = 16'h0000;
    repeat (1) @(posedge clk);
    press(1, 5);   // 千万位 5 (SW0)
    press(3, 1);   // 十万位 1 (SW2)
    press(5, 2);   // 千位   2 (SW4)
    press(6, 2);   // 百位   2 (SW5)
    press(7, 2);   // 十位   2 (SW6)
    press(8, 3);   // 个位   3 (SW7)
    press(16, 1);  // 启动显示 (SW15)
    repeat (80) @(posedge clk);
    $stop;
end

endmodule

