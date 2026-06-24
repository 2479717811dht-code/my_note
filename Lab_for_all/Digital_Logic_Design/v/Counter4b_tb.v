//  A testbench for Counter4b_tb
`timescale 1us/1ns

module Counter4b_tb;
    reg clk;
    wire RC;
    wire QA;
    wire QB;
    wire QC;
    wire QD;

  Counter4b Counter4b0 (
    .clk(clk),
    .RC(RC),
    .QA(QA),
    .QB(QB),
    .QC(QC),
    .QD(QD)
  );

