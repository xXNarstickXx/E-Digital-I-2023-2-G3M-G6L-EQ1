module clkinult (
  input clk_in,
  output reg clk_out = 0
);

parameter SIZE = 20; 
parameter LIMIT = 20'd750000;
parameter duty=250000;

reg [SIZE-1:0] count = 0;

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
