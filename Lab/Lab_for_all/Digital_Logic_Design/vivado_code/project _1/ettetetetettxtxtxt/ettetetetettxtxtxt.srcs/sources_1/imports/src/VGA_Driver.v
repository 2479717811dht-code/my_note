`timescale 1ns / 1ps

// 640x480 @ about 60 Hz VGA timing from a 100 MHz board clock.
// A 25 MHz pixel tick is generated as an enable, not as a separate clock.
// d_in color format: {Blue[3:0], Green[3:0], Red[3:0]}.

module VGA_Driver(
    input  wire clk,       // 100 MHz system clock
    input  wire rst_n,     // active-low reset
    input  wire [11:0] d_in,

    output reg  [8:0] row_addr,
    output reg  [9:0] col_addr,
    output reg  rdn,

    output reg  [3:0] r,
    output reg  [3:0] g,
    output reg  [3:0] b,
    output reg  hs,
    output reg  vs
);

reg [1:0] pix_div = 2'd0;
wire pix_tick = (pix_div == 2'd3);  // 100 MHz / 4 = 25 MHz pixel update

reg [9:0] h_count = 10'd0;          // 0..799
reg [9:0] v_count = 10'd0;          // 0..524

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        pix_div <= 2'd0;
    else
        pix_div <= pix_div + 2'd1;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        h_count <= 10'd0;
        v_count <= 10'd0;
    end
    else if (pix_tick) begin
        if (h_count == 10'd799) begin
            h_count <= 10'd0;
            if (v_count == 10'd524)
                v_count <= 10'd0;
            else
                v_count <= v_count + 10'd1;
        end
        else begin
            h_count <= h_count + 10'd1;
        end
    end
end

// Standard 640x480 negative sync timing at 25 MHz:
// Horizontal: sync 96, back porch 48, active 640, front porch 16 = 800
// Vertical:   sync 2,  back porch 33, active 480, front porch 10 = 525
wire visible = (h_count >= 10'd144) && (h_count < 10'd784) &&
               (v_count >= 10'd35)  && (v_count < 10'd515);

wire [9:0] col_next = h_count - 10'd144;
wire [9:0] row_next = v_count - 10'd35;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        row_addr <= 9'd0;
        col_addr <= 10'd0;
        rdn      <= 1'b1;
        r        <= 4'h0;
        g        <= 4'h0;
        b        <= 4'h0;
        hs       <= 1'b1;
        vs       <= 1'b1;
    end
    else if (pix_tick) begin
        hs <= (h_count >= 10'd96);  // active-low hsync pulse
        vs <= (v_count >= 10'd2);   // active-low vsync pulse

        rdn      <= ~visible;
        col_addr <= col_next[9:0];
        row_addr <= row_next[8:0];

        if (visible) begin
            r <= d_in[3:0];
            g <= d_in[7:4];
            b <= d_in[11:8];
        end
        else begin
            r <= 4'h0;
            g <= 4'h0;
            b <= 4'h0;
        end
    end
end

endmodule
