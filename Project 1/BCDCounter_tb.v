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

<<<<<<< HEAD
		//load 7 
		load = 1'b1;
		d = 4'b0111;
||||||| merged common ancestors
<<<<<<<<< Temporary merge branch 1
		//load again
		load = 1'b1;
||||||||| 53acab0
		//load again
		load =1;
=========
		//load 4 
		load = 1'b1;
>>>>>>>>> Temporary merge branch 2
		d = 4'b0100;
<<<<<<<<< Temporary merge branch 1
		#20;
||||||||| 53acab0
		#20
=========
=======
		//load 4 
		load = 1'b1;
		d = 4'b0100;
>>>>>>> 413a193fdcc99eaa164296d78d37e165e9a7366b
		#37;
<<<<<<< HEAD

		//decrement
		load = 1'b0;
		up = 1'b0;
		#90;
||||||| merged common ancestors
>>>>>>>>> Temporary merge branch 2
=======
>>>>>>> 413a193fdcc99eaa164296d78d37e165e9a7366b

		//clear
		clr = 1'b0;
		#50;
		$finish;
	end
	always #5 clk = ~clk;
endmodule;
