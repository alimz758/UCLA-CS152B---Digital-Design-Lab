module add(
op1, op2, out
);

input [5:0] op1;
input [5:0] op2;
output [6:0] out;

wire [6:0] s1 = op1 ^ op2;
wire [6:0] c1p = op1 & op2;
wire [6:0] c1 = {c1p[5:0], 1'b0};

wire [6:0] s2 = s1 ^ c1;
wire [6:0] c2p = s1 & c1;
wire [6:0] c2 = {c2p[5:0], 1'b0};

wire [6:0] s3 = s2 ^ c2;
wire [6:0] c3p = s2 & c2;
wire [6:0] c3 = {c3p[5:0], 1'b0};

wire [6:0] s4 = s3 ^ c3;
wire [6:0] c4p = s3 & c3;
wire [6:0] c4 = {c4p[5:0], 1'b0};

wire [6:0] s5 = s4 ^ c4;
wire [6:0] c5p = s4 & c4;
wire [6:0] c5 = {c5p[5:0], 1'b0};

wire [6:0] s6 = s5 ^ c5;
wire [6:0] c6p = s5 & c5;
wire [6:0] c6 = {c6p[5:0], 1'b0};

assign out = c6 | s6;

endmodule
