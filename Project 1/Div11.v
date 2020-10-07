// Tests for divisibility by 11

module Div11 (
	inp, divisible
);

input [15:0] inp;
output divisible;

wire [3:0] d1;
wire [3:0] d2;
wire [3:0] d3;
wire [3:0] d4;
assign d1 = inp[15:12];
assign d2 = inp[11:8];
assign d3 = inp[7:4];
assign d4 = inp[3:0];

wire [3:0] mod;
assign mod = d1 - d2 + d3 - d4;

assign divisible = (mod == -11) || (mod == 0) || (mod == 11);

endmodule
