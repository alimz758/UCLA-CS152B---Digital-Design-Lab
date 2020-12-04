module player_tb();

	reg clk;
	reg [1:0] board_state;
	wire [1:0] next_move1;
	wire [1:0] next_move2;

	player p(.clk(clk), .board_state(board_state), .next_move1(next_move1), .next_move2(next_move2))
	always begin
		#1 clk = !clk;
	end
	
	
endmodule;