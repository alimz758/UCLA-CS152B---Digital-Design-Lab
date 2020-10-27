module traffic_light_controller(walk_light, main_green, main_yellow, main_red, 
				side_green, side_yellow, side_red, clk, sensor, walk_button);

input clk, sensor, walk_button;
output reg walk_light, main_green, main_yellow, main_red, 
	side_green, side_yellow, side_red;



// defining 8 states
parameter state1 = 3'b000,
          state2 = 3'b001,
          state3 = 3'b010,
          state4 = 3'b011,
          state5 = 3'b100,
          state6 = 3'b101,
          state7 = 3'b110,
          state8 = 3'b111;
parameter SIZE = 3;

reg [SIZE-1:0] cur_state;
reg [SIZE-1:0] next_state;

reg [2:0] timer;

//changing the clk frequency
clock clock(.clk(clk), .out(new_clk));

//setting walk and timer to 0 
initial begin 
	timer = 0;
	walk_light = 0;
end

//assigning the next state
always @(cur_state or walk_button or sensor) begin
	next_state = 3'b000;
	case(cur_state)
		//first state, main street green and side sreet red
		state1:
			if (sensor == 1'b0 && timer == 3'b110)
				next_state <= state2;
			else if (sensor == 1'b1 && timer == 3'b110)
				next_state <= state3;
			else 
				next_state <= state1;
		//second state, half way(6s) of main green
		state2:
			if (timer == 3'b110) 
				next_state <= state4;
			else
				next_state <= state2;
		// half way(6s) main street green 
		state3:
			if (timer == 3'b011) 
				next_state <= state4;
			else
				next_state <= state3;
		//main yellow
		state4:
			if (walk_button == 1'b0  && timer == 3'b010) 
				next_state <= state5;
			else if (walk_button == 1'b1  && timer == 3'b010) begin
				walk_light = 1;
				next_state <= state6;
			end
			else 
				next_state <= state4;
		// main red and side green
		state5:
			if (sensor == 1'b0 && timer >=3'b110) 
				next_state <= state7;
			else if (sensor == 1'b1 && timer >=3'b110) 
				next_state <= state8;
			else 
				next_state <= state5;
		// main red, side red		
		state6:
			if (timer == 3'b011) begin
				walk_light = 0;
				next_state <= state5;
			end
			else
				next_state <= state6;
		//main red, side yellow
		state7:
			if (timer == 3'b010)
				next_state <= state1;
			else 
				next_state <= state7;
		///main red side green
		state8:
			if (timer == 3'b011)
				next_state <= state7;
			else 
				next_state <= state8;
		endcase
end

//updating timer
always @(posedge new_clk) begin
	//if state has been changed
	if (next_state != cur_state) begin
		cur_state = next_state;
		timer = 3'b000;
	end
	timer = timer + 3'b001;
end


//TODO: Updating light registers depending on cur_state

endmodule