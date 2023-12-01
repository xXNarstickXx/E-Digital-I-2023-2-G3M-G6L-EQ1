module ultactuador(
	input [19:0]count,
	input laser,
	output reg rled,
	output reg vled,
	output reg aled,
	output reg xled
	
);
//Sensor ubicado a 25cm de la banda
parameter L1=20'd23000; //Para cajas entre 15cm (16000 ciclos) (rojo)
parameter L1m=20'd14000;
parameter L2=20'd30500; //Para cajas entre 10cm (22000 ciclos) (verde)
parameter L2m=20'd23500;
parameter L3=20'd38000; //Para cajas entre 5cm (30000 ciclos) (amarillo)
parameter L3m=20'd31000;

always@(posedge laser)
	begin
		if(count<L3)
			begin
				if(count<L1 && count>L1m) 
					begin 
						rled = 1;
						vled = 0;
						aled = 0;
						xled = 0;
					end
				else if(count<L2 && count>L2m)
					begin
						rled = 0;
						vled = 1;
						aled = 0;
						xled = 0;
					end
				else if(count<L3 && count>L3m)
					begin
						rled = 0;
						vled = 0;
						aled = 1;
						xled = 0;
					end
				else
					begin
						rled = 0;
						vled = 0;
						aled = 0;
						xled = 0;
					end
			end
		else
			begin
				rled = 0;
				vled = 0;
				aled = 0;
				xled = 1;
			end		
	end
endmodule
