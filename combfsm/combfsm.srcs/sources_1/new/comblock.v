`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2020 04:01:12 PM
// Design Name: 
// Module Name: comblock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module comblock(
 output  reg unlock,
    input in,
    input Clock,
    input Reset
    );
  reg current_state, next_state;
 parameter
  sx = 3'b0,
  s0 =3'b1,
  s01=3'b011,
  s011=3'b010,
  s0110=3'b100;
always @ (posedge Clock or negedge Reset) 
begin: STATE_MEMORY
 if (!Reset)
 current_state <=sx;
 else
 current_state<=next_state;
end


/* NEXT STATE LOG?C BLOCK)*/
always @(current_state )
 begin:Next_State_Logic
 case (current_state)
 sx: if (in==1'b0)
                next_state=s0 ;
                else next_state=current_state;
                
                  
s0:  if (in==1'b1)
    next_state= s01;
   else
     next_state=current_state;
 s01:
  if (in==1'b1)
    next_state= s011;
   else
     next_state=s0;
 s011:
  if (in==1'b1)
    next_state= sx;
   else
     next_state=s0110;
 
s0110: 
if (in==1'b1)
    next_state= s01;
   else
     next_state=s0;
default : next_state =sx; 
 
 endcase
end
/*output logic*/
always @ (current_state ) // moore machine
begin: OUTPUT_LOGIC
 case (current_state)
 s0110: unlock=1;
	 
 
    default :
               unlock=0;
     endcase 
end



    
endmodule
