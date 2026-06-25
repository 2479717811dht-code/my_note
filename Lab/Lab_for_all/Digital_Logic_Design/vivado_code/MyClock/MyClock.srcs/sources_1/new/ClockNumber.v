`timescale 1ns / 1ps
module ClockNumber(
    input wire clk,
    input wire SW,
    output reg [31:0] Q
);
reg [7:0] hour   = 8'h23;
    reg [7:0] minute = 8'h58;
    reg [7:0] second = 8'h30;

    always @(posedge clk) begin
        if (SW) begin
            hour <= {4'd2, 4'd3};
            minute <= {4'd5, 4'd8};
            second <= {4'd3, 4'd0};
        end
        else begin
            // 秒
            second[3:0] <= second[3:0] + 1;
            if (second[3:0] == 4'd9) begin
                second[3:0] <= 0;
                second[7:4] <= second[7:4] + 1;
                if (second[7:4] == 4'd5) begin
                    second[7:4] <= 0;
                    // 分
                    minute[3:0] <= minute[3:0] + 1;
                    if (minute[3:0] == 4'd9) begin
                        minute[3:0] <= 0;
                        minute[7:4] <= minute[7:4] + 1;
                        if (minute[7:4] == 4'd5) begin
                            minute[7:4] <= 0;
                            // 时
                            hour[3:0] <= hour[3:0] + 1;
                            if ((hour[7:4] == 4'd2) && (hour[3:0] == 4'd3)) begin
                                hour <= 8'd0;
                            end else if (hour[3:0] == 4'd9) begin
                                hour[3:0] <= 0;
                                hour[7:4] <= hour[7:4] + 1;
                            end
                        end
                    end
                end
            end
        end
        Q <= {8'd0, hour, minute, second}; // 输出拼接
    end
endmodule