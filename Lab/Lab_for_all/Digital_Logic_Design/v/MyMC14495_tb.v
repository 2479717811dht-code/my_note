//  A testbench for MyMC14495_tb
`timescale 1us/1ns

module MyMC14495_tb;
    reg point;
    reg LE;
    reg D0;
    reg D1;
    reg D2;
    reg D3;
    wire g;
    wire f;
    wire e;
    wire d;
    wire c;
    wire b;
    wire a;
    wire p;

  MyMC14495 MyMC144950 (
    .point(point),
    .LE(LE),
    .D0(D0),
    .D1(D1),
    .D2(D2),
    .D3(D3),
    .g(g),
    .f(f),
    .e(e),
    .d(d),
    .c(c),
    .b(b),
    .a(a),
    .p(p)
  );

    reg [13:0] patterns[0:17];
    integer i;

    initial begin
      patterns[0] = 14'b0_0_0_0_0_0_x_x_x_x_x_x_x_x;
      patterns[1] = 14'b0_0_0_1_0_0_x_x_x_x_x_x_x_x;
      patterns[2] = 14'b0_0_1_0_0_0_x_x_x_x_x_x_x_x;
      patterns[3] = 14'b0_0_1_1_0_0_x_x_x_x_x_x_x_x;
      patterns[4] = 14'b0_1_0_0_0_0_x_x_x_x_x_x_x_x;
      patterns[5] = 14'b0_1_0_1_0_0_x_x_x_x_x_x_x_x;
      patterns[6] = 14'b0_1_1_0_0_0_x_x_x_x_x_x_x_x;
      patterns[7] = 14'b0_1_1_1_0_0_x_x_x_x_x_x_x_x;
      patterns[8] = 14'b1_0_0_0_0_0_x_x_x_x_x_x_x_x;
      patterns[9] = 14'b1_0_0_1_0_0_x_x_x_x_x_x_x_x;
      patterns[10] = 14'b1_0_1_0_0_0_x_x_x_x_x_x_x_x;
      patterns[11] = 14'b1_0_1_1_0_0_x_x_x_x_x_x_x_x;
      patterns[12] = 14'b1_1_0_0_0_0_x_x_x_x_x_x_x_x;
      patterns[13] = 14'b1_1_0_1_0_0_x_x_x_x_x_x_x_x;
      patterns[14] = 14'b1_1_1_0_0_0_x_x_x_x_x_x_x_x;
      patterns[15] = 14'b1_1_1_1_0_0_x_x_x_x_x_x_x_x;
      patterns[16] = 14'b0_0_0_0_0_1_x_x_x_x_x_x_x_x;
      patterns[17] = 14'b0_0_0_1_1_0_x_x_x_x_x_x_x_x;

      for (i = 0; i < 18; i = i + 1)
      begin
        D3 = patterns[i][13];
        D2 = patterns[i][12];
        D1 = patterns[i][11];
        D0 = patterns[i][10];
        point = patterns[i][9];
        LE = patterns[i][8];
        #10;
        if (patterns[i][7] !== 1'hx)
        begin
          if (a !== patterns[i][7])
          begin
            $display("%d:a: (assertion error). Expected %h, found %h", i, patterns[i][7], a);
            $finish;
          end
        end
        if (patterns[i][6] !== 1'hx)
        begin
          if (b !== patterns[i][6])
          begin
            $display("%d:b: (assertion error). Expected %h, found %h", i, patterns[i][6], b);
            $finish;
          end
        end
        if (patterns[i][5] !== 1'hx)
        begin
          if (c !== patterns[i][5])
          begin
            $display("%d:c: (assertion error). Expected %h, found %h", i, patterns[i][5], c);
            $finish;
          end
        end
        if (patterns[i][4] !== 1'hx)
        begin
          if (d !== patterns[i][4])
          begin
            $display("%d:d: (assertion error). Expected %h, found %h", i, patterns[i][4], d);
            $finish;
          end
        end
        if (patterns[i][3] !== 1'hx)
        begin
          if (e !== patterns[i][3])
          begin
            $display("%d:e: (assertion error). Expected %h, found %h", i, patterns[i][3], e);
            $finish;
          end
        end
        if (patterns[i][2] !== 1'hx)
        begin
          if (f !== patterns[i][2])
          begin
            $display("%d:f: (assertion error). Expected %h, found %h", i, patterns[i][2], f);
            $finish;
          end
        end
        if (patterns[i][1] !== 1'hx)
        begin
          if (g !== patterns[i][1])
          begin
            $display("%d:g: (assertion error). Expected %h, found %h", i, patterns[i][1], g);
            $finish;
          end
        end
        if (patterns[i][0] !== 1'hx)
        begin
          if (p !== patterns[i][0])
          begin
            $display("%d:p: (assertion error). Expected %h, found %h", i, patterns[i][0], p);
            $finish;
          end
        end
      end

      $display("All tests passed.");
    end
    endmodule
