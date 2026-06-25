`timescale 1ns / 1ps

module LampCtrl138_testbench();

    reg S1, S2, S3;
    wire F;
    
    LampCtrl138 uut (
        .S1(S1), .S2(S2), .S3(S3),
        .F(F)
    );
    
    integer i;
    initial begin
        for (i = 0; i <= 7; i = i + 1) begin
            {S1, S2, S3} = i;
            #50;
        end
        $finish;
    end

endmodule
