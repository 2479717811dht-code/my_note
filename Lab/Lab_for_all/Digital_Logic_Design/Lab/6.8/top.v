`timescale 1ns / 1ps
module top(
    input wire clk,
	input wire [15:0] SW,
	output wire SEG_DO,
    output wire SEG_EN,
    output wire SEG_CLK,
    output wire SEG_CLR
    );
    
    wire [31:0] clk_div;
    wire [31:0] num0;
	wire [31:0] num;
	wire [63:0] OUT;
	wire [5:0] CO, rst;
	wire start;
	assign SEG_CLR = 1;
	assign SEG_EN = 1;
	
	reg clk_s;
    reg [23:0] cnt_s;
    localparam CNT_100MS_MAX = 10_000_000 - 1;  // 100ms 对应 10M 个时钟
    initial begin
        cnt_s = 0;
        clk_s = 0;
    end
    always @(posedge clk) begin
        if (cnt_s == CNT_100MS_MAX) begin
            cnt_s <= 0;
            clk_s <= 1'b1;
        end else begin
            cnt_s <= cnt_s + 1'b1;
            clk_s <= 1'b0;
        end
    end
    
    reg seg_start;
    reg [16:0] cnt_seg;
    localparam CNT_SEG_MAX = 100_000 - 1;  // 100MHz / 100000 = 1kHz
    initial cnt_seg = 0;
    always @(posedge clk) begin
        if (cnt_seg == CNT_SEG_MAX) begin
            cnt_seg <= 0;
            seg_start <= 1'b1;
        end else begin
            cnt_seg <= cnt_seg + 1'b1;
            seg_start <= 1'b0;
        end
    end
	
	reg Load, SWpre;
	always@(posedge clk) begin
	   if(SW[15] && !SWpre)
	       Load = 0;
	   else
	       Load = 1;
	   SWpre <= SW[15];
	end
	
	clkdiv m3(.clk(clk), .rst(1'b0), .clk_div(clk_div));
    
    wire [3:0] sec0, sec1;   // 秒个位、秒十位
    wire [3:0] min0, min1;   // 分个位、分十位
    wire [3:0] hour0, hour1; // 时个位、时十位

    wire carry_sec0, carry_sec1, carry_min0, carry_min1, carry_hour0;

    // 秒个位进位：计到9且秒脉冲有效
    assign carry_sec0 = (sec0 == 4'd9) && clk_s;
    // 秒十位进位：计到5且秒个位进位有效
    assign carry_sec1 = (sec1 == 4'd5) && carry_sec0;
    // 分个位进位：计到9且秒十位进位有效
    assign carry_min0 = (min0 == 4'd9) && carry_sec1;
    // 分十位进位：计到5且分个位进位有效
    assign carry_min1 = (min1 == 4'd5) && carry_min0;
    // 小时个位进位：计到9且分十位进位有效（用于小时模24内个位到十位的进位，但小时整体清零优先）
    assign carry_hour0 = (hour0 == 4'd9) && carry_min1;

    wire clr_sec0, clr_sec1, clr_min0, clr_min1, clr_hour0, clr_hour1;

    assign clr_sec0 = carry_sec0;               // 秒个位到9后下一个时钟加载0
    assign clr_sec1 = carry_sec1;               // 秒十位到5后下一个时钟加载0
    assign clr_min0 = carry_min0;               // 分个位到9后加载0
    assign clr_min1 = carry_min1;               // 分十位到5后加载0

    
    wire hour_clr_all = (hour1 == 2 && hour0 == 3) && carry_min1;
    assign clr_hour0 = (carry_hour0) || hour_clr_all;   // 个位到9或整体清零
    assign clr_hour1 = hour_clr_all;                    // 十位仅整体清零时清

    wire ld_sec0  = ~clr_sec0;
    wire ld_sec1  = ~clr_sec1;
    wire ld_min0  = ~clr_min0;
    wire ld_min1  = ~clr_min1;
    wire ld_hour0 = ~clr_hour0;
    wire ld_hour1 = ~clr_hour1;

    wire ld_sec0_final  = ld_sec0  & Load;
    wire ld_sec1_final  = ld_sec1  & Load;
    wire ld_min0_final  = ld_min0  & Load;
    wire ld_min1_final  = ld_min1  & Load;
    wire ld_hour0_final = ld_hour0 & Load;
    wire ld_hour1_final = ld_hour1 & Load;

    // 预设初值（23:58:30）
    wire [3:0] init_sec0  = 4'd0;
    wire [3:0] init_sec1  = 4'd3;
    wire [3:0] init_min0  = 4'd8;
    wire [3:0] init_min1  = 4'd5;
    wire [3:0] init_hour0 = 4'd3;
    wire [3:0] init_hour1 = 4'd2;

    // D输入：清零时加载0，初始化时加载初值
    wire [3:0] D_sec0  = clr_sec0  ? 4'b0 : init_sec0;
    wire [3:0] D_sec1  = clr_sec1  ? 4'b0 : init_sec1;
    wire [3:0] D_min0  = clr_min0  ? 4'b0 : init_min0;
    wire [3:0] D_min1  = clr_min1  ? 4'b0 : init_min1;
    wire [3:0] D_hour0 = clr_hour0 ? 4'b0 : init_hour0;
    wire [3:0] D_hour1 = clr_hour1 ? 4'b0 : init_hour1;

    My74LS161 u_sec0 (
        .CP(clk), .CR(1'b1), .Ld(ld_sec0_final),
        .CTP(clk_s), .CTT(clk_s),
        .D(D_sec0), .Q(sec0), .CO()   // CO悬空，不使用
    );
    My74LS161 u_sec1 (
        .CP(clk), .CR(1'b1), .Ld(ld_sec1_final),
        .CTP(carry_sec0), .CTT(carry_sec0),
        .D(D_sec1), .Q(sec1), .CO()
    );
    My74LS161 u_min0 (
        .CP(clk), .CR(1'b1), .Ld(ld_min0_final),
        .CTP(carry_sec1), .CTT(carry_sec1),
        .D(D_min0), .Q(min0), .CO()
    );
    My74LS161 u_min1 (
        .CP(clk), .CR(1'b1), .Ld(ld_min1_final),
        .CTP(carry_min0), .CTT(carry_min0),
        .D(D_min1), .Q(min1), .CO()
    );
    My74LS161 u_hour0 (
        .CP(clk), .CR(1'b1), .Ld(ld_hour0_final),
        .CTP(carry_min1), .CTT(carry_min1),
        .D(D_hour0), .Q(hour0), .CO()
    );
    My74LS161 u_hour1 (
        .CP(clk), .CR(1'b1), .Ld(ld_hour1_final),
        .CTP(carry_hour0), .CTT(carry_hour0),
        .D(D_hour1), .Q(hour1), .CO()
    );
    
    assign num[31:24] = 8'b0;
    assign num[23:20] = hour1;
    assign num[19:16] = hour0;
    assign num[15:12] = min1;
    assign num[11: 8] = min0;
    assign num[ 7: 4] = sec1;
    assign num[ 3: 0] = sec0;
	
	genvar i;
	generate
        for(i = 7; i >= 0; i = i - 1) begin
            MyMC14495 mb(.D3(num[i * 4 + 3]), .D2(num[i * 4 + 2]), .D1(num[i * 4 + 1]), .D0(num[i * 4]), 
                .point(1'b0), .LE(1'b0), .p(OUT[i * 8 + 7]), .g(OUT[i * 8 + 6]), .f(OUT[i * 8 + 5]), .e(OUT[i * 8 + 4]),
                .d(OUT[i * 8 + 3]), .c(OUT[i * 8 + 2]), .b(OUT[i * 8 + 1]), .a(OUT[i * 8]));
        end
    endgenerate
	
	SEG_DRV DRV(.clk(clk), .start(seg_start), .num(OUT), .SEG_CLK(SEG_CLK), .SEG_CLR(SEG_CLR), .SEG_DO(SEG_DO), .SEG_EN(SEG_EN));
endmodule
