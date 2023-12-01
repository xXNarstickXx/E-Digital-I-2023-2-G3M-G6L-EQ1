

/* count = (clk_in / clk_out) */
/* Ejemplo 1 */
/* count = 25E6 = 25000000 = (25E6 Mhz)/(1 Hz) */
/* SIZE = 2^25 = 33.5E6 lo contiene */
/* Ejemplo 2 */
/* count = (50E6 Mhz)/(1 Hz) = 50E6 = 50000000 */
/* SIZE = 2^26 = 67.5E6 lo contiene */
/* Configuración a 1 Hz */
/* count = (12E6 Mhz)/(1 Hz) = 12E6 = 12000000 */
/* SIZE = 2^24 = 16.777E6 lo contiene */

/*Lattice ice40 funciona a 25MHz*/

module servo 
(
  input clk_in,
  input rg,
  output reg clk_out
);

parameter SIZE = 19; /*2^19=524288, contiene a 500000*/
parameter LIMIT = 19'd500000; /*Limite = 25M/(1/20ms) = 500000 */
parameter dutymin=12500; /*25M*0.5ms=12500 (-	90°)*/ 
parameter dutymax=60000; /*25M*2.4ms=60000 (90°)*/

reg [SIZE-1:0] count = 0;
reg [SIZE-1:0] duty = 12500;
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
		    duty<=19000;
		  end
	  else if (vg==1)
	      begin
	        duty<=23500;
	      end
	  else if (ag==1)
	  	  begin
	        duty<=28000;
	      end					*/
	  if(rg==1)
	  	  begin
	        duty<=23500;
	      end
	  else
		  begin
			duty<=dutymin;
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

/*Dutymin = 25000*/

/*Dutymax = 120000*/




