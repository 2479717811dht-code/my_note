`timescale 1ns / 1ps

module menu_rom(
    input clk,
    input [6:0] row,      // 0~127
    input [9:0] col,      // 0~639
    output reg [11:0] rgb
);

    // 640 * 128 = 81920 pixels
    reg [11:0] rom_memory [0:81919];

    wire [16:0] row_ext = {10'b0, row};
    wire [16:0] col_ext = {7'b0, col};
    wire [16:0] addr;

    // addr = row * 640 + col = row * (512 + 128) + col
    assign addr = (row_ext << 9) + (row_ext << 7) + col_ext;

    initial begin
        $readmemh("menu_data.mem", rom_memory);
    end

    always @(posedge clk) begin
        if (addr < 17'd81920)
            rgb <= rom_memory[addr];
        else
            rgb <= 12'h000;
    end

endmodule
