
module BCDCounter(
	q, d, enable, load, up, clr, clk
	);
	
	input [3:0] d;
	input enable, clk, clr, load, up;
	output wire [3:0]q;
	reg co;
	reg [3:0] temp;
	

	always @(posedge clk or negedge clr) begin
		if (!clr) temp <= 4'b0000;
		else begin
			if (load == 1 && enable == 1)
				temp <= d;
			else if (load == 0 && enable == 1 && up == 1) begin
				if (temp == 4'b1001) begin
					co <= 1;
					temp <= 4'b0000;
				end
				else
				 	temp <= temp + 4'b0001;
			end
			else if (load == 0 && enable == 1 && up == 0) begin
				if (temp == 4'b0000) begin 
					co <= 1;
					temp <= 4'b1001;
				end
				else 
					temp <= temp - 4'b0001;
			end
		end
		
	end
	assign q = temp;
endmodule 