module clock_tb();

reg clk;
wire out;

clock clock_tb(.clk(clk), .out(out));

initial begin
clk = 0;
#5000
$finish;
end

always
	#1 clk = !clk;

endmodule
