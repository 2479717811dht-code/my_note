module CreateNumber(
    input wire [3:0] btn,
    input wire [3:0] sw,
    output reg [15:0] num
    );
    wire [3:0] A,B,C,D;
    wire co1,co2,co3,co4;
    
    initial num <= 16'b0000_0000_0000_0000; // display "AbCd"
    
    AddSub4b a1 (.A(num[3:0]), .B(4'b1), .Ctrl(sw[0]), .S(A), .Co(co1));
    AddSub4b a2 (.A(num[7:4]), .B(4'b1), .Ctrl(sw[1]), .S(B), .Co(co2));
    AddSub4b a3 (.A(num[11:8]), .B(4'b1), .Ctrl(sw[2]), .S(C), .Co(co3));
    AddSub4b a4 (.A(num[15:12]), .B(4'b1), .Ctrl(sw[3]), .S(D), .Co(co4));
    
    always@(posedge btn[3]) num[ 3: 0]<= A;
    always@(posedge btn[2]) num[ 7: 4]<= B;
    always@(posedge btn[1]) num[ 11: 8]<= C;
    always@(posedge btn[0]) num[ 15: 12]<= D;
    
endmodule