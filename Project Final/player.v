module player(clk, board_state, next_move1, next_move2);

	input clk;
	input wire [1:0] board_state;
	output reg[1:0] next_move1;	//output the row
	output reg[1:0] next_move2;  // output the column

	integer row;
	integer col;

	reg [1:0] temp_board[0:2][0:2];

	initial begin	
		$display("Please enter where on the grid you want to play your move\n");
		$display("Fist number is the row number from 0-2\n");
		$display("Second number is the row number from 0-2\n");
		$scanf("%d%d", row, col);
		$display(row, col);
	end

	always @(posedge clk) begin
		if (temp_board[row][col] == 0) begin
			next_move1 = row;
			next_move2 = col;
		end 
		// invalid entries
		else begin
			$display("Invalid entries, please re-enter valid entries");
		end
	end
endmodule;