`timescale 1ns / 1ps

module light_one_tb;
    reg S1;
    reg S2;
    reg S3;
    wire F;

    light_one uut (
        .S1(S1),
        .S2(S2),
        .S3(S3),
        .F(F)
    );

    initial begin
        S1 = 0; S2 = 0; S3 = 0; #10;
        S1 = 0; S2 = 0; S3 = 1; #10;
        S1 = 0; S2 = 1; S3 = 0; #10;
        S1 = 0; S2 = 1; S3 = 1; #10;
        S1 = 1; S2 = 0; S3 = 0; #10;
        S1 = 1; S2 = 0; S3 = 1; #10;
        S1 = 1; S2 = 1; S3 = 0; #10;
        S1 = 1; S2 = 1; S3 = 1; #10;
        $finish;
    end
endmodule