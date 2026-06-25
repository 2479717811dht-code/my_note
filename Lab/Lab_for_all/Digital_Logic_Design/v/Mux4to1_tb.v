//  A testbench for Mux4to1_tb
`timescale 1us/1ns

module Mux4to1_tb;
    reg [1:0] S;
    reg [3:0] I;
    wire O;

  Mux4to1 Mux4to10 (
    .S(S),
    .I(I),
    .O(O)
  );

