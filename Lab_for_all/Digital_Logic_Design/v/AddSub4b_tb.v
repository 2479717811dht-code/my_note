//  A testbench for AddSub4b_tb
`timescale 1us/1ns

module AddSub4b_tb;
    reg Ctrl;
    reg [3:0] A;
    reg [3:0] B;
    wire [3:0] S;
    wire Co;

  AddSub4b AddSub4b0 (
    .Ctrl(Ctrl),
    .A(A),
    .B(B),
    .S(S),
    .Co(Co)
  );

