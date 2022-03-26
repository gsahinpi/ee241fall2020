`timescale 1ns / 1ps

/*
First step of any testbench creation is building a dummy template 
which basically declares inputs to DUT as reg and outputs from DUT as wire,
 then instantiates the DUT .
  Note that there is no port list for the test bench.
*/

module testtimer;
reg Clk,Rst,Tload,Tsel;
wire Done;

Timer1   dut(.clk(Clk),.rst(Rst), .tload(Tload), .tsel(Tsel),. done(Done));

/*
 Next step would be to add clock generator logic. 
 Before we add a clock generator we need to drive all the inputs to DUT 
 to some known state .
 
 */
 initial
    begin
    Clk=0;
    Rst=0;
    Tload=0;
    Tsel=0;
#10 Tload=1; //time=10
#10 Tload=0; //time=20
#70 Tload=1;Tsel=1;//time=90
#10 Tload=0;//time =100


    
    
    
    
    end
 always 
      begin  
       #5  Clk =  ! Clk; //5 units duty cycle %50
       end
       
initial
  begin
      $display("\ttime,\tclk,\treset,\tload,\tsel \tdone"); 
      $monitor("%d,\t%b,\t%b,\t%b,\t%b  %b",$time, Clk,Rst,Tload,Tsel,Done); 
    end 
     
initial
  begin 
    #300  $finish;
  end 


endmodule
