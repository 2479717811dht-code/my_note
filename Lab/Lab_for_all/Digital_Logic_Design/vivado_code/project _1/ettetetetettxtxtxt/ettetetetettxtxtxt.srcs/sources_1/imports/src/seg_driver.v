`timescale 1ns / 1ps

module seg_driver(
    input  wire clk,
    input  wire rst_n,

    input  wire [7:0] score,
    input  wire [1:0] error_cnt,
    input  wire [3:0] level,
    input  wire game_over,

    output reg  [7:0] SEGMENT,  // active-low: {dp,g,f,e,d,c,b,a} in this project style
    output reg  [3:0] AN        // active-low digit enable
);

reg [15:0] scan_cnt;
reg [3:0] digit;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        scan_cnt <= 16'd0;
    else
        scan_cnt <= scan_cnt + 16'd1;
end

always @(*) begin
    case (scan_cnt[15:14])
        2'b00: begin
            AN = 4'b1110;
            digit = score % 10;
        end
        2'b01: begin
            AN = 4'b1101;
            digit = (score / 10) % 10;
        end
        2'b10: begin
            AN = 4'b1011;
            digit = level;
        end
        2'b11: begin
            AN = 4'b0111;
            digit = {2'b00, error_cnt};
        end
        default: begin
            AN = 4'b1111;
            digit = 4'd0;
        end
    endcase

    if (game_over && scan_cnt[15:14] == 2'b10) begin
        // crude "G" indication on one digit when game over
        SEGMENT = 8'b10000010;
    end
    else begin
        case (digit)
            4'd0: SEGMENT = 8'b11000000;
            4'd1: SEGMENT = 8'b11111001;
            4'd2: SEGMENT = 8'b10100100;
            4'd3: SEGMENT = 8'b10110000;
            4'd4: SEGMENT = 8'b10011001;
            4'd5: SEGMENT = 8'b10010010;
            4'd6: SEGMENT = 8'b10000010;
            4'd7: SEGMENT = 8'b11111000;
            4'd8: SEGMENT = 8'b10000000;
            4'd9: SEGMENT = 8'b10010000;
            default: SEGMENT = 8'b11111111;
        endcase
    end
end

endmodule
