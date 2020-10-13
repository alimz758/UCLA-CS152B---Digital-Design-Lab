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

wire [6:0] d13;
add add_d13(.op1({2'b0, d1}), .op2({2'b0, d3}), .out(d13));

wire [6:0] d24;
add add_d24(.op1({2'b0, d2}), .op2({2'b0, d4}), .out(d24));

wire [6:0] neg_d24;
assign neg_d24 = ~d24;

wire [6:0] mod;
add add_d1324(.op1(d13), .op2(neg_d24), .out(mod));

assign divisible = (mod == 7'b0111111) || (mod == 7'b1001010) || (mod == 7'b0110100);

endmodule
