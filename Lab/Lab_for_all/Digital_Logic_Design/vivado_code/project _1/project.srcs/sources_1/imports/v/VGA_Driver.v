`timescale 1ns / 1ps

// 该模块参照可以正常运行的 rhythm-game 工程 VGA_Driver 写法
// 输入 d_in 格式：{Blue[3:0], Green[3:0], Red[3:0]}
module VGA_Driver(
    input vga_clk,
    input clrn,
    input [11:0] d_in,

    output reg [8:0] row_addr,
    output reg [9:0] col_addr,
    output reg rdn,

    output reg [3:0] r,
    output reg [3:0] g,
    output reg [3:0] b,
    output reg hs,
    output reg vs
);

reg [9:0] h_count;
reg [9:0] v_count;

always @(posedge vga_clk or negedge clrn) begin
    if (!clrn) begin
        h_count <= 10'd0;
    end
    else if (h_count == 10'd799) begin
        h_count <= 10'd0;
    end
    else begin
        h_count <= h_count + 10'd1;
    end
end

always @(posedge vga_clk or negedge clrn) begin
    if (!clrn) begin
        v_count <= 10'd0;
    end
    else if (h_count == 10'd799) begin
        if (v_count == 10'd524)
            v_count <= 10'd0;
        else
            v_count <= v_count + 10'd1;
    end
end

wire [9:0] row  = v_count - 10'd35;
wire [9:0] col  = h_count - 10'd143;
wire h_sync = (h_count > 10'd95);
wire v_sync = (v_count > 10'd1);

wire read = (h_count > 10'd142) &&
            (h_count < 10'd783) &&
            (v_count > 10'd34)  &&
            (v_count < 10'd515);

always @(posedge vga_clk) begin
    row_addr <= row[8:0];
    col_addr <= col[9:0];
    rdn      <= ~read;
    hs       <= h_sync;
    vs       <= v_sync;

    r <= rdn ? 4'h0 : d_in[3:0];
    g <= rdn ? 4'h0 : d_in[7:4];
    b <= rdn ? 4'h0 : d_in[11:8];
end

endmodule
