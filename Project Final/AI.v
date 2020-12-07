// Code your design here
module AI2 (board_state, clk, next_move1, next_move2, enable_play, enable, game_is_over);
  
  input [1:0] board_state[0:2][0:2];	// tic-tac-toe board 
  input clk;
  input enable_play;
  input enable;
  output reg[1:0] next_move1;	// next move 1 indicates row
  output reg[1:0] next_move2;	// next move 2 indicates column
  output reg game_is_over; 
  
  // opponent = 0, ai = 1, empty = 2
  integer i, j;
  integer empty = 2;
  integer ai = 1;
  integer opponent = 0;
  reg [1:0] b_temp [0:2][0:2];

  reg[4:0] read_row = 0;
  reg[4:0] read_col = 0;

always @(posedge clk)
begin
	game_is_over = 0;
	if (enable_play == 1) begin
      
    /**** AI plays normally ****/
      if (board_state[0][1] == empty)
        begin
          next_move1 = 0;
          next_move2 = 1;
        end
      
      if (board_state[1][2] == empty)
        begin
          next_move1 = 1;
          next_move2 = 2;
        end
      
      if (board_state[2][1] == empty)
        begin
          next_move1 = 2;
          next_move2 = 1;
        end
      
      if (board_state[1][0] == empty)
        begin
          next_move1 = 1;
          next_move2 = 0;
        end
      
      /**** Corner moves ****/
      if (board_state[0][0] == empty)
        begin
          next_move1 = 0;
          next_move2 = 0;
        end
      
      if (board_state[2][0] == empty)
        begin
          next_move1 = 2;
          next_move2 = 0;
        end
      
      if (board_state[2][2] == empty)
        begin
          next_move1 = 2;
          next_move2 = 2;
        end
      
      if (board_state[0][2] == empty)
        begin
          next_move1 = 0;
          next_move2 = 2;
        end
      
      /**** center move ****/
      
      if (board_state[1][1] == empty)
        begin
          next_move1 = 1;
          next_move2 = 1;
        end
      
      
      
      
    /**** ENDOF AI plays normally ****/

	/**** AI checks if it can defend ****/
	for (i = 0; i < 3; i = i + 1) 	// row check
         begin
		
           if (board_state[i][0] == opponent && board_state[i][1] == opponent && board_state[i][2] == empty)
			begin
			next_move1 = i;
			next_move2 = 2;
			end

           if (board_state[i][0] == opponent && board_state[i][2] == opponent && board_state[i][1] == empty)
			begin
			next_move1 = i;
			next_move2 = 1;
			end


           if (board_state[i][1] == opponent && board_state[i][2] == opponent && board_state[i][0] == empty)
			begin
			next_move1 = i;
			next_move2 = 0;
			end			
		
	end
	
	for (j = 0; j < 3; j = j + 1) 	// col check
         begin
		
           if (board_state[0][j] == opponent && board_state[1][j] == opponent && board_state[2][j] == empty)
			begin
			next_move1 = 2;
			next_move2 = j;
			end

           if (board_state[0][j] == opponent && board_state[2][j] == opponent && board_state[1][j] == empty)
			begin
			next_move1 = 1;
			next_move2 = j;
			end


           if (board_state[1][j] == opponent && board_state[2][j] == opponent && board_state[0][j] == empty)
			begin
			next_move1 = 0;
			next_move2 = j;
			end			

	end
	// diagonal check
      if (board_state[0][0] == opponent && board_state[2][2] ==  opponent && board_state[1][1] == empty) begin
		next_move1 = 1;
		next_move2 = 1;
	   end
	// diagonal check
      if (board_state[1][1] == opponent && board_state[2][2] ==  opponent && board_state[0][0] == empty) begin
		next_move1 = 0;
		next_move2 = 0;
	   end
	// diagonal check
      if (board_state[0][0] == opponent && board_state[1][1] ==  opponent && board_state[2][2] == empty) begin
		next_move1 = 2;
		next_move2 = 2;
	   end
	/**** ENDOF AI checks if it can defend ****/
	
	
	/**** AI checks if it can win ****/
	for (i = 0; i < 3; i = i + 1) 	// row check
         begin
		
           if (board_state[i][0] == ai && board_state[i][1] == ai && board_state[i][2] == empty)
			begin
			next_move1 = i;
			next_move2 = 2;
			end

           if (board_state[i][0] == ai && board_state[i][2] == ai && board_state[i][1] == empty)
			begin
			next_move1 = i;
			next_move2 = 1;
			end


           if (board_state[i][1] == ai && board_state[i][2] == ai && board_state[i][0] == empty)
			begin
			next_move1 = i;
			next_move2 = 0;
			end			
		
	end
	// testing if there's a position that the AI can win
	for (j = 0; j < 3; j = j + 1) 	// col check
         begin
		
           if (board_state[0][j] == ai && board_state[1][j] == ai && board_state[2][j] == empty)
			begin
			next_move1 = 2;
			next_move2 = j;
			end

           if (board_state[0][j] == ai && board_state[2][j] == ai && board_state[1][j] == empty)
			begin
			next_move1 = 1;
			next_move2 = j;
			end


           if (board_state[1][j] == ai && board_state[2][j] == ai && board_state[0][j] == empty)
			begin
			next_move1 = 0;
			next_move2 = j;
			end			

	end
	// diagonal check
      if (board_state[0][0] == ai && board_state[2][2] ==  ai && board_state[1][1] == empty) begin
		next_move1 = 1;
		next_move2 = 1;
	   end
	// diagonal check
      if (board_state[1][1] == ai && board_state[2][2] ==  ai && board_state[0][0] == empty) begin
		next_move1 = 0;
		next_move2 = 0;
	   end
	// diagonal check
      if (board_state[0][0] == ai && board_state[1][1] ==  ai && board_state[2][2] == empty) begin
		next_move1 = 2;
		next_move2 = 2;
	   end
	/**** ENDOF AI checks if it can win ****/
	
    end
end
  
endmodule
