module top(
	//input start,
	input clock,
	input laser,
	output pulse,
	input echo,
	output rled,
	output vled,
	output aled,
	output ledx,
	output clkout1,
	output clkout2
	
	
	);
wire [19:0]ciclos;
wire clktotrig;
wire acttoserv1;
wire acttoserv2;
wire acttoserv3;
wire clktrig;
clkinult clocktrig(clock,clktrig);
ulttrigger trigger(clktrig,clock,pulse);
echocounter comparador(echo,clock,ciclos);
ultactuador actuador(ciclos,laser,acttoserv1,acttoserv2,acttoserv3,ledx);
assign rled=acttoserv1;
assign vled=acttoserv2;
assign aled=acttoserv3;
servo serv1(clock,acttoserv1,clkout1);
servo2 serv2(clock,acttoserv2,clkout2);


endmodule

