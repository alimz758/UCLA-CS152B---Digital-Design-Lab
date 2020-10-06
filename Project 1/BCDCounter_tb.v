module BCDCounter_tb();
	reg [3:0]d;
	reg clk, clr, load, enable, up;
	wire [3:0] q;
	wire co;
	
	BCDCounter BCDCounter_tb(.q(q), .co(co), .d(d), .enable(enable), .load(load), .up(up), .clr(clr), .clk(clk));

	initial begin 
		// load 1, enable set
		clk = 1'b0;
		clr = 1'b1;
		d = 4'b0001;
		load =1'b1;
		enable=1'b1;
		#30;
		
		//increment
		load = 1'b0;
		up = 1'b1;
		#90;

		//decrement
		up = 1'b0;
		#60;

		//load 7 
		load = 1'b1;
		d = 4'b0111;
		#37;

		//decrement
		load = 1'b0;
		up = 1'b0;
		#90;

		//clear
		clr = 1'b0;
		#50;
		$finish;
	end
	always #5 clk = ~clk;
endmodule;
