module Gated_SR_Latch (
  input R,
  input S,
  output Q,
  output Q_bar
);
  wire Q_temp;
  wire Q_bar_temp;
  assign Q_temp = ~ (R & Q_bar_temp);
  assign Q_bar_temp = ~ (Q_temp & S);
  assign Q = Q_bar_temp;
  assign Q_bar = Q_temp;
endmodule