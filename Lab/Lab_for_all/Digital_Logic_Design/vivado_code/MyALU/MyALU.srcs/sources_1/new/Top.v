module Top (
    input wire clk,
    input wire [15:0] SW,
    input wire [3:0] BTN,
    output wire [3:0] AN,
    output wire [7:0] SEGMENT,
    output wire BTNX4
);

    wire [15:0] num;
    wire [3:0] C;
    wire Co;
    wire [31:0] clk_div;
    wire [15:0] disp_hexs;
    wire btn2_db, btn3_db;

    assign disp_hexs[15:12] = num[3:0];
    assign disp_hexs[11:8]  = num[7:4];
    assign disp_hexs[7:4]   = {3'b000, Co};
    assign disp_hexs[3:0]   = C;

    clkdiv c1 (
        .clk(clk),
        .rst(1'b0),
        .clk_div(clk_div)
    );

    pbdebounce db3 (
        .clk_1ms(clk_div[17]),
        .button(BTN[3]),
        .pbreg(btn3_db)
    );
    pbdebounce db2 (
        .clk_1ms(clk_div[17]),
        .button(BTN[2]),
        .pbreg(btn2_db)
    );

    CreateNumber m3 (
        .btn({btn3_db, btn2_db, 1'b0, 1'b0}),
        .sw({SW[1], SW[0], 2'b00}),
        .num(num)
    );

    MyALU m5 (
        .S(SW[15:14]),
        .A(num[3:0]),
        .B(num[7:4]),
        .Co(Co),
        .C(C)
    );

    DispNum d0 (
        .scan(clk_div[18:17]),
        .HEXS(disp_hexs),
        .LES(4'b0),
        .point(4'b0),
        .AN(AN),
        .SEGMENT(SEGMENT)
    );

    assign BTNX4 = 1'b0;
endmodule
