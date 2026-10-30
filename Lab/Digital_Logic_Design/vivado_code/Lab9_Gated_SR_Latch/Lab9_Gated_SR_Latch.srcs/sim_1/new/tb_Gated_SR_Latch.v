`timescale 1ns / 1ps
module tb_Gated_SR_Latch;
  reg R;
  reg S;
  wire Q;
  wire Q_bar;

  Gated_SR_Latch uut (
    .R(R),
    .S(S),
    .Q(Q),
    .Q_bar(Q_bar)
  );

  initial begin
    R=1;S=1; #50;
    R=1;S=0; #50;
    R=1;S=1; #50;
    R=0;S=1; #50;
    R=1;S=1; #50;
    R=0;S=0; #50;
    R=1;S=1; #50;
    
    $stop;
  end
endmodule
