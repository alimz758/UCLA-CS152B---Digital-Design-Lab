// Code your design here
module resize_filter (
image_input, scale, enable, enable_process, clk, image_output, finish
);

// inputs
input wire[7:0] image_input;
input wire enable, enable_process, clk;
input wire scale; 	// scale = 1 increase, scale = 0 decrease

// outputs
output wire[7:0] image_output;
output wire finish;

// the width and height of the cat picture
parameter WIDTH = 410;
parameter HEIGHT = 361;
parameter RESIZE_SIZE = 3;

// image buffer to read the input image into
reg [7:0] image_buff[0:WIDTH][0:HEIGHT];
reg [7:0] read_loc_width = 0;
reg [7:0] read_loc_height = 0;
  
  
  
integer i, j, k, l;
integer sum;
  
// creating a new bigger matrix to store the larger image
reg [7:0] up_image_buff[0:(WIDTH*RESIZE_SIZE)][0:(HEIGHT*RESIZE_SIZE)];
  
// padding process
parameter padded_WIDTH = WIDTH + 1;
parameter padded_HEIGHT = HEIGHT + 2;
integer a, b, c, d, sum;
  
reg [7:0] down_padded_image_buff[0:(padded_WIDTH)][0:(padded_HEIGHT)];  
reg [7:0] down_image_buff[0:((padded_WIDTH)/RESIZE_SIZE)][0:((padded_HEIGHT)/RESIZE_SIZE)]



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
      if (scale == 1) // increase size
        begin	
          // going through the original matrix and then dividing it up depending on the RESIZE_SIZE
          for (i = 0; i < WIDTH; i = i + 1)
              for (j = 0; j < HEIGHT; j = j + 1)
                  for (k = 0; k < RESIZE_SIZE; k = k + 1)
                      for (l = 0; l < RESIZE_SIZE; l = l + 1)
                          up_image_buff[i*RESIZE_SIZE+k][j*RESIZE_SIZE+l] = image_buff[i][j];
          
        end
      else if (scale == 0)
        begin
          // going through the original matrix and then dividing it up depending on the RESIZE_SIZE
          // TODO: what about cases where we don't have perfect number of pixels, so 
          // some pixels are not covered by the window size
          
          // making everything in the padded array 0
          for (i = 0; i < padded_WIDTH; i = i + 1)
            begin
              for (j = 0; j < padded_HEIGHT; j = j + 1)
                begin
                  down_padded_image_buff[i][j] = 0;
                end
            end
          
                  
          // transferring original array to the padded array
          for (i = 0; i < WIDTH; i = i + 1)
            begin
              for (j = 0; j < HEIGHT; j = j + 1)
                begin
                  down_padded_image_buff[i][j] = image_buff[i][j]; 
                end
            end
          
          
          
          for (i = 0; i < WIDTH/RESIZE_SIZE; i = i + 1)
            begin
            for (j = 0; j < HEIGHT/RESIZE_SIZE; j = j + 1)
              begin
              sum = 0;
                  for (k = 0; k < RESIZE_SIZE; k = k + 1)
                    begin
                      for (l = 0; l < RESIZE_SIZE; l = l + 1)
                        begin
                          sum = sum + down_padded_image_buff[i*RESIZE_SIZE+k][j*RESIZE_SIZE+l];
                          
                          down_image_buff = sum / (RESIZE_SIZE*RESIZE_SIZE);
                        end
                    end
              end
            end
        end
      
	end
end

endmodule
