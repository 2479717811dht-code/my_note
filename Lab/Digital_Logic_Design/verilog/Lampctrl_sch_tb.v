//  A testbench for Lampctrl_sch_tb
`timescale 1us/1ns

module Lampctrl_sch_tb;
    reg S1;
    reg S2;
    reg S3;
    wire F;

  Lampctrl_sch Lampctrl_sch0 (
    .S1(S1),
    .S2(S2),
    .S3(S3),
    .F(F)
  );

