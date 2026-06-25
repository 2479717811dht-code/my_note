`timescale 1ns / 1ps

module text_rom(
    input clk,
    input [7:0] row,      // 0~255. 0~127 = WIN, 128~255 = FAIL
    input [9:0] col,      // 0~639
    output reg [11:0] rgb
);

    // 640 * 256 = 163840 pixels
    reg [11:0] rom_memory [0:163839];

    wire [17:0] row_ext = {10'b0, row};
    wire [17:0] col_ext = {8'b0, col};
    wire [17:0] addr;

    // addr = row * 640 + col = row * (512 + 128) + col
    assign addr = (row_ext << 9) + (row_ext << 7) + col_ext;

    initial begin
        $readmemh("text_data.mem", rom_memory);
    end

    always @(posedge clk) begin
        if (addr < 18'd163840)
            rgb <= rom_memory[addr];
        else
            rgb <= 12'h000;
    end

endmodule
