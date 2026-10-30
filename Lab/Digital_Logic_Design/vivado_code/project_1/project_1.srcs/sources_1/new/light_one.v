`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/22 15:31:30
// Design Name: 
// Module Name: light_one
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
module light_one(
    input wire clk,
    input wire S1,
    input wire S2,
    input wire S3,
    output wire F
);
    assign F = S1 ^ S2 ^S3;
endmodule
