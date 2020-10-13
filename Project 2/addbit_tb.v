module addbit_tb();

	reg cin, a, b;
	wire s, cout;

	addbit addbit_tb(.s(s), .cout(cout), .cin(cin), .a(a), .b(b));

	initial begin
		a =0;
		b=0;
		cin=0;
		#10;
	
		a =0;
		b=0;
		cin=1;
		#10;

		a =1;
		b=0;
		cin=0;
		#10;

		a =1;
		b=0;
		cin=1;
		#10;

		a =0;
		b=1;
		cin=0;
		#10;

		a =0;
		b=1;
		cin=1;
		#10;

		a =1;
		b=1;
		cin=0;
		#10;

		a =1;
		b=1;
		cin=1;
		#10;
		
	end
endmodule;
