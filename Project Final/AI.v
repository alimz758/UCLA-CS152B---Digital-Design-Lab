// Code your design here
module AI (board_state, clk, next_move);
  
  input reg [1:0] board_state[0:2][0:2];	// tic-tac-toe board 
  input clk;
  output reg next_move[1:0];	// next move indicates row and column for AI
  
  
  integer move_left = 0;
  
  integer best_row = -1;
  integer best_col = -1;
  integer i, j;
  integer optimal_val = -1000;
  integer value;
  
  
  function automatic integer check_board(reg [1:0] board[0:2][0:2]); // fucntion for checking the board state and seeing whether a player has won
    integer row = 0;
    integer col = 0;
    
    integer ai = 1;
    integer opponent = -1;
    
    integer result = 0;
    // Checking for Rows for X or O victory. 
    for (row = 0; row < 3; row = row + 1) 
    begin
      if (board[row][0]==board[row][1] && board[row][1]==board[row][2]) 
        begin
          if (board[row][0]==ai) 
                result = 20; 
            else if (b[row][0]==opponent) 
                result = -20;
        end 
    end 
    
    // Checking for Columns for X or O victory. 
    for (int col = 0; col<3; col = col + 1) 
    begin 
      if (board[0][col]==board[1][col] && board[1][col]==board[2][col]) 
        begin 
          if (board[0][col]==ai) 
                result = 10; 
  
          else if (board[0][col]==opponent) 
                result = -10; 
        end 
     end
    
    // Checking for Diagonals for X or O victory. 
    if (board[0][0]==board[1][1] && board[1][1]==board[2][2]) 
    begin 
      if (board[0][0]==ai) 
            result =  20; 
      else if (board[0][0]==opponent) 
            result = -20; 
    end 
  
      if (board[0][2]==board[1][1] && board[1][1]==board[2][0]) 
    begin 
      if (board[0][2]==ai) 
            result = 20; 
      else if (board[0][2]==opponent) 
            result = -20; 
    end
    return result;
    
  endfunction
  
  
  function automatic integer minimax(reg[1:0] board[0:2][0:2], integer maximize);
    integer score = check_board(board);
    integer result;		// return value
    
    integer i, j;
    integer optimal1 = -1000;
    integer optimal2 = 1000;
    integer temp_minimax;
    
    
    if (score == 20)
      return 20;
    
    if (score == -20)
      return -20;
    
    // if no move is left return 0
    for (i = 0; i < 3; i = i +1)
      for (j = 0; j < 3; j = j + 1)
          if (board[i][j] == 0)
            move_left = 1;
    
    if (move_left == 0)
      return 0;
    
    
    if (maximize == 1)
      begin
        for (i = 0; i < 3; i = i + 1)
          for (j = 0; j < 3; j = j + 1)
            begin
              if (board[i][j] == 0)	// spot is empty
                begin
                  board[i][j] = ai;
                  temp_minimax = minimax(board, ~maximize);
                  board[i][j] = 0; // undo the move
                  if (temp_minimax > optimal1)
                    result = temp_minimax;
                  else
                    result = optimal1;
                end
            end
        return result;
      end
    
    else
      begin
        for (i = 0; i < 3; i = i + 1)
          for (j = 0; j < 3; j = j + 1)
            begin
              if (board[i][j] == 0)	// spot is empty
                begin
                  board[i][j] = ai;
                  temp_minimax = minimax(board, !maximize);
                  board[i][j] = 0; // undo the move
                  if (temp_minimax > optimal2)
                    result = optimal2;
                  else
                    result = temp_minimax;
                end
            end
        return result;
      end
  endfunction
  
  always @(board_state)	// what should this be?
    begin
      
      for (i = 0; i < 3; i = i +1)
        for (j = 0; j < 3; j = j + 1)
          begin
            if (board[i][j] == 0)	// if the spot is empty
              begin
                // making the move
                board_state[i][j] = ai;
                
                value = minimax(board_state, 0);
                
                board_state[i][j] = 0;	// undoing the move
                
                if (value > optimal_val)
                  begin
                    best_row = i;
                    best_col = j;
                    optimal_val = val;
                  end
              end
          end
      next_move [0] = best_row;
      next_move [1] = best_col;
    end
  
  
endmodule
