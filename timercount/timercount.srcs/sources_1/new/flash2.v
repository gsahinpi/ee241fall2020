`timescale 1ns / 1ps
// defines for doubly factored states
`define XWIDTH 2
`define X_OFF 2'b00
`define X_FLASH 2'b01
`define X_SPACE 2'b10
module Flash2(clk, rst, in, out) ;
input clk, rst, in ; // in triggers start of flash sequence
output out ; // out drives LED
reg out ; // output
wire [`XWIDTH-1:0] state, next ; // current state
reg [`XWIDTH-1:0] next1 ; // next state without reset
reg tload, tsel, cload, cdec ; // timer and countr inputs
wire tdone, cdone ; // timer and counter outputs
// instantiate state register
DFF #(`XWIDTH) state_reg(clk, next, state) ;
// instantiate timer and counter
Timer1 timer(clk, rst, tload, tsel, tdone) ;
Counter1 counter(clk, rst, cload, cdec, cdone) ;
always @(state or rst or in or tdone or cdone) begin
case(state)
`X_OFF: {out, tload, tsel, cload, cdec, next1} =
{1'b0, 1'b1, 1'b1, 1'b1, 1'b0,
in ? `X_FLASH : `X_OFF } ;// if in ==1 next1 is xflash else xoff
`X_FLASH:{out, tload, tsel, cload, cdec, next1} =
{1'b1, tdone, 1'b0, 1'b0, 1'b0,
tdone ? (cdone ? `X_OFF : `X_SPACE) : `X_FLASH } ;
`X_SPACE:{out, tload, tsel, cload, cdec, next1} =
{1'b0, tdone, 1'b1, 1'b0, tdone,
tdone ? `X_FLASH : `X_SPACE } ;
default:{out, tload, tsel, cload, cdec, next1} =
{1'b0, tdone, 1'b1, 1'b0, tdone, tdone ? `X_FLASH : `X_SPACE } ;
endcase
end
assign next = rst ? `X_OFF : next1 ;
endmodule
    

