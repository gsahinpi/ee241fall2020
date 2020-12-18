`timescale 1ns / 1ps
module modMCounter
#(
    parameter M = 5, // count from 0 to M-1
                 N = 3 // N bits required to count upto M i.e. 2**N >= M
)
(
    input wire clk, reset, 
    output wire complete_tick, 
    output wire[N-1:0] count
);

reg[N-1:0] count_reg;
wire[N-1:0] count_next;

always @(posedge clk, posedge reset)
begin
    if (reset == 1)
        count_reg <= 0;
    else
        count_reg <= count_next;
end

// set count_next to 0 when maximum count is reached i.e. (M-1)
// otherwise increase the count
assign count_next = (count_reg == M-1) ? 0 : count_reg + 1 ;

//Generate 'tick' on each maximum count
assign complete_tick = (count_reg == M-1) ? 1 : 0;

assign count = count_reg; // assign count to output port 

endmodule