module board(
input wire clk,
input wire rst,

input [1:0] next_move1,
input [1:0] next_move2,

input [1:0] player_move,

output reg [1:0] board_state [0:2][0:2],
output wire game_ended,
output wire [1:0] winner
);

reg [2:0] who_won;

whoWon whoWon(.clk(clk), .board_state(board_state), .who_won(who_won));

assign game_ended = who_won != 3;
assign winner = who_won;

always @(posedge clk) begin
	if (next_move1 < 3 && next_move2 < 3) begin
		board_state[next_move1][next_move2] = player_move;
		$display("Board:");
		$display("%d|%d|%d", board_state[0][0], board_state[0][1], board_state[0][2]);
		$display("-----");
		$display("%d|%d|%d", board_state[1][0], board_state[1][1], board_state[1][2]);
		$display("-----");
		$display("%d|%d|%d", board_state[2][0], board_state[2][1], board_state[2][2]);
		$display("=====");
	end
end

initial begin
	integer i;
	integer j;
	for (i = 0; i < 3; i = i + 1) begin
		for (j = 0; j < 3; j = j + 1) begin
			board_state[i][j] = 2;
		end
	end
end

endmodule
