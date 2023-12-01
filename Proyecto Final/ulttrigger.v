module ulttrigger 
(
	input start,
	input clk_in,
	output reg pulse=0
);
 
 // Se ubica como tiempo LIMIT 1ms
parameter SIZE = 8; /*2^19=256, contiene a 250                           Se relacionan       */
parameter LIMIT = 8'd250; /*Limite = 25M/(1/10us) = 250                                      */

reg [SIZE-1:0] count = 0;

always@(posedge clk_in or posedge start)
	begin
		if(start==1)
			begin
				count=0;
			end
		else if(count<LIMIT)
			begin
				count=count+1;
				pulse=1;
			end
		else
			begin
				pulse=0;
			end
	end
endmodule
