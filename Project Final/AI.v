// Code your design here
module AI2 (board_state, clk, next_move1, next_move2, enable_play, enable);
  
  input wire[1:0] board_state;	// tic-tac-toe board 
  input clk;
  input enable_play;
  input enable;
  output reg[1:0] next_move1;	// next move 1 indicates row
  output reg[1:0] next_move2;	// next move 2 indicates column
  
  // opponent = 0, ai = 1, empty = 2
  integer i, j;
  integer empty = 0;
  integer ai = 2;
  integer opponent = 1;
  reg [1:0] b_temp [0:2][0:2];

  reg[4:0] read_row = 0;
  reg[4:0] read_col = 0;

always @(posedge clk)
begin
		if (enable == 1) begin
		b_temp[read_row][read_col] = board_state;
		//$display("INPUT IS: %0d", board_state);
		
		read_col = read_col + 1;
		if (read_col == 3) 
          	begin
			// wrap around to the first column and increment height
			read_col = 0;
			read_row = read_row + 1;
			if (read_row == 3) 
              		begin
				// wrap around back to the first row
				read_row = 0;
			end
		end
	end
	else if (enable_play == 1) begin
      
    /**** AI plays normally ****/
      if (b_temp[0][1] == empty)
        begin
          next_move1 = 0;
          next_move2 = 1;
        end
      
      if (b_temp[1][2] == empty)
        begin
          next_move1 = 1;
          next_move2 = 2;
        end
      
      if (b_temp[2][1] == empty)
        begin
          next_move1 = 2;
          next_move2 = 1;
        end
      
      if (b_temp[1][0] == empty)
        begin
          next_move1 = 1;
          next_move2 = 0;
        end
      
      /**** Corner moves ****/
      if (b_temp[0][0] == empty)
        begin
          next_move1 = 0;
          next_move2 = 0;
        end
      
      if (b_temp[2][0] == empty)
        begin
          next_move1 = 2;
          next_move2 = 0;
        end
      
      if (b_temp[2][2] == empty)
        begin
          next_move1 = 2;
          next_move2 = 2;
        end
      
      if (b_temp[0][2] == empty)
        begin
          next_move1 = 0;
          next_move2 = 2;
        end
      
      /**** center move ****/
      
      if (b_temp[1][1] == empty)
        begin
          next_move1 = 1;
          next_move2 = 1;
        end
      
      
      
      
    /**** ENDOF AI plays normally ****/

	/**** AI checks if it can defend ****/
	for (i = 0; i < 3; i = i + 1) 	// row check
         begin
		
		if (b_temp[i][0] == opponent && b_temp[i][1] == opponent && b_temp[i][2] == empty)
			begin
			next_move1 = i;
			next_move2 = 2;
			end

		if (b_temp[i][0] == opponent && b_temp[i][2] == opponent && b_temp[i][1] == empty)
			begin
			next_move1 = i;
			next_move2 = 1;
			end


		 if (b_temp[i][1] == opponent && b_temp[i][2] == opponent && b_temp[i][0] == empty)
			begin
			next_move1 = i;
			next_move2 = 0;
			end			
		
	end
	
	for (j = 0; j < 3; j = j + 1) 	// col check
         begin
		
		if (b_temp[0][j] == opponent && b_temp[1][j] == opponent && b_temp[2][j] == empty)
			begin
			next_move1 = 2;
			next_move2 = j;
			end

		if (b_temp[0][j] == opponent && b_temp[2][j] == opponent && b_temp[1][j] == empty)
			begin
			next_move1 = 1;
			next_move2 = j;
			end


		 if (b_temp[1][j] == opponent && b_temp[2][j] == opponent && b_temp[0][j] == empty)
			begin
			next_move1 = 0;
			next_move2 = j;
			end			

	end
	// diagonal check
	if (b_temp[0][0] == opponent && b_temp[2][2] ==  opponent && b_temp[1][1] == empty) begin
		next_move1 = 1;
		next_move2 = 1;
	   end
	// diagonal check
	if (b_temp[1][1] == opponent && b_temp[2][2] ==  opponent && b_temp[0][0] == empty) begin
		next_move1 = 0;
		next_move2 = 0;
	   end
	// diagonal check
	if (b_temp[0][0] == opponent && b_temp[1][1] ==  opponent && b_temp[2][2] == empty) begin
		next_move1 = 2;
		next_move2 = 2;
	   end
	/**** ENDOF AI checks if it can defend ****/
	
	
	/**** AI checks if it can win ****/
	for (i = 0; i < 3; i = i + 1) 	// row check
         begin
		
		if (b_temp[i][0] == ai && b_temp[i][1] == ai && b_temp[i][2] == empty)
			begin
			next_move1 = i;
			next_move2 = 2;
			end

		if (b_temp[i][0] == ai && b_temp[i][2] == ai && b_temp[i][1] == empty)
			begin
			next_move1 = i;
			next_move2 = 1;
			end


		 if (b_temp[i][1] == ai && b_temp[i][2] == ai && b_temp[i][0] == empty)
			begin
			next_move1 = i;
			next_move2 = 0;
			end			
		
	end
	// testing if there's a position that the AI can win
	for (j = 0; j < 3; j = j + 1) 	// col check
         begin
		
		if (b_temp[0][j] == ai && b_temp[1][j] == ai && b_temp[2][j] == empty)
			begin
			next_move1 = 2;
			next_move2 = j;
			end

		if (b_temp[0][j] == ai && b_temp[2][j] == ai && b_temp[1][j] == empty)
			begin
			next_move1 = 1;
			next_move2 = j;
			end


		 if (b_temp[1][j] == ai && b_temp[2][j] == ai && b_temp[0][j] == empty)
			begin
			next_move1 = 0;
			next_move2 = j;
			end			

	end
	// diagonal check
	if (b_temp[0][0] == ai && b_temp[2][2] ==  ai && b_temp[1][1] == empty) begin
		next_move1 = 1;
		next_move2 = 1;
	   end
	// diagonal check
	if (b_temp[1][1] == ai && b_temp[2][2] ==  ai && b_temp[0][0] == empty) begin
		next_move1 = 0;
		next_move2 = 0;
	   end
	// diagonal check
	if (b_temp[0][0] == ai && b_temp[1][1] ==  ai && b_temp[2][2] == empty) begin
		next_move1 = 2;
		next_move2 = 2;
	   end
	/**** ENDOF AI checks if it can win ****/
	
    end
end
  
endmodule
