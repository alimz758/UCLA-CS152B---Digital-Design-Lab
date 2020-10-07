module add(
op1, op2, out
);

input [3:0] op1;
input [3:0] op2;
output [4:0] out;

wire [4:0] s1 = op1 ^ op2;
wire [4:0] c1p = op1 & op2;
wire [4:0] c1 = {c1p[3:0], 1'b0};

wire [4:0] s2 = s1 ^ c1;
wire [4:0] c2p = s1 & c1;
wire [4:0] c2 = {c2p[3:0], 1'b0};

wire [4:0] s3 = s2 ^ c2;
wire [4:0] c3p = s2 & c2;
wire [4:0] c3 = {c3p[3:0], 1'b0};

wire [4:0] s4 = s3 ^ c3;
wire [4:0] c4p = s3 & c3;

assign out = s4;

endmodule
