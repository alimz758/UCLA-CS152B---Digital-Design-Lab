
module BCDCounter(
	q, d, enable, load, up, clr, clk
	);
	
	input [3:0] d;
	input enable, clk, clr, load, up;
	output wire [3:0]q;
	reg co;
	reg [3:0] temp;
	

	always @(posedge clk) begin
		if (clr == 0) temp <= 4'b0000;
		else begin
			if (load == 1 && enable == 1)
				temp <= d;
			else if (load == 0 && enable == 1 && up == 1)
				 temp <= temp + 4'b0001;
			else if (load == 0 && enable == 1 && up == 0)
				temp <= temp - 4'b0001;
			else if(enable == 1 && up == 1 && temp == 4'b1001) begin
				co <= 1;
				temp <= 4'b0000;
			end
			else if (enable == 1 && up == 0 && temp == 4'b0000) begin
				co <= 1;
				temp <= 4'b1001;
			end
		end
		
	end
	assign q = temp;
endmodule 