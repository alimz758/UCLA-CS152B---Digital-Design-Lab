module median_filter (
image_input, enable, enable_process, clk, image_output, finish
);

// inputs
input wire[7:0] image_input;
input wire enable, enable_process, clk;

// outputs
output wire[7:0] image_output;
output wire finish;

// the width and height of the cat picture
parameter WIDTH = 410;
parameter HEIGHT = 361;
parameter FILTER_SIZE = 3;
parameter TOTAL_WINDOW_SIZE =  FILTER_SIZE * FILTER_SIZE;
parameter middle = TOTAL_WINDOW_SIZE >> 1; //divide by 2

// image buffer to read the input image into
reg [7:0] image_buff[0:WIDTH][0:HEIGHT];
reg [7:0] final_output[0:WIDTH][0:HEIGHT];
reg [14:0] read_loc_width = 0;
reg [14:0] read_loc_height = 0;
reg [7:0] window_array[0:TOTAL_WINDOW_SIZE]; 
reg [7:0] temp;
reg [TOTAL_WINDOW_SIZE-1:0] WINDOW_COUNTER = 0;
integer i, j, k, z;

always @(posedge clk) begin
	if (enable) begin
		// read the image_input into our buffer at read_loc_width, read_loc_height
		image_buff[read_loc_width][read_loc_height] = image_input;
		// move to the next pixel in the same height
		read_loc_width = read_loc_width + 1;
		if (read_loc_width == WIDTH) begin
			// wrap around to the first column and increment height
			read_loc_width = 0;
			read_loc_height = read_loc_height + 1;
			if (read_loc_height == HEIGHT) begin
				// wrap around back to the first row
				read_loc_height = 0;
			end
		end
	end else if (enable_process) begin
		// TODO: implement filtering process
		for (i=0; i<WIDTH; i=i+1) begin
			for (j=0; j<HEIGHT; j=j+1) begin
				for (k=0; k<FILTER_SIZE; k=k+1) begin
					if (i+k-middle<0 || i+k-middle>WIDTH-1) begin
						//add zero to window array
						window_array[WINDOW_COUNTER] = 0;
						WINDOW_COUNTER = WINDOW_COUNTER + 1;
					end
					else begin
						if (j+k-middle<0 || j+middle>HEIGHT-1) begin
							//add zero to the window array
							window_array[WINDOW_COUNTER] = 0;
							WINDOW_COUNTER = WINDOW_COUNTER + 1;
						end
						else begin
							for (z=0; z<FILTER_SIZE; z=z+1) begin
								window_array[WINDOW_COUNTER] = image_buff[i+k-middle][j+z-middle];
								WINDOW_COUNTER = WINDOW_COUNTER + 1; 
							end
						end
					end
				end
				//sort the window
				for (i=0; i<TOTAL_WINDOW_SIZE-1; i=i+1) begin
					for (j=0; j<TOTAL_WINDOW_SIZE-i-1; j=j+1) begin
						if (window_array[j]>window_array[j+1]) begin
							temp = window_array[j];
							window_array[j] = window_array[j+1];
							window_array[j+1] = temp;
						end
					end
				end
				final_output[i][j] = window_array[middle];
				//empty window
				WINDOW_COUNTER = 0;
			end
		end
		
	end
end

endmodule
