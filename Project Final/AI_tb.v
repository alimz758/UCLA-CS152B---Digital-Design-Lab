module AI_tb();
 reg clk = 1;
 reg [1:0] board_state;
 reg [1:0] board_temp [0:2][0:2];
 reg enable_play;
 reg enable;
 integer i, j;
 wire [1:0]next_move1;
 wire [1:0]next_move2;
  
 AI2 AI_tb(.clk(clk), .board_state(board_state), .next_move1(next_move1), .next_move2(next_move2), .enable_play(enable_play), .enable(enable));



initial begin
enable_play = 0;

board_temp[0][0] = 0;
board_temp[0][1] = 2;
board_temp[0][2] = 0;

board_temp[1][0] = 1;
board_temp[1][1] = 2;
board_temp[1][2] = 1;

board_temp[2][0] = 2;
board_temp[2][1] = 2;
board_temp[2][2] = 2;

enable = 1;
for (i = 0; i < 3; i = i + 1)
   for (j = 0; j < 3; j = j + 1)begin
	board_state = board_temp[i][j];
	#2;
end
enable = 0;
enable_play = 1;
#200;
$display("row: %0d col: %0d", next_move1, next_move2); 

$finish;

end

always begin
	#1 clk = !clk;
end

endmodule
