// Code your testbench here
// or browse Examples
module AI_tb();
 reg clk = 1;
  reg [1:0] board_state[0:2][0:2];
 //reg [1:0] board_temp [0:2][0:2];
 reg enable_play;
 reg enable;
 integer i, j;
 wire [1:0]next_move1;
 wire [1:0]next_move2;
 wire game_is_over;
  
 reg[1:0] row_move;
 reg[1:0] col_move;
 reg ignore;

 integer count = 0;
  
 AI2 AI_tb(.clk(clk), .board_state(board_state), .next_move1(next_move1), .next_move2(next_move2), .enable_play(enable_play), .enable(enable), .game_is_over(game_is_over));



initial begin
enable_play = 0;


// opponent = 0, ai = 1, empty = 2
  board_state[0][0] = 2;
  board_state[0][1] = 2;
  board_state[0][2] = 2;

  board_state[1][0] = 2;
  board_state[1][1] = 2;
  board_state[1][2] = 2;

  board_state[2][0] = 2;
  board_state[2][1] = 2;
  board_state[2][2] = 2;

while (count != 3) begin // count is for testing purposes only, state of game needs to be tested here

    $display("Input your move!");
    //$fgets(test, 'h8000_0000); 
    row_move = $fgetc('h8000_0000);
    #5;
    col_move = $fgetc('h8000_0000);
    ignore = $fgetc('h8000_0000);
	//test = $getc();
    #5;
    $display("input move is %d %d", row_move, col_move);
    #20;
 board_state[row_move][col_move] = 0;

enable = 1;
//for (i = 0; i < 3; i = i + 1)
//   for (j = 0; j < 3; j = j + 1)begin
//	board_state = board_temp[i][j];
//	#2;
//end
enable = 0;
enable_play = 1;
#20
$display("row: %0d col: %0d", next_move1, next_move2); 
board_state[next_move1][next_move2] = 1;
enable_play = 0;

$display("%0d | %0d | %0d", board_state[0][0], board_state[0][1] ,board_state[0][2]);
$display("----------");
$display("%0d | %0d | %0d", board_state[1][0], board_state[1][1] ,board_state[1][2]);
$display("----------");
$display("%0d | %0d | %0d", board_state[2][0], board_state[2][1] ,board_state[2][2]);
count = count + 1;
end
$finish;

end
  

always begin
	#1 clk = !clk;
end

endmodule
