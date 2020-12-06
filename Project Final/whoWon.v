
module whoWon(clk, board_state, who_won);

	input clk;
	input [1:0] board_state[0:2][0:2]; // 0: p1, 1:p2/AI, 2: empty
	output reg [2:0] who_won; // 0: p1, 1: p2 orAI, 2 draw, 3 not over yet
	reg temp = 0;
	reg [2:0] temp_win;
	integer i, j;

	always @(posedge clk) begin
		
		// first row pattern
		if (board_state[0][0] == board_state[0][1] && board_state[0][0] ==  board_state[0][2]) begin
			if (board_state[0][0] == 0) 
				temp_win = 0;
			else if (board_state[0][0] == 1)
				temp_win = 1;
		end
		// second row pattern
		else if (board_state[1][0] == board_state[1][1] && board_state[1][0] ==  board_state[1][2]) begin
			if (board_state[1][0] == 0) 
				temp_win = 0;
			else if (board_state[1][0] == 1)
				temp_win = 1;
		end
		// third row pattern
		else if (board_state[2][0] == board_state[2][1] && board_state[2][0] ==  board_state[2][2]) begin
			if (board_state[2][0] == 0) 
				temp_win = 0;
			else if (board_state[2][0] == 1)
				temp_win = 1;
		end
		// first col pattern
		else if (board_state[0][0] == board_state[1][0] && board_state[0][0] ==  board_state[2][0]) begin
			if (board_state[0][0] == 0) 
				temp_win = 0;
			else if (board_state[0][0] == 1)
				temp_win = 1;
			$display("in won ", temp_win);
		end
		// second col pattern
		else if (board_state[0][1] == board_state[1][1] && board_state[0][1] ==  board_state[2][1]) begin
			if (board_state[0][1] == 0) 
				temp_win = 0;
			else if (board_state[0][1] == 1)
				temp_win = 1;
		end
		// third col pattern
		else if (board_state[0][2] == board_state[1][2] && board_state[0][2] ==  board_state[2][2]) begin
			if (board_state[0][2] == 0) 
				temp_win = 0;
			else if (board_state[0][2] == 1)
				temp_win = 1;
		end
		// main diag pattern
		else if (board_state[0][0] == board_state[1][1] && board_state[0][0] ==  board_state[2][2]) begin
			if (board_state[0][0] == 0) 
				temp_win = 0;
			else if (board_state[0][0] == 1)
				temp_win = 1;
		end
		// 2nd diag pattern
		else if (board_state[0][2] == board_state[1][1] && board_state[0][2] ==  board_state[2][0]) begin
			if (board_state[0][2] == 0) 
				temp_win = 0;
			else if (board_state[0][2] == 1)
				temp_win = 1;
		end
		else begin
			
			for (i=0; i<3; i=i+1) begin
				for (j=0; j<3; j=j+1) begin
					if (board_state[i][j] == 2) begin
						temp = 1;
						
					end
				end
			end
			if (temp == 1)
				temp_win = 3; //not over yet
			else
				temp_win = 2; //draw
		end
		
	end
	assign who_won = temp_win;
endmodule;