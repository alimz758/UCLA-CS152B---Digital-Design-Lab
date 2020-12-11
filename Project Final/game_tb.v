module game_tb();

	reg clk;
	reg [1:0] board_state[0:2][0:2];
	reg [1:0] next_move1_in;
	reg [1:0] next_move2_in;
	wire [1:0] next_move1_out;
	wire [1:0] next_move2_out;

	player player(.clk(clk), .board_state(board_state), .next_move1_in(next_move1_in), .next_move2_in(next_move2_in),  .next_move1_out(next_move1_out), .next_move2_out(next_move2_out));

	reg rst;
	reg [1:0] player_move;
	wire game_ended;
	wire [1:0] winner;
	board board(
		.clk(clk),
		.rst(rst),
		.next_move1(next_move1_out),
		.next_move2(next_move2_out),
		.player_move(player_move),
		.board_state(board_state),
		.game_ended(game_ended),
		.winner(winner)
	);

//	initial begin
//		clk = 1;
//		#1;
//		player_move = 0;
//		#5;
//		while (game_ended == 0) begin
//			$display("Input your move!");
//			next_move1_in = $fgetc('h8000_0000);
//			#5;
//			next_move2_in = $fgetc('h8000_0000);
//			#5;
//			player_move = 1 - player_move;
//		end
//		$finish
//	end

	initial begin
		clk = 1;
		#1

		player_move = 0;
		next_move1_in = 0;
		next_move2_in = 0;
		#20

		player_move = 1;
		next_move1_in = 1;
		next_move2_in = 1;
		#20
 
		player_move = 0;
		next_move1_in = 1;
		next_move2_in = 0;
		#20

		player_move = 1;
		next_move1_in = 0;
		next_move2_in = 1;
		#20

		player_move = 0;
		next_move1_in = 0; // 2
		next_move2_in = 2; // 0
		#20
		//$finish;

		player_move = 1;
		next_move1_in = 2;
		next_move2_in = 0;
		#20

		player_move = 0;
		next_move1_in = 1;
		next_move2_in = 2;
		#20

		player_move = 1;
		next_move1_in = 2;
		next_move2_in = 2;
		#20

		player_move = 0;
		next_move1_in = 2;
		next_move2_in = 1;
		#20
		$finish;
	end
	

	always begin
		#1 clk = !clk;
	end
	always @(posedge clk) begin
		if (game_ended == 1) begin
			if (winner == 0)
				$display("Winner: X");
			else if (winner == 1)
				$display("Winner: O");
			else
				$display("Tie");
			rst = 1;
			#20;
			rst = 0;
			#20;
		end
	end
	
	
endmodule
