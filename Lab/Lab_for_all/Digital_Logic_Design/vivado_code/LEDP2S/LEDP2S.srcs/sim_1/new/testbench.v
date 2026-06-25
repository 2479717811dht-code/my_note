`timescale 1ns / 1ps

module testbench;
  // 时钟和输入
  reg         clk;
  reg [3:0]   BTN;
  reg [15:0]  SW;
  // 顶层输出
  wire        BTNX4;
  wire [7:0]  SEGMENT;
  wire [3:0]  AN;
  wire        LED_DO, LED_CLK, LED_EN, LED_CLR;

  // 实例化 DUT
  Top dut (
    .clk     (clk),
    .BTN     (BTN),
    .SW      (SW),
    .BTNX4   (BTNX4),
    .SEGMENT (SEGMENT),
    .AN      (AN),
    .LED_DO  (LED_DO),
    .LED_CLK (LED_CLK),
    .LED_EN  (LED_EN),
    .LED_CLR (LED_CLR)
  );

  // 生成 100MHz 时钟
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // 初始输入全拉低
    BTN = 4'b0000;
    SW  = 16'h0000;

    // 等待几拍让复位
    repeat (5) @(posedge clk);

    // 设定为加法
    SW[3:0] = 4'b0000;

    // 装入 num3 = 4
    repeat (4) begin
      // 按键脉冲
      BTN[3] = 1;
      @(posedge clk);
      BTN[3] = 0;
      @(posedge clk);
    end

    // 装入 num2 = 3
    repeat (3) begin
      BTN[2] = 1;
      @(posedge clk);
      BTN[2] = 0;
      @(posedge clk);
    end

    // 装入 num1 = 2
    repeat (2) begin
      BTN[1] = 1;
      @(posedge clk);
      BTN[1] = 0;
      @(posedge clk);
    end

    // 装入 num0 = 1
    repeat (1) begin
      BTN[0] = 1;
      @(posedge clk);
      BTN[0] = 0;
      @(posedge clk);
    end

    // 清除 BTN
    BTN = 4'b0000;
    @(posedge clk);

    SW[15] = 1;
    @(posedge clk);
    SW[15] = 0;

    // 观察 20 个时钟周期
    repeat (20) @(posedge clk);

    #10;
    $finish;
  end
endmodule

