module clock (
clk, out
);

input clk;
output reg out = 1;

reg [15:0] counter = 0;

always @(posedge clk) begin
	counter = counter + 1;
	//if (counter == 1000) begin
	// changed for simulation purposes
	if (counter == 5) begin
		out = !out;
		counter = 0;
	end
end

endmodule
