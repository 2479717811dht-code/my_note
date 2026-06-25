`timescale 1ns / 1ps

module Top(
    input  wire        clk,
    input  wire [3:0]  BTN,
    input  wire [15:0] SW,
    output wire        BTNX4,
    output wire        SEGDO,    // 串行数据输出
    output wire        SEGCLK,   // 串行移位时钟
    output wire        SEGEN,    // 输出使能，高有效
    output wire        SEGCLR    // 清除信号，低有效
);

    // 时钟分频器实例，产生1ms 
    wire [31:0] clk_div;
    clkdiv u_clkdiv (
        .clk    (clk),
        .rst    (0),
        .clk_div(clk_div)
    );

    // 8路4位计数器累积输出64位数据
    wire [31:0] num;
    wire [7:0]  Load;

    assign BTNX4 = 1'b0;

    genvar i;
    // 八个4位二进制计数器
    generate
      for (i = 0; i < 8; i = i + 1) begin : COUNTERS
        Counter_4b u_counter (
          .SubMode(0),
          .En     (Load[i]),
          .clk    (clk),
          .num    (num[4*i +: 4])
        );
      end
    endgenerate

    // 八路按键消抖及Load信号
    generate
      for (i = 0; i < 8; i = i + 1) begin : LOAD_GENS
        Load_Gen u_load (
          .clk     (clk),
          .clk_1ms (clk_div[17]),   // 17位约1ms分频
          .btn_in  (SW[7 - i]),
          .Load_out(Load[i])
        );
      end
    endgenerate

    // 并行装载启动信号
    wire start;
    Load_Gen m66(.clk(clk), .clk_1ms(clk_div[17]), .btn_in(SW[15]), .Load_out(start));
    
    // 小数点不使用
    wire [7:0] points = 8'b0;

    // BCD转8段并行数据
    wire [63:0] seg_data;
    HexsTo8Seg u_hexs2seg (
        .hexs    (num[31:0]),
        .points  (points),
        .LEs     (Load),
        .seg_data(seg_data)
    );

    // SEG 64位并行装载/串行移出
    SEG_DRV u_segdrv (
        .clk    (clk),
        .SEG    (seg_data),
        .start  (start),
        .SEGDT  (SEGDO),
        .SEGCLK (SEGCLK),
        .SEGEN  (SEGEN),
        .SEGCLR (SEGCLR)
    );

endmodule