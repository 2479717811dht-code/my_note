`timescale 1ns / 1ps
module RevCounter (
    input  wire clk,
    input  wire s, 
    output wire [15:0] cnt, 
    output wire Rc
);
    reg [15:0] count;
    assign cnt = count;
    assign Rc = (s && (count == 16'hFFFF)) || (~s && (count == 16'h0000));

    always @(posedge clk) begin
        if (s)
            count <= count + 1'b1;
        else
            count <= count - 1'b1;
    end
    
    initial count = 16'd0;
endmodule