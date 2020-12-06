module player_tb();

	reg clk;
	reg [1:0] board_state[0:2][0:2];
	reg [1:0] next_move1_in;
	reg [1:0] next_move2_in;
	wire [1:0] next_move1_out;
	wire [1:0] next_move2_out;
	wire [2:0] who_won;
	integer i, j;

	player player(.clk(clk), .board_state(board_state), .next_move1_in(next_move1_in), .next_move2_in(next_move2_in),  .next_move1_out(next_move1_out), .next_move2_out(next_move2_out));
	whoWon win(.clk(clk), .board_state(board_state), .who_won(who_won));

	initial begin
		// init grid with empty, 2
		for (i=0; i<3; i=i+1)
			for (j=0; j<3; j=j+1) 
				board_state[i][j] = 2;


		clk = 1;
		//p1 playing
		next_move1_in = 0;
		next_move2_in = 0;
		#2;
		$display("P1 next move %0d %0d", next_move1_out, next_move2_out);
		board_state[next_move1_out][next_move2_out] = 0;
		#2;

		//p2 playing
		next_move1_in = 0;
		next_move2_in = 1;
		#2;
		$display("p2 next move %0d %0d",next_move1_out, next_move2_out);
		board_state[next_move1_out][next_move2_out] = 1;
		#2;

		//p1 playing
		next_move1_in = 1;
		next_move2_in = 0;
		#2;
		$display("P1 next move %0d %0d",next_move1_out, next_move2_out);
		board_state[next_move1_out][next_move2_out] = 0;
		#2;

		//p2 playing
		next_move1_in = 0;
		next_move2_in = 2;
		#2;
		$display("P2 next move %0d %0d",next_move1_out, next_move2_out);
		board_state[next_move1_out][next_move2_out] = 1;
		#2;

		//p1 playing
		next_move1_in = 2;
		next_move2_in = 0;
		//#2;
		$display("P1 next move %0d %0d",next_move1_out, next_move2_out);
		board_state[next_move1_out][next_move2_out] = 0;
		#5;

		$finish;
	end
	

	always begin
		#1 clk = !clk;
	end
	always @(posedge clk) begin
		if (who_won == 0) 
			$display("player 1 won");
		if (who_won == 1) 
			$display("player 2 won");
		if (who_won == 2) 
			$display("Draw");
	end
	
	
endmodule;
