//  A testbench for Adder4b_tb
`timescale 1us/1ns

module Adder4b_tb;
    reg Ci;
    reg [3:0] A;
    reg [3:0] B;
    wire [3:0] S;
    wire Co;

  Adder4b Adder4b0 (
    .Ci(Ci),
    .A(A),
    .B(B),
    .S(S),
    .Co(Co)
  );

