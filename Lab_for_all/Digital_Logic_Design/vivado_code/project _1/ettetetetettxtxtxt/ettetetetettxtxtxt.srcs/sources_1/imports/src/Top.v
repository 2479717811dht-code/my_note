`timescale 1ns / 1ps

// ============================================================
// Top for SWORD board dance/VGA project
//
// Fixed points:
//   1. SWORD independent key mode uses K_ROW/K_COL, not BTN/BTNX4.
//      K_ROW must be driven to 5'b00000, then K_COL[3:0] are read.
//   2. RSTN is an input reset key, not a VGA output.
//   3. Arduino daughter-board LEDs are active-low, so internal game
//      LED logic is kept high-active and inverted only at the physical pins.
//   4. VGA driver is clocked by the 100 MHz system clock and generates
//      a 25 MHz pixel enable internally. No fabric divided clock is used.
// ============================================================

module Top(
    input  wire clk,        // 100 MHz, AC18
    input  wire RSTN,       // active-low reset key, W13

    output wire [4:0] K_ROW,
    input  wire [3:0] K_COL,

    input  wire [15:0] SW,
    input  wire ps2_clk,
    input  wire ps2_data,

    output wire [7:0] LED,      // physical Arduino LED, active-low
    output wire [7:0] SEGMENT,  // physical seven-seg segments, active-low
    output wire [3:0] AN,       // physical digit enables, active-low

    output wire [3:0] r,
    output wire [3:0] g,
    output wire [3:0] b,
    output wire hs,
    output wire vs,

    output wire LED_CLK,
    output wire LED_CLR,
    output wire LED_DT,
    output wire LED_EN,

    output wire SEG_CLK,
    output wire SEG_CLR,
    output wire SEG_DT,
    output wire SEG_EN
);

// SWORD independent-key mode: drive all rows low, read columns.
assign K_ROW = 5'b00000;

wire rst_n = RSTN;

// Synchronize K_COL into clk domain.  The buttons are treated as active-low
// at the raw K_COL pins, because rows are driven low in independent-key mode.
reg [3:0] kcol_meta = 4'hF;
reg [3:0] kcol_sync = 4'hF;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        kcol_meta <= 4'hF;
        kcol_sync <= 4'hF;
    end
    else begin
        kcol_meta <= K_COL;
        kcol_sync <= kcol_meta;
    end
end

// Preserve the original project's logical button order:
// old BTN[0] was constrained to W14, which is K_COL[3] in the SWORD docs.
// Therefore BTN_RAW[0]=~K_COL[3], BTN_RAW[1]=~K_COL[2], etc.
wire [3:0] BTN_RAW = ~{kcol_sync[0], kcol_sync[1], kcol_sync[2], kcol_sync[3]};

wire [3:0] BTN_DB;

debounce D0(
    .clk(clk),
    .rst_n(rst_n),
    .key_in(BTN_RAW[0]),
    .key_out(BTN_DB[0])
);

debounce D1(
    .clk(clk),
    .rst_n(rst_n),
    .key_in(BTN_RAW[1]),
    .key_out(BTN_DB[1])
);

debounce D2(
    .clk(clk),
    .rst_n(rst_n),
    .key_in(BTN_RAW[2]),
    .key_out(BTN_DB[2])
);

debounce D3(
    .clk(clk),
    .rst_n(rst_n),
    .key_in(BTN_RAW[3]),
    .key_out(BTN_DB[3])
);

wire [7:0] led_logic;       // internal high-active LED/game state
wire [7:0] score;
wire [1:0] error_cnt;
wire [3:0] level;
wire game_over;

game_core U_GAME(
    .clk(clk),
    .rst_n(rst_n),
    .BTN(BTN_DB),
    .LED(led_logic),
    .score(score),
    .error_cnt(error_cnt),
    .level(level),
    .game_over(game_over)
);

// SWORD Arduino LED is common-anode / active-low.
assign LED = ~led_logic;

seg_driver U_SEG(
    .clk(clk),
    .rst_n(rst_n),
    .score(score),
    .error_cnt(error_cnt),
    .level(level),
    .game_over(game_over),
    .SEGMENT(SEGMENT),
    .AN(AN)
);

// VGA display
wire [11:0] rgb_real;
wire [8:0] y;
wire [9:0] x;
wire read_en_n;

vga_game_display U_VGA_DISPLAY(
    .x(x),
    .y(y),
    .read_en_n(read_en_n),
    .target_led(led_logic[3:0]),
    .score(score),
    .error_cnt(error_cnt),
    .level(level),
    .game_over(game_over),
    .rgb_real(rgb_real)
);

VGA_Driver U_VGA_DRIVER(
    .clk(clk),
    .rst_n(rst_n),
    .d_in(rgb_real),
    .row_addr(y),
    .col_addr(x),
    .rdn(read_en_n),
    .r(r),
    .g(g),
    .b(b),
    .hs(hs),
    .vs(vs)
);

// Unused serial LED / serial seven-seg interfaces: keep them disabled.
assign LED_CLK = 1'b0;
assign LED_CLR = 1'b1;
assign LED_DT  = 1'b0;
assign LED_EN  = 1'b0;

assign SEG_CLK = 1'b0;
assign SEG_CLR = 1'b1;
assign SEG_DT  = 1'b0;
assign SEG_EN  = 1'b0;

// Mark intentionally unused inputs so synthesis does not warn too much.
wire unused_inputs = &{1'b0, SW, ps2_clk, ps2_data};

endmodule
