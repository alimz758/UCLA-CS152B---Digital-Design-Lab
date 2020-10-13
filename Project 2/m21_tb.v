module m21_tb();

	reg d1, d2, sel;
	wire out;

	m21 m21_tb(.out(out), .d1(d1), .d2(d2), .sel(sel));
	
	initial begin
		d1 = 0;
		d2 = 0;
		sel = 1'b0;
		#20;

		d1 = 0;
		d2 = 0;
		sel = 1'b1;
		#20;

		d1 = 1;
		d2 = 0;
		sel = 1'b0;
		#20;

		d1 = 0;
		d2 = 1;
		sel = 1'b1;
		#20;

		
	end
endmodule;
