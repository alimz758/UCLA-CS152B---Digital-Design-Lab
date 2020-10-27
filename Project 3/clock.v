module clock (
clk, out
);

input clk;
output reg out = 0;

reg [15:0] counter = 0;

always @(posedge clk) begin
	counter = counter + 1;
	if (counter == 1000) begin
		out = !out;
		counter = 0;
	end
end

endmodule
