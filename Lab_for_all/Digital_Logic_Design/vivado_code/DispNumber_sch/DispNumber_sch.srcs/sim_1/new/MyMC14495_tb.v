`timescale 1ns / 1ps
module MyMC14495_tb;
    reg D3,D2,D1,D0,LE,point;
    wire a,b,c,d,e,f,g,p;
    
    MyMC14495 uut(
        .D3(D3),.D2(D2),.D1(D1),.D0(D0),
        .LE(LE),.point(point),
        .a(a),.b(b),.c(c),.d(d),.e(e),.f(f),.g(g),.p(p)
    );
    
    integer i;
    initial begin
        D3=0;D2=0;D1=0;D0=0; LE=0; point=0;
        for(i=0;i<=15;i=i+1) begin
            #50;
            {D3,D2,D1,D0}=i;
            point=i;
        end
        #50; LE=1;
        #100;
        $stop;
    end
endmodule