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

always @(posedge clk) begin
	if (rst) begin
		// reset
		registers[0] <= 16'b0; registers[1] <= 16'b0; registers[2] <= 16'b0; registers[3] <= 16'b0;
		registers[4] <= 16'b0; registers[5] <= 16'b0; registers[6] <= 16'b0; registers[7] <= 16'b0;
		registers[8] <= 16'b0; registers[9] <= 16'b0; registers[10] <= 16'b0; registers[11] <= 16'b0;
		registers[12] <= 16'b0; registers[13] <= 16'b0; registers[14] <= 16'b0; registers[15] <= 16'b0;
		registers[16] <= 16'b0; registers[17] <= 16'b0; registers[18] <= 16'b0; registers[19] <= 16'b0;
		registers[20] <= 16'b0; registers[21] <= 16'b0; registers[22] <= 16'b0; registers[23] <= 16'b0;
		registers[24] <= 16'b0; registers[25] <= 16'b0; registers[26] <= 16'b0; registers[27] <= 16'b0;
		registers[28] <= 16'b0; registers[29] <= 16'b0; registers[30] <= 16'b0; registers[31] <= 16'b0;
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
