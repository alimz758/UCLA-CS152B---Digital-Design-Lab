module add_tb();
	reg [3:0] a;
	reg [3:0] b;
	wire [4:0] out;
	
	add add_tb(.op1(a), .op2(b), .out(out));

	initial begin 
		a <= 13;
		b <= 2;
		#50;
		$display("%d + %d = %d", a, b, out);
		a <= 2;
		b <= 2;
		#50;
		$display("%d + %d = %d", a, b, out);
		a <= 6;
		b <= 2;
		#50;
		$display("%d + %d = %d", a, b, out);
		$finish;
	end
endmodule
