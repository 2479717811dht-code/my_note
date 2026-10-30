`timescale 1ns / 1ps

module bg_rom(
    input clk,
    input [8:0] row,      // 0~479
    input [9:0] col,      // 0~639
    output reg [11:0] rgb
);

    // 640 * 480 = 307200 pixels
    reg [11:0] rom_memory [0:307199];

    wire [18:0] row_ext = {10'b0, row};
    wire [18:0] col_ext = {9'b0, col};
    wire [18:0] addr;

    // addr = row * 640 + col = row * (512 + 128) + col
    assign addr = (row_ext << 9) + (row_ext << 7) + col_ext;

    initial begin
        $readmemh("bg_data.mem", rom_memory);
    end

    always @(posedge clk) begin
        if (addr < 19'd307200)
            rgb <= rom_memory[addr];
        else
            rgb <= 12'h000;
    end

endmodule
