module add_tb();
	reg [5:0] a;
	reg [5:0] b;
	wire [6:0] out;
	
	add add_tb(.op1(a), .op2(b), .out(out));

	initial begin
		for (a = 28; a < 31; a = a + 1) begin
			for (b = 28; b < 31; b = b + 1) begin
				#50;
				$display("%d + %d = %d", a, b, out);
			end
		end
		$finish;
	end
endmodule
