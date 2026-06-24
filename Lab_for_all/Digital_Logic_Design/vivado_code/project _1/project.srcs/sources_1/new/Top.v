module Top(
    input clk,

    output hs,
    output vs,
    output [3:0] r,
    output [3:0] g,
    output [3:0] b
);

wire vga_clk;

// 100MHz / 4 = 25MHz
reg [1:0] clk_div = 0;

always @(posedge clk) begin
    clk_div <= clk_div + 1'b1;
end

assign vga_clk = clk_div[1];

wire [8:0] row;
wire [9:0] col;
wire rdn;

reg [11:0] vga_data;

VGA U_VGA(
    .clk(vga_clk),
    .rst(1'b0),
    .Din(vga_data),
    .row(row),
    .col(col),
    .rdn(rdn),
    .R(r),
    .G(g),
    .B(b),
    .HS(hs),
    .VS(vs)
);

// 颜色格式：Din[3:0] = R，Din[7:4] = G，Din[11:8] = B
always @(*) begin
    if (rdn) begin
        vga_data = 12'h000;
    end
    else begin
        if (col < 10'd320 && row < 9'd240)
            vga_data = 12'h00F;   // 左上：红色
        else if (col >= 10'd320 && row < 9'd240)
            vga_data = 12'h0F0;   // 右上：绿色
        else if (col < 10'd320 && row >= 9'd240)
            vga_data = 12'hF00;   // 左下：蓝色
        else
            vga_data = 12'h0FF;   // 右下：黄色
    end
end

endmodule


module VGA(
    input clk,
    input rst,
    input [11:0] Din,

    output reg [8:0] row,
    output reg [9:0] col,
    output reg rdn,

    output reg [3:0] R,
    output reg [3:0] G,
    output reg [3:0] B,

    output reg HS,
    output reg VS
);

reg [9:0] h_count;
reg [9:0] v_count;

always @(posedge clk) begin
    if (rst)
        h_count <= 10'd0;
    else if (h_count == 10'd799)
        h_count <= 10'd0;
    else
        h_count <= h_count + 10'd1;
end

always @(posedge clk) begin
    if (rst)
        v_count <= 10'd0;
    else if (h_count == 10'd799) begin
        if (v_count == 10'd524)
            v_count <= 10'd0;
        else
            v_count <= v_count + 10'd1;
    end
end

wire [9:0] row_addr;
wire [9:0] col_addr;
wire h_sync;
wire v_sync;
wire read_area;

assign row_addr = v_count - 10'd35;
assign col_addr = h_count - 10'd143;

assign h_sync = (h_count > 10'd95);
assign v_sync = (v_count > 10'd1);

assign read_area = (h_count > 10'd142) &&
                   (h_count < 10'd783) &&
                   (v_count > 10'd34)  &&
                   (v_count < 10'd515);

always @(posedge clk) begin
    row <= row_addr[8:0];
    col <= col_addr;
    rdn <= ~read_area;

    HS <= h_sync;
    VS <= v_sync;

    if (~read_area) begin
        R <= 4'h0;
        G <= 4'h0;
        B <= 4'h0;
    end
    else begin
        R <= Din[3:0];
        G <= Din[7:4];
        B <= Din[11:8];
    end
end

endmodule