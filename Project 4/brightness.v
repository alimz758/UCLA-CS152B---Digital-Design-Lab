// Code your design here
module brightness (
image_input, do_bright, bright, enable, enable_process, clk, image_output, finish);

// inputs
input wire[7:0] image_input;
input wire[7:0] bright;
input wire do_bright;
input wire enable, enable_process, clk;

// outputs
output reg[7:0] image_output;
output reg finish;

// the width and height of the cat picture
parameter WIDTH = 410;
parameter HEIGHT = 361;
parameter TOTAL = 148010;
//parameter WIDTH = 4;
//parameter HEIGHT = 5;
//parameter FILTER_SIZE = 3;

// image buffer to read the input image into
//reg [7:0] image_buff[0:WIDTH][0:HEIGHT];
reg [7:0] image_buff[0:WIDTH-1][0:HEIGHT-1];
reg [9:0] read_loc_width = 0;
reg [9:0] read_loc_height = 0;

reg[9:0] write_loc_height = 0;
reg[9:0] write_loc_width = 0;
  
integer i, j;



always @(posedge clk) begin
	if (enable) 
      begin
		// read the image_input into our buffer at read_loc_width, read_loc_height
		image_buff[read_loc_width][read_loc_height] = image_input;
		//$display("LOC WIDTH: %d, LOC HEIGHT: %d", read_loc_width, read_loc_height);
		// move to the next pixel in the same height
		// $display("INPUT IS: %0d", image_input);
		read_loc_width = read_loc_width + 1;
		if (read_loc_width == WIDTH) 
          	begin
			// wrap around to the first column and increment height
			read_loc_width = 0;
			read_loc_height = read_loc_height + 1;
			if (read_loc_height == HEIGHT) 
              		begin
				// wrap around back to the first row
				read_loc_height = 0;
			end
		end
	finish = 0;
	end 
  else if (enable_process)
    begin
      if (do_bright == 1)
	begin 
	if ( (image_buff[write_loc_width][write_loc_height] + bright) > 255) begin
	image_output = 255;
	end
	else begin
	image_output = image_buff[write_loc_width][write_loc_height] + bright;
	end
	write_loc_width = write_loc_width + 1;
	if (write_loc_width == WIDTH)
		begin
			write_loc_width = 0;
			write_loc_height = write_loc_height + 1;
			if (write_loc_height == HEIGHT)
			begin
				finish = 1;
				write_loc_height = 0;
			end
		end
        end
      else if (do_bright == 0) 
	begin 
	if (image_buff[write_loc_width][write_loc_height] < bright) begin
	image_output = 0;
	end
	else begin
	image_output = image_buff[write_loc_width][write_loc_height] - bright;
	end
	write_loc_width = write_loc_width + 1;
	if (write_loc_width == WIDTH)
		begin
			write_loc_width = 0;
			write_loc_height = write_loc_height + 1;
			if (write_loc_height == HEIGHT)
			begin
				finish = 1;
				write_loc_height = 0;
			end
		end
        end
end
end


endmodule
