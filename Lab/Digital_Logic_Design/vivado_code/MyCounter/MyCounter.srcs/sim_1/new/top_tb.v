`timescale 1ns / 1ps
 
module top_tb();

  reg clk;
  wire [3:0] AN;
  wire [7:0] SEGMENT;
  wire BTNX4;
  
  top t1(
    .clk(clk), 
	.AN(AN),
	.SEGMENT(SEGMENT),
	.BTNX4(BTNX4)
  );
  
  initial begin
    clk = 0;
  end
  
  always begin
    #10 clk = ~clk;
   end
   
   initial begin
     #100000 $finish;
   end
endmodule