`timescale 1ns / 1ps
module tb_Real_Gated_SR_Latch;
    reg C;
    reg R;
    reg S;
    wire Q;
    wire Q_bar;

    Real_Gated_SR_Latch uut (
        .C(C),
        .R(R),
        .S(S),
        .Q(Q),
        .Q_bar(Q_bar)
    );

    initial begin

        C = 1; R = 0; S = 0;
        #50;

        S = 0; 
        R = 1; 
        #50;

        S = 0; 
        R = 0; 
        #50;

        R = 0;
        S = 1; 
        #50;

        S = 0; 
        R = 0; 
        #50;
        
        S = 1; 
        R = 1; 
        #50;
        
        S = 0; 
        R = 0; 
        #50;

        C = 0; R = 0; S = 0;
        #50;

        S = 0; 
        R = 1; 
        #50;

        S = 0; 
        R = 0; 
        #50;

        R = 0;
        S = 1; 
        #50;

        S = 0; 
        R = 0; 
        #50;
        
        S = 1; 
        R = 1; 
        #50;
        
        S = 0; 
        R = 0; 
        #50;

        $stop;
    end
endmodule