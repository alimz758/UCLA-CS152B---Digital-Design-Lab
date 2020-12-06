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

	integer i;
	integer j;
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
		next_move1_in = 2;
		next_move2_in = 0;
		#20
		$finish;
	end
	

	always begin
		#1 clk = !clk;
	end
	always @(posedge clk) begin
		if (game_ended == 1) begin
			$display("Winner: %d", winner);
		end
	end
	
	
endmodule
