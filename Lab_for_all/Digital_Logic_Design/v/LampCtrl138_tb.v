//  A testbench for LampCtrl138_tb
`timescale 1us/1ns

module LampCtrl138_tb;
    reg S1;
    reg S2;
    reg S3;
    wire F;

  LampCtrl138 LampCtrl1380 (
    .S1(S1),
    .S2(S2),
    .S3(S3),
    .F(F)
  );

