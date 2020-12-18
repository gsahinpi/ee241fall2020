`timescale 1ns / 1ps
module modMCounter_tb;

localparam M = 12, N=4, period=20;

reg clk, reset;
wire complete_tick; 

// desired_count is read from file
// count is count provided by modMCounter.v
wire[N-1:0] count;
//reg[N-1:0] count;
//reg[N-1:0] desired_count;

reg[39:0] error_msg; // message = error

// [3:0] = 4 bit data
// [0:M-1] = 12 rows  in the file mod_m_counter_desired.txt
//reg[3:0] read_data [0:M-1];

//integer counter_data; // for saving counter-data on file
integer  i  = 0,total_cycle = 61; // used for ending the simulation after M cycle
//integer i  = 0, j = 0, total_cycle = M;
// unit under test
modMCounter #(.M(M), .N(N)) UUT (.clk(clk), .reset(reset), .complete_tick(complete_tick), .count(count));
//modmcounter2 #(.M(M), .N(N)) UUT (.Cnt(count),  .complete_tick(complete_tick),. Clock(clk), .Reset(reset));

// read the data from file
/*
always @(posedge clk)
begin 
    $readmemh("data.txt", read_data);
    if (reset)
        desired_count = 0;
    else 
    begin     
            desired_count = read_data[j];
            j = j+1;
    end    
end
*/
// open csv-file for writing
/*
initial
begin
	counter_data = $fopen("counter_output.csv"); // open file
end
*/
// note that sensitive list is omitted in always block
// therefore always-block run forever
// clock period = 2 ns
always 
begin
    clk = 1'b1; 
    #5; // high for 20 * timescale = 20 ns

    clk = 1'b0;
    #5; // low for 20 * timescale = 20 ns
end

// reset
initial 
begin 
	reset = 1;
	#(period);
	reset = 0;
end


// stop the simulation total_cycle and close the file
// i.e. store only total_cycle values in file
always @(posedge clk)
begin
    if (total_cycle == i) 
    begin
    	$stop;
    	//$fclose(counter_data);  // close the file
	end	
    i = i+1;
    if (i%15==0)
      reset=1;
      else
      reset=0;
end

// note that, the comparison is made at negative edge, 
// when all the transition are settled. 
// if we use 'posedge', then result will not be in correct form
/*always @(negedge clk)
begin
    if (desired_count == count)
        error_msg = "    ";
    else 
        error_msg = "error"; 
end*/
   initial begin
$display("\ti, \tcomplete_tick, count, reset");
$monitor("%d  \t%D            \t%D     \t%D ",i,complete_tick, count,reset);

end 
endmodule
