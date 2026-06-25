module Top #(
    parameter CLK_DIV_100MS = 5_000_000,
    parameter SCAN_DIV = 100_000
) (
    input  wire clk_100m,
input  wire [1:0] SW,
    output wire [3:0] AN,
    output wire [7:0] SEGMENT,
    output wire [7:0] LED 
);

    wire clk_100ms;
    wire clk_scan;
    wire [15:0] cnt;
    wire Rc; 

    clk_100ms #(.DIV(CLK_DIV_100MS)) u_clk_100ms (
        .clk_in (clk_100m),
        .clk_out(clk_100ms)
    );
    clk_100ms #(.DIV(SCAN_DIV)) u_clk_scan (
        .clk_in (clk_100m),
        .clk_out(clk_scan)
    );

    RevCounter u_counter (
        .clk (clk_100ms),
        .s   (SW),
        .cnt (cnt),
        .Rc  (Rc)
    );

    reg [1:0] scan_cnt; 
    always @(posedge clk_scan) begin
        scan_cnt <= scan_cnt + 1'b1;
    end

    // 这里端口名改为 HEXS！！！
    DispNum u_disp (
        .HEXS    (cnt),
        .point   (4'b0000), 
        .LES     (4'b0000),
        .scan    (scan_cnt),
        .AN      (AN),
        .SEGMENT (SEGMENT) 
    );

    assign LED[0] = Rc;
    assign LED[7:1] = 7'b0;

endmodule