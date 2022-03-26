`timescale 1ns / 1ps
//simplest N bit Dflip flop without reset
module DFF(clk, in, out) ;
parameter n = 1; // width
input clk ;
input [n-1:0] in ;
output [n-1:0] out ;
reg [n-1:0] out ;
always @(posedge clk)
out <= in ;
endmodule
