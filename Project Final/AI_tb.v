// Code your testbench here
// or browse Examples
module AI_tb();
 reg clk = 1;
 reg [7:0] board_state[0:2][0:2];
 reg enable_play;
 reg enable;
 integer i, j;
 wire [1:0]next_move1;
 wire [1:0]next_move2;
 wire game_is_over;
  
 reg[1:0] row_move;
 reg[1:0] col_move;
 reg ignore;
 
 reg[7:0] ai = "o";
 reg[7:0] opponent = "x";
 reg[7:0] empty = "a";

 reg[1:0] won = 0;
 reg [2:0] counter = 0;

  
 AI2 AI_tb(.clk(clk), .board_state(board_state), .next_move1(next_move1), .next_move2(next_move2), .enable_play(enable_play), .enable(enable));

 //whoWon whoWon(.clk(clk), .board_state(board_state), .who_won(who_won));



initial begin
enable_play = 0;

// opponent = 0, ai = 1, empty = 2
  board_state[0][0] = empty;
  board_state[0][1] = empty;
  board_state[0][2] = empty;

  board_state[1][0] = empty;
  board_state[1][1] = empty;
  board_state[1][2] = empty;

  board_state[2][0] = empty;
  board_state[2][1] = empty;
  board_state[2][2] = empty;


while (won == 0 ) begin 

    $display("Input your move!");
    row_move = $fgetc('h8000_0000);
    #5;
    col_move = $fgetc('h8000_0000);
    ignore = $fgetc('h8000_0000);
	//test = $getc();
    #5;
if ( board_state[row_move][col_move] == empty && row_move < 3 && col_move < 3) begin
    $display("input move is %d %d", row_move, col_move);
    board_state[row_move][col_move] = opponent;

enable = 1;

enable = 0;
enable_play = 1;
#20;
$display("row: %0d col: %0d", next_move1, next_move2); 
#20;
board_state[next_move1][next_move2] = ai;
enable_play = 0;

$display("%c | %c | %c", board_state[0][0], board_state[0][1] ,board_state[0][2]);
$display("----------");
$display("%c | %c | %c", board_state[1][0], board_state[1][1] ,board_state[1][2]);
$display("----------");
$display("%c | %c | %c", board_state[2][0], board_state[2][1] ,board_state[2][2]);


counter = counter + 1;

if (board_state[0][0] == ai && board_state[0][1] == ai && board_state[0][2] == ai) begin
won = 1;
$display("YOU HAVE LOST!");
$finish;
end
else if (board_state[1][0] == ai && board_state[1][1] == ai && board_state[1][2] == ai)begin
won = 1;
$display("YOU HAVE LOST!");
$finish;
end
else if (board_state[2][0] == ai && board_state[2][1] == ai && board_state[2][2] == ai)begin
won = 1;
$display("YOU HAVE LOST!");
$finish;
end
else if (board_state[0][0] == ai && board_state[1][0] == ai && board_state[2][0] == ai)begin
won = 1;
$display("YOU HAVE LOST!");
$finish;
end
else if (board_state[0][1] == ai && board_state[1][1] == ai && board_state[2][1] == ai)begin
won = 1;
$display("YOU HAVE LOST!");
$finish;
end
else if (board_state[0][2] == ai && board_state[1][2] == ai && board_state[2][2] == ai)begin
won = 1;
$display("YOU HAVE LOST!");
$finish;
end
else if (board_state[0][0] == opponent && board_state[0][1] == opponent && board_state[0][2] == opponent)begin
won = 2;
$display("YOU HAVE WON!");
$finish;
end
else if (board_state[1][0] == opponent && board_state[1][1] == opponent && board_state[1][2] == opponent)begin
won = 2;
$display("YOU HAVE WON!");
$finish;
end
else if (board_state[2][0] == opponent && board_state[2][1] == opponent && board_state[2][2] == opponent)begin
won = 2;
$display("YOU HAVE WON!");
$finish;
end
else if (board_state[0][0] == opponent && board_state[1][0] == opponent && board_state[2][0] == opponent)begin
won = 2;
$display("YOU HAVE WON!");
$finish;
end
else if (board_state[0][1] == opponent && board_state[1][1] == opponent && board_state[2][1] == opponent)begin
won = 2;
$display("YOU HAVE WON!");
$finish;
end
else if (board_state[0][2] == opponent && board_state[1][2] == opponent && board_state[2][2] == opponent)begin
won = 2;
$display("YOU HAVE WON!");
$finish;
end
else if (counter == 4)begin
won = 3; //draw
$display("IT'S A DRAW!");
$finish;
end
else
won = 0;
end
else
$display("WRONG MOVE. TRY AGAIN!");

end
$finish;

end

always begin
	#1 clk = !clk;
end

endmodule
