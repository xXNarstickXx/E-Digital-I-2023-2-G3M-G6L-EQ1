 module Control (
 input [22:0] f_1,
 input [22:0] f_2,
 output led1,
 output led2
 );
 
always@(f_1, f_2)
begin	
	if ( f_1 < f_2)
		begin
			led1 = 1'b0;
			led2 = 1'b1;
		end
	else 
		begin
			led1 = 1'b1;
			led2 = 1'b0;
		end

end
endmodule
