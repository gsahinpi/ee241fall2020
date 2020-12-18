`timescale 1ns / 1ps
 // defines for pulse counter
// load with 3 for four pulses
`define C_WIDTH 2
`define C_COUNT 3
// Counter1 - pulse counter
// cload - loads counter with C_COUNT
// cdec - decrements counter by one if not already zero
// cdone - signals when count has reached zero
module Counter1(clk, rst, cload, cdec, cdone) ;
parameter n=`C_WIDTH ;
input clk, rst, cload, cdec ;
output cdone ;
wire [n-1:0] count ;
reg [n-1:0] next_count ;
wire cdone ;
// state register
DFF #(n) state(clk, next_count, count) ;
// signal done
assign cdone = !(|count) ;
// next count logic
always@(rst or cload or cdec or cdone or count) begin
casex({rst, cload, cdec, cdone})
4'b1xxx: next_count = `C_WIDTH'b0 ;
4'b01xx: next_count = `C_COUNT ;
4'b0010: next_count = count - 1'b1 ;
4'b00x1: next_count = count ;
default: next_count = count ;
endcase
end
endmodule
