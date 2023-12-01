module top(
	input clk,
	input out,
	output s0,
	output s1,
	output s2,
	output s3,
	output led1,
	output led2,
);

wire [22:0]rojo;
wire [22:0]azul;

Color Sensor(clk, out, s0, s1, s2, s3, rojo, azul);
Control Led(rojo, azul, led1, led2);

endmodule

