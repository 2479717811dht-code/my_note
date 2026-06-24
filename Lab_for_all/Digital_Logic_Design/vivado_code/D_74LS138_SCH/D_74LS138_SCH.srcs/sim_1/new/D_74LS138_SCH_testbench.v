`timescale 1ns / 1ps

module D_74LS138_SCH_testbench();

    reg A, B, C, G, G2A, G2B;
    wire [7:0] Y;
    
    D_74LS138 uut (
        .A(A), .B(B), .C(C),
        .G(G), .G2A(G2A), .G2B(G2B),
        .Y(Y)
    );
    
    integer i;
    initial begin
        A = 0; B = 0; C = 0;
        G = 1; G2A = 0; G2B = 0;
        #50;
        
        for (i=0; i<=7; i=i+1) begin
            {A,B,C} = i;
            #50;
        end
        
        G = 0; G2A = 0; G2B = 0;
        #50;
        
        G = 1; G2A = 1; G2B = 0;
        #50;
        
        G = 1; G2A = 0; G2B = 1;
        #50;
        
        $finish;
    end

endmodule
