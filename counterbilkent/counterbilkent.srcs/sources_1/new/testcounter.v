`timescale 1ns / 1ps
/*
First step of any testbench creation is building a dummy template 
which basically declares inputs to DUT as reg and outputs from DUT as wire,
 then instantiates the DUT .
  Note that there is no port list for the test bench.
*/

module testcounter;
 reg clk, reset, enable; //inputs to DUT as reg
 wire [3:0] count; //outputs from DUT as wire
      
    counter DUT ( 
     .clock    (clk), 
    .reset  (reset), 
     .enable (enable), 
     .count  (count) 
   ); 
 /*
 Next step would be to add clock generator logic. 
 Before we add a clock generator we need to drive all the inputs to DUT 
 to some known state .
 
 */
 initial 
    begin 
      clk = 0; 
      reset = 0; 
      enable = 0; 
      #20 enable=1;
      #20 enable=0;
      #20 reset=1;
      #10 reset =0;
      enable=1;
      reset=1;
      reset=0;
       
    end 
      
    always 
      begin  
       #5  clk =  ! clk; //5 units duty cycle %50
       end
initial
  begin
      $display("\ttime,\tclk,\treset,\tenable,\tcount"); 
      $monitor("%d,\t%b,\t%b,\t%b,\t%d",$time, clk,reset,enable,count); 
    end 
     
    initial
     begin 
    #300  $finish;
    end
/*
$display is used for printing text or variables to stdout (screen),
 \t is for inserting tabs. The syntax is the same as for printf C language.
 $monitor in the second line is a bit different:
  $monitor keeps track of changes to the variables that are in the list (clk, reset, enable, count). Whenever any of them changes, it prints their value, in the respective radix specified.

 	 	
space.gif

$finish is used for terminating the simulation after #100 time units 
(note: all the initial, always blocks start execution at time 0).
*/            
endmodule
