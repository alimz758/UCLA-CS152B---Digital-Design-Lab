module Div11_tb();
	reg [15:0] d;
	wire div;

	Div11 Div11_tb(.inp(d), .divisible(div));

	initial begin 
		d = 16'b0000_0000_0001_0001;
		#50
		$display("%b", div);
		d = 16'b0000_0000_0001_0010;
		#50
		$display("%b", div);
		d = 16'b0000_0000_0010_0010;
		#50
		$display("%b", div);
		d = 16'b1001_0000_1001_0000;
		#50
		$display("%b", div);
		d = 16'b1001_0000_1001_0111;
		#50
		$display("%b", div);
		$finish;
	end
endmodule;
