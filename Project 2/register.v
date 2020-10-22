module register(
Ra, Rb,
Rw, WrEn, busW,
busA, busB,
clk, rst,
);

input [4:0] Ra;
input [4:0] Rb;
input [4:0] Rw;
input WrEn;
input [15:0] busW;

input clk;
input rst;

output reg [15:0] busA;
output reg [15:0] busB;

reg [15:0] registers [31:0];

integer reset_i;

always @(posedge clk) begin
	if (rst) begin
		// reset
		for (reset_i = 0; reset_i < 32; reset_i = reset_i + 1) begin
			registers[reset_i] <= 16'b0;
		end
		busA <= 16'b0;
		busB <= 16'b0;
	end else if (WrEn) begin
		// write and read
 		registers[Rw] <= busW;
		if (Rw == Ra) begin
			// if we're reading from the same write location, just read
			// from busW instead
			busA <= busW;
		end else begin
			// otherwise read from Ra
			busA <= registers[Ra];
		end
		if (Rw == Rb) begin
			// same logic as busA
			busB <= busW;
		end else begin
			busB <= registers[Rb];
		end
	end else begin
		busA <= registers[Ra];
		busB <= registers[Rb];
	end
end

endmodule
