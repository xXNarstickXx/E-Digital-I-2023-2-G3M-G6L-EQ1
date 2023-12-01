module servo2
(
  input clk_in,
  input vg,
  output reg clk_out
);

parameter SIZE = 19; /*2^19=524288, contiene a 500000*/
parameter LIMIT = 19'd500000; /*Limite = 25M/(1/20ms) = 500000 */
parameter dutymin=12500; /*25M*0.5ms=12500 (-	90°)*/ 
parameter dutymax=65000; /*25M*2.4ms=60000 (90°)*/

reg [SIZE-1:0] count = 0;
reg [SIZE-1:0] duty = 60000;
always@(posedge clk_in)
	begin
	  if(count == LIMIT)
		  begin
			count <= 0;
		  end
	  else
		  begin
			count <= count + 1;
		  end
/*	  if (rg==1)
		  begin
		    duty<=53500;
		  end
	  else if (vg==1)
	      begin
	        duty<=47000;
	      end
	  else if (ag==1)
	  	  begin
	        duty<=40500;
	      end			*/
	  if(vg==1)
	  	  begin
	        duty<=47000;
	      end
	  else
		  begin
			duty<=dutymax;
		  end
	  if (count < duty)
		  begin
			clk_out=1;
		  end
	  else
		  begin
			clk_out=0;
		  end
	end
endmodule

