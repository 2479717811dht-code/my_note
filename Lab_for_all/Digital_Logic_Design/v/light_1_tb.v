//  A testbench for light_1_tb
`timescale 1us/1ns

module light_1_tb;
    reg S1;
    reg S2;
    reg S3;
    wire F;

  light_1 light_10 (
    .S1(S1),
    .S2(S2),
    .S3(S3),
    .F(F)
  );

