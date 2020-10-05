`timescale 1ns/ 1ps

module BCDCounter_tb();
	reg [3:0]d;
	reg clk, clr, load, enable, up;
	wire [3:0] q;
	
	
	BCDCounter uut(.q(q), .d(d), .enable(enable), .load(load), .up(up), .clr(clr), .clk(clk));

	initial begin 
		// load, enable set
		clk = 0;
		clr = 1;
		d = 4'b0001;
		load =1;
		enable=1;
		#20;
		
		//increment
		load = 0;
		up =1;
		#40;

		//decrement
		up = 0;
		#60

		//load again
		load =1;
		d = 4'b0100;
		#20

		//clear
		clr =0; 
	end

	always #5 clk = ~clk;
	
	
endmodule;
