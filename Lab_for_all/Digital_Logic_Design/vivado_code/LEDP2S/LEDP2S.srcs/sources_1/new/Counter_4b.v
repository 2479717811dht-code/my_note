`timescale 1ns / 1ps

module Counter_4b(
    input wire SubMode, // =1: -, =0, +
    input wire En,
    input wire clk,
    output wire [3:0] num
    );
    reg oldEn;
    reg [3:0] rnum;
    assign num = rnum;
    initial begin
        oldEn = 0;
        rnum = 0;
    end
    always @(posedge clk) begin
        if(En & ~oldEn) begin
            oldEn <= 1;
            if(SubMode) rnum <= rnum - 1;
            else rnum <= rnum + 1;
        end
        else if(~En) begin
            oldEn <= En;
        end
    end
endmodule

