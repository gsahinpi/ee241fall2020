`timescale 1ns / 1ps

module counter(clock,reset,enable,count);
input clock,reset,enable;
output reg [3:0] count;
//reset is  synch to clock ie works only on the rising edge of the clock
always@(posedge clock)
    begin
        if (reset==1'b1) count<=0;
        else if (enable==1'b1) count<=count+1;
            
    end
endmodule
