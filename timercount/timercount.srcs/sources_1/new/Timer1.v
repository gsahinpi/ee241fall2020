`timescale 1ns / 1ps
/// define time intervals
// load 5 for 6-cycle interval 5 to 0.
//3 for 4 ccle
`define T_WIDTH 3 //how many bits do we need 
`define T_ON 3'd5
`define T_OFF 3'd3
// Timer 1 - reset to done state. Load time when tload is asserted
// Load with T_ON if tsel, otherwise T_OFF. If not being loaded or
// reset, timer counts down each cycle. Done is asserted and timing
// stops when counter reaches 0.
module Timer1(clk, rst, tload, tsel, done) ;
parameter n=`T_WIDTH ;
input clk, rst, tload, tsel ;
output done ;
wire [n-1:0] count ;
//reg [n-1:0] count ;
reg [n-1:0] next_count ;
wire done ;
//reg done ;
// state register
DFF #(n) state(clk, next_count, count) ;
//module DFF(clk, in, out) ;
// signal done
assign done = !(|count) ;//nor all bits and negate 0nly 00-> 1

/*always @ ( count or done)
begin
if (count  == 0 )done=1;
else done =0;
end
*/
// next count logic
always@(rst or tload or tsel or done or count) begin
casex({rst, tload, tsel, done})
4'b1xxx: next_count = `T_WIDTH'b0 ;
4'b011x: next_count = `T_ON ;//start value for countdown= 5
4'b010x: next_count = `T_OFF ;//start value for count down=3
4'b00x0: next_count = count - 1'b1 ;//count down if not rst,load or done  
4'b00x1: next_count = count ;//while done keep the count same 0
default: next_count = count ;
endcase
end
endmodule

