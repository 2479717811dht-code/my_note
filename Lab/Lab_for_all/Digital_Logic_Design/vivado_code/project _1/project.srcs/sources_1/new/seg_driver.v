module seg_driver(
    input clk,

    input [7:0] score,
    input [1:0] error_cnt,
    input [3:0] level,
    input game_over,

    output reg [7:0] SEGMENT,
    output reg [3:0] AN
);

reg [15:0] scan_cnt = 0;

reg [3:0] digit;

always @(posedge clk)
    scan_cnt <= scan_cnt + 1;

always @(*) begin

    case(scan_cnt[15:14])

        2'b00:
        begin
            AN = 4'b1110;
            digit = score % 10;
        end

        2'b01:
        begin
            AN = 4'b1101;
            digit = (score/10)%10;
        end

        2'b10:
        begin
            AN = 4'b1011;
            digit = level;
        end

        2'b11:
        begin
            AN = 4'b0111;
            digit = error_cnt;
        end

    endcase

    case(digit)

        0: SEGMENT = 8'b11000000;
        1: SEGMENT = 8'b11111001;
        2: SEGMENT = 8'b10100100;
        3: SEGMENT = 8'b10110000;
        4: SEGMENT = 8'b10011001;
        5: SEGMENT = 8'b10010010;
        6: SEGMENT = 8'b10000010;
        7: SEGMENT = 8'b11111000;
        8: SEGMENT = 8'b10000000;
        9: SEGMENT = 8'b10010000;

        default:
            SEGMENT = 8'b11111111;

    endcase

end

endmodule