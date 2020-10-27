//structural
module addbit(s, cout, cin, a, b);

	input cin, a, b;
	output s, cout;
	wire o1, o2, o3;

	xor i1(o1, a, b);
	and i2(o2, a, b);
	and i3(o3, cin, o1);
	or  i4(cout, a3, a2);
	xor i5(s, a1, cin);
endmodule
