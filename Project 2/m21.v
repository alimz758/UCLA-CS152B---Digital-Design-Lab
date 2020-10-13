//Behavioral
module m21(out, d1, d2, sel);

	input d1, d2, sel;
	output wire out;
	reg out_t;

	always @(d1, d2, sel) begin
		if (sel == 1'b0)
			out_t = d1;
		else 
			out_t = d2;
	end
	assign out = out_t;
endmodule;
