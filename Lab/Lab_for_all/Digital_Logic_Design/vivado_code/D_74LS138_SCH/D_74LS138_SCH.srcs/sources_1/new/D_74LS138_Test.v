module D_74LS138_Test(
    input S1,
    input S2,
    input S3,
    input S4,
    input S5,
    input S6,
    output [7:0] LED
    );
    
    D_74LS138 D1 (
    .A(S3),
    .B(S2),
    .C(S1),
    .G(S4),
    .G2A(S5),
    .G2B(S6),
    .Y(LED)
    );    
endmodule

