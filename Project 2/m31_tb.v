module m31_tb();

	reg d1, d2, d3;
	reg[1:0] sel;
	wire out;

	m31 m31_tb(.out(out), .d1(d1), .d2(d2), .d3(d3), .sel(sel));
	
	initial begin
		d1 = 0;
		d2 = 0;
		d3 = 0;
		sel = 2'b00;
		#10;

		d1 = 1;
		d2 = 0;
		d3 = 0;
		sel = 2'b00;
		#10;

		d1 = 0;
		d2 = 0;
		d3 = 0;
		sel = 2'b00;
		#10;

		d1 = 0;
		d2 = 1;
		d3 = 0;
		sel = 2'b01;
		#10;

		d1 = 0;
		d2 = 0;
		d3 = 0;
		sel = 2'b00;
		#10;

		d1 = 0;
		d2 = 0;
		d3 = 1;
		sel = 2'b10;
		#10;

		d1 = 0;
		d2 = 0;
		d3 = 0;
		sel = 2'b00;
		#10;

		d1 = 0;
		d2 = 0;
		d3 = 1;
		sel = 2'b11;
		#10;
	end
endmodule;
