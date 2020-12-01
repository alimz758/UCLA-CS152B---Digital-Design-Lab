
// Code your design here
module resize_filter (
image_input, scale, enable, enable_process, clk, image_output, finish
);

// inputs
input wire[7:0] image_input;
input wire enable, enable_process, clk;
input wire scale; 	// scale = 1 increase, scale = 0 decrease

// outputs
output reg[7:0] image_output;
output reg finish;

// the width and height of the cat picture
parameter WIDTH = 410;
parameter HEIGHT = 361;
parameter RESIZE_SIZE = 3;
parameter TOTAL = 148010;

// padding process
parameter padded_WIDTH = WIDTH + 1;
parameter padded_HEIGHT = HEIGHT + 2;

// image buffer to read the input image into
reg [7:0] image_buff[0:WIDTH-1][0:HEIGHT-1]; 	// original image
reg [9:0] read_loc_width = 0;
reg [9:0] read_loc_height = 0;

reg [9:0] write_loc_height = 0;
reg [9:0] write_loc_width = 0;

reg [10:0] padded_write_loc_height = 0;
reg [10:0] padded_write_loc_width = 0;

reg [10:0] write_up_height = 0;
reg [10:0] write_up_width = 0;

integer i, j, k, l;
integer sum = 0;

integer stop = 0;
  
// creating a new bigger matrix to store the larger image
reg [7:0] up_image_buff[0:(WIDTH*RESIZE_SIZE)-1][0:(HEIGHT*RESIZE_SIZE)-1];
  

always @(posedge clk) begin
	if (enable) begin
		// read the image_input into our buffer at read_loc_width, read_loc_height
		image_buff[read_loc_width][read_loc_height] = image_input;
		//$display("INPUT IS: %0d", image_input);
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
	end 
  else if (enable_process) begin
      if (scale == 1) begin
		if (!stop) begin
                  for (k = 0; k < RESIZE_SIZE; k = k + 1) begin
                      for (l = 0; l < RESIZE_SIZE; l = l + 1) begin
		          up_image_buff[write_loc_width*RESIZE_SIZE+l][write_loc_height*RESIZE_SIZE+k] = image_buff[write_loc_width][write_loc_height];
			end
		  end 
		end
	image_output = up_image_buff[write_up_width][write_up_height];
	write_up_width = write_up_width + 1;
	if (write_up_width == WIDTH*RESIZE_SIZE)
		begin
			write_up_width = 0;
			write_up_height = write_up_height + 1;
			if (write_up_height == HEIGHT*RESIZE_SIZE)
			begin
				finish = 1;
				write_up_height = 0;
			end
		end
	write_loc_width = write_loc_width + 1;
	if (write_loc_width == WIDTH)
		begin
			write_loc_width = 0;
			write_loc_height = write_loc_height + 1;
			if (write_loc_height == HEIGHT)
			begin
				stop = 1;
				write_loc_height = 0;
			end
		end
end
      else if (scale == 0) begin
          sum = 0;
          for (i = 0; i < RESIZE_SIZE; i = i + 1) begin
		for (j = 0; j < RESIZE_SIZE; j = j +1) begin
		// Virtual Padding
			if (((write_loc_width + j) >= WIDTH) || ((write_loc_height + i) >= HEIGHT)) begin
			sum = sum + 0;
			end
			else begin
				sum = sum + image_buff[write_loc_width+j][write_loc_height + i];
			end
		end
	end
	//$display("avg %0d", sum / (RESIZE_SIZE*RESIZE_SIZE));
        image_output = sum / (RESIZE_SIZE*RESIZE_SIZE);
	write_loc_width = write_loc_width + RESIZE_SIZE;
	if (write_loc_width == WIDTH+1)
		begin
			write_loc_width = 0;
			write_loc_height = write_loc_height + RESIZE_SIZE;
			if (write_loc_height == HEIGHT+2)
			begin
				finish = 1;
				write_loc_height = 0;
			end
		end
        end
end
end
endmodule
