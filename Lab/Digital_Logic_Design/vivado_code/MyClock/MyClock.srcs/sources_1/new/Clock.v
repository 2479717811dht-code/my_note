`timescale 1ns / 1ps
module ClockNumber0(
    input wire clk,
    input wire SW,
    output wire [31:0] Q
);
    wire [4:0] C;
    wire [5:0] clr;
    wire LD;
    wire nSW;
    Load_Gen L(.clk(clk),.btn_in(SW),.Load_out(LD));
    assign nSW=~SW;
    assign Q[31:24]=0;
    
    assign clr[0]=~(Q[3]&Q[1]),
           clr[1]=~(Q[6]&Q[5]),
           clr[2]=~(Q[11]&Q[9]),
           clr[3]=~(Q[14]&Q[13]),
           clr[4]=~((Q[19]&Q[17])|(Q[21]&Q[18])),
           clr[5]=~(Q[21]&Q[18]);
           
    assign C[0]=Q[3]&Q[0],
           C[1]=Q[6]&Q[4]&C[0],
           C[2]=Q[11]&Q[8]&C[1],
           C[3]=Q[14]&Q[12]&C[2],
           C[4]=Q[19]&Q[16]&C[3];
    
    My74LS161 m0(.clk(clk),.CR(clr[0]),.LD(nSW),.CTP(1),.CTT(1),.D(4'b0000),.Q(Q[3:0])),
              m1(.clk(clk),.CR(clr[1]),.LD(nSW),.CTP(C[0]),.CTT(1),.D(4'b0011),.Q(Q[7:4])),
              m2(.clk(clk),.CR(clr[2]),.LD(nSW),.CTP(C[1]),.CTT(1),.D(4'b1000),.Q(Q[11:8])),
              m3(.clk(clk),.CR(clr[3]),.LD(nSW),.CTP(C[2]),.CTT(1),.D(4'b0101),.Q(Q[15:12])),
              m4(.clk(clk),.CR(clr[4]),.LD(nSW),.CTP(C[3]),.CTT(1),.D(4'b0011),.Q(Q[19:16])),
              m5(.clk(clk),.CR(clr[5]),.LD(nSW),.CTP(C[4]),.CTT(1),.D(4'b0010),.Q(Q[23:20]));
endmodule