module BCDCounter_tb();
	reg [3:0]d;
	reg clk, clr, load, enable, up;
	wire [3:0] q;
	
	BCDCounter BCDCounter_tb(.q(q), .d(d), .enable(enable), .load(load), .up(up), .clr(clr), .clk(clk));

	initial begin 
		// load, enable set
		clk = 1'b0;
		clr = 1'b1;
		d = 4'b0001;
		load =1'b1;
		enable=1'b1;
		#20;
		
		//increment
		load = 1'b0;
		up = 1'b1;
		#40;

		//decrement
		up = 1'b0;
		#60;

		//load again
		load = 1'b1;
		d = 4'b0100;
		#20;

		//clear
		clr = 1'b0;
		#10;
		$finish;
	end

	always #5 clk = ~clk;
endmodule;
