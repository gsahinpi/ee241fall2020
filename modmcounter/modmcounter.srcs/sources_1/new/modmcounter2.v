`timescale 1ns / 1ps

module modmcounter2
#(
    parameter M = 5, // count from 0 to M-1
                 N = 3 // N bits required to count upto M i.e. 2**N >= M
)
(
    output reg [N-1:0] Cnt, output reg  complete_tick, input wire Clock, input wire Reset 
);


always @ (posedge Clock or negedge Reset)
    begin
        if (!Reset)
            Cnt<=0;
        else
            begin
                Cnt<=Cnt+1;
                    if (Cnt==M-1)
                        begin
                            Cnt<=0;
                            complete_tick<=1;
                        end
                     else
                         complete_tick<=0;                            
                                     
            end
    
    end

endmodule
