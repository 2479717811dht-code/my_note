`timescale 1ns / 1ps

module sprite_rom(
    input [3:0] row,         // 行坐标 (0-15)
    input [3:0] col,         // 列坐标 (0-15)
    output reg [11:0] rgb    // 输出 12 位 RGB 颜色值
);

    reg [15:0] bitmap [0:15];

    // 初始化红心图案的十六进制像素点阵 (1代表红心像素，0代表透明背景)
    initial begin
        bitmap[0]  = 16'b0000000000000000;
        bitmap[1]  = 16'b0001110000111000;
        bitmap[2]  = 16'b0011111001111100;
        bitmap[3]  = 16'b0111111111111110;
        bitmap[4]  = 16'b0111111111111110;
        bitmap[5]  = 16'b0111111111111110;
        bitmap[6]  = 16'b0011111111111100;
        bitmap[7]  = 16'b0001111111111000;
        bitmap[8]  = 16'b0000111111110000;
        bitmap[9]  = 16'b0000011111100000;
        bitmap[10] = 16'b0000001111000000;
        bitmap[11] = 16'b0000000110000000;
        bitmap[12] = 16'b0000000000000000;
        bitmap[13] = 16'b0000000000000000;
        bitmap[14] = 16'b0000000000000000;
        bitmap[15] = 16'b0000000000000000;
    end

    always @(*) begin
        // 根据行列索引查表，1 吐出红色 (12'h00F)，0 吐出黑色背景 (12'h000)
        if (bitmap[row][4'd15 - col]) 
            rgb = 12'h00F; // 红色
        else
            rgb = 12'h000; // 黑色
    end
endmodule