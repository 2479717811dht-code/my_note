//  A testbench for Mux4to1b4_tb
`timescale 1us/1ns

module Mux4to1b4_tb;
    reg [3:0] I0;
    reg [3:0] I1;
    reg [3:0] I2;
    reg [3:0] I3;
    reg [1:0] S;
    wire [3:0] O;

  Mux4to1b4 Mux4to1b40 (
    .I0(I0),
    .I1(I1),
    .I2(I2),
    .I3(I3),
    .S(S),
    .O(O)
  );

