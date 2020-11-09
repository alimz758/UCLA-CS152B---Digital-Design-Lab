module low_pass_filter (
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

// image buffer to read the input image into
reg [7:0] image_buff[0:WIDTH][0:HEIGHT];
reg [7:0] read_loc_width = 0;
reg [7:0] read_loc_height = 0;

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
	end
end

endmodule
