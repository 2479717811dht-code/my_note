module Top(
    input clk,

    output reg hs,
    output reg vs,
    output reg [3:0] r,
    output reg [3:0] g,
    output reg [3:0] b,

    output [7:0] LED
);

//
// 100MHz -> 25MHz VGA pixel clock
//
reg [1:0] clk_div = 0;

always @(posedge clk) begin
    clk_div <= clk_div + 1'b1;
end

wire pix_clk = clk_div[1];

//
// VGA 640x480@60Hz timing
//
reg [9:0] h_cnt = 0;
reg [9:0] v_cnt = 0;

always @(posedge pix_clk) begin
    if (h_cnt == 10'd799) begin
        h_cnt <= 10'd0;

        if (v_cnt == 10'd524)
            v_cnt <= 10'd0;
        else
            v_cnt <= v_cnt + 1'b1;
    end
    else begin
        h_cnt <= h_cnt + 1'b1;
    end
end

wire visible;
assign visible = (h_cnt < 10'd640) && (v_cnt < 10'd480);

//
// HS/VS: VGA standard negative pulse
//
always @(posedge pix_clk) begin
    hs <= ~((h_cnt >= 10'd656) && (h_cnt < 10'd752));
    vs <= ~((v_cnt >= 10'd490) && (v_cnt < 10'd492));

    if (!visible) begin
        r <= 4'h0;
        g <= 4'h0;
        b <= 4'h0;
    end
    else begin
        if (h_cnt < 10'd160) begin
            r <= 4'hF;
            g <= 4'h0;
            b <= 4'h0;   // 红
        end
        else if (h_cnt < 10'd320) begin
            r <= 4'h0;
            g <= 4'hF;
            b <= 4'h0;   // 绿
        end
        else if (h_cnt < 10'd480) begin
            r <= 4'h0;
            g <= 4'h0;
            b <= 4'hF;   // 蓝
        end
        else begin
            r <= 4'hF;
            g <= 4'hF;
            b <= 4'hF;   // 白
        end
    end
end

//
// LED诊断
//
reg [26:0] clk_alive = 0;
reg [15:0] hs_count = 0;
reg [7:0]  vs_count = 0;

reg hs_last = 1;
reg vs_last = 1;

always @(posedge clk) begin
    clk_alive <= clk_alive + 1'b1;
end

always @(posedge pix_clk) begin
    hs_last <= hs;
    vs_last <= vs;

    // 检测HS下降沿
    if (hs_last == 1'b1 && hs == 1'b0)
        hs_count <= hs_count + 1'b1;

    // 检测VS下降沿
    if (vs_last == 1'b1 && vs == 1'b0)
        vs_count <= vs_count + 1'b1;
end

assign LED[0] = clk_alive[26];  // 主时钟活着：慢闪
assign LED[1] = 1'b1;           // 程序已下载：常亮
assign LED[2] = hs_count[14];   // HS在跳：约1Hz闪
assign LED[3] = vs_count[5];    // VS在跳：约1Hz闪
assign LED[7:4] = 4'b0000;

endmodule
