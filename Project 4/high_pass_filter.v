module high_pass_filter (
image_input, enable, enable_process, clk, image_output, finish
);

// inputs
input wire [7:0] image_input;
input wire enable, enable_process, clk;

// outputs
output reg [7:0] image_output;
output reg finish;

// the width and height of the cat picture
parameter WIDTH = 410;
parameter HEIGHT = 361;
parameter FILTER_SIZE = 3;

// image buffer to read the input image into
reg [7:0] image_buff[0:WIDTH+2][0:HEIGHT+2];
reg [9:0] read_loc_width = 0;
reg [9:0] read_loc_height = 0;

reg [9:0] write_loc_width = 0;
reg [9:0] write_loc_height = 0;

reg [11:0] sum = 0;

integer i;
integer j;

initial begin
	for (i = 0; i < WIDTH+2; i = i + 1) begin
		for (j = 0; j < HEIGHT+2; j = j + 1) begin
			image_buff[i][j] = 0;
		end
	end
end

always @(posedge clk) begin
	if (enable) begin
		// read the image_input into our buffer at read_loc_width, read_loc_height
		image_buff[read_loc_width + 1][read_loc_height + 1] = image_input;
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
		finish = 0;
	end else if (enable_process) begin
		// take the sum before average
		sum = 0;
		for (i = write_loc_width; i < write_loc_width + FILTER_SIZE; i = i + 1) begin
			for (j = write_loc_height; j < write_loc_height + FILTER_SIZE; j = j + 1) begin
				sum = sum + image_buff[i][j];
			end
		end
		// subtract the average from the current pixel to sharpen
		sum = sum / 9;
		if (image_buff[write_loc_width+1][write_loc_height+1] < sum) begin
			image_output = 0;
		end else if (image_buff[write_loc_width+1][write_loc_height+1] - sum > 255) begin
			image_output = 255;
		end else begin
			image_output = image_buff[write_loc_width+1][write_loc_height+1] - sum;
		end

		// move to next pixel
		write_loc_width = write_loc_width + 1;
		if (write_loc_width == WIDTH) begin
			// wrap around to the first column and increment height
			write_loc_width = 0;
			write_loc_height = write_loc_height + 1;
			if (write_loc_height == HEIGHT) begin
				// wrap around back to the first row
				finish = 1;
				write_loc_height = 0;
			end
		end
	end
end

endmodule
