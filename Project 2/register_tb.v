module register_tb();

reg [4:0] Ra;
reg [4:0] Rb;
reg [4:0] Rw;
reg WrEn;
reg [15:0] busW;
wire [15:0] busA;
wire [15:0] busB;

reg clk;
reg rst;

register register_tb(
.Ra(Ra), .Rb(Rb),
.Rw(Rw), .WrEn(WrEn), .busW(busW),
.busA(busA), .busB(busB),
.clk(clk), .rst(rst)
);

initial begin
clk = 0;
rst = 0;
WrEn = 0;

// write 1 to register 1 and 2 to register 2
WrEn = 1;
Rw = 1;
busW = 1;
#10
Rw = 2;
busW = 2;
#10

// read register 1 and register 2
WrEn = 0;
Ra = 1;
Rb = 2;
#10
$display("register 1 = %d", busA);
$display("register 2 = %d", busB);

// write 3 to register 1 and read at the same time (we should read the new value 3)
WrEn = 1;
Rw = 1;
busW = 3;
Ra = 1;
#10
$display("register 1 = %d", busA);

// reset everything (but with WrEn set to 1 to make sure that rst has higher precedence)
rst = 1;
#10
WrEn = 0;
rst = 0;
#10

// read register 1 and register 2 again (should be 0)
Ra = 1;
Rb = 2;
#10
$display("register 1 = %d", busA);
$display("register 2 = %d", busB);

$finish;

end

always
	#5 clk = !clk;

endmodule
