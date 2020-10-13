module m31(out, d1, d2, d3, sel);

	input d1, d2, d3;
	input[1:0] sel;
	output wire out;
	wire o1;

	m21 mux1(o1, d1, d2, sel[0]);
	m21 mux2(out, o1, d3, sel[1]);

endmodule;