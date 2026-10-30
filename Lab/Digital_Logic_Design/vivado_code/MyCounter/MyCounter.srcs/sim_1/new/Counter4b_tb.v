`timescale 1ns / 1ps

module Counter4b_tb();

  reg clk;
  wire [3:0] out;
  wire rc;
  
  counter_4bit c1(
    .clk(clk),
    .QA(out[3]),
    .QB(out[2]),
    .QC(out[1]),
    .QD(out[0]),
    .RC(rc)
  );
  
  initial begin
    clk = 0;
  end
  
  always begin
    #10 clk = ~clk;
   end
   
   initial begin
     #800 $finish;
   end
endmodule