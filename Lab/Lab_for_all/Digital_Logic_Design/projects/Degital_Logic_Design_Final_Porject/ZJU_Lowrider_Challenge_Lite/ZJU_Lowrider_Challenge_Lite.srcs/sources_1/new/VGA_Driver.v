`timescale 1ns / 1ps

module VGA_Driver(
    input vga_clk,
    input clrn,                 // 接顶层 rstn，低电平有效
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
        if (!clrn)
            h_count <= 10'd0;
        else if (h_count == 10'd799)
            h_count <= 10'd0;
        else
            h_count <= h_count + 10'd1;
    end

    always @(posedge vga_clk or negedge clrn) begin
        if (!clrn)
            v_count <= 10'd0;
        else if (h_count == 10'd799) begin
            if (v_count == 10'd524)
                v_count <= 10'd0;
            else
                v_count <= v_count + 10'd1;
        end
    end

    wire [9:0] row = v_count - 10'd35;
    wire [9:0] col = h_count - 10'd143;
    wire h_sync = (h_count > 10'd95);
    wire v_sync = (v_count > 10'd1);

    wire read = (h_count > 10'd142) && (h_count < 10'd783) &&
                (v_count > 10'd34)  && (v_count < 10'd515);

    always @(posedge vga_clk) begin
        row_addr <= row[8:0];
        col_addr <= col[9:0];
        rdn      <= ~read;
        hs       <= h_sync;
        vs       <= v_sync;

        // 根据 XDC 拆分为独立的 3组 4位物理信号输出
        r <= read ? d_in[3:0]  : 4'h0;
        g <= read ? d_in[7:4]  : 4'h0;
        b <= read ? d_in[11:8] : 4'h0;
    end

endmodule