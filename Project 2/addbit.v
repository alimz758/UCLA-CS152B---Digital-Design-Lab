//structural
module addbit(s, cout, cin, a, b);

	input cin, a, b;
	output s, cout;
	wire o1, o2, o3;

	xor i1(o1, a, b);
	and i2(o2, a, b);
	and i3(o3, o1, cin);
	or  i4(cout, o2, o3);
	xor i5(s, o1, cin);
endmodule
