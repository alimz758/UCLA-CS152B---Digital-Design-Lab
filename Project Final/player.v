module player(clk, board_state, next_move1_in, next_move2_in,  next_move1_out, next_move2_out);

	input clk;
	input [1:0] board_state[0:2][0:2];
	input [1:0] next_move1_in;	// input the row on the grid 0-2
	input [1:0] next_move2_in;  // input the col on the grid 0-2
	output reg [1:0] next_move1_out;	// validate the move, if invalid 2 next_move1_in
	output reg [1:0] next_move2_out;  // // validate the move, if invalid 2 next_move2_in


	always @(posedge clk) begin
		// validate the player module
		if (next_move1_in >=0 && next_move1_in <=2 && next_move2_in >=0 && next_move2_in <=2) begin
			if (board_state[next_move1_in][next_move2_in] == 2) begin
				next_move1_out = next_move1_in;
				next_move2_out = next_move2_in;
			end
			else begin
				//$display("This spot is taken\n");
				next_move1_out = 3;
				next_move2_out = 3;
			end
		end
		else begin
			$display("This spot is outside of the grid\n");
			next_move1_out = 3;
			next_move2_out = 3;
		end
	end
endmodule
