
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
//parameter WIDTH = 4;
//parameter HEIGHT = 5;
parameter RESIZE_SIZE = 3;
parameter TOTAL = 148010;

// image buffer to read the input image into
reg [7:0] image_buff[0:WIDTH-1][0:HEIGHT-1];
reg [13:0] read_loc_width = 0;
reg [13:0] read_loc_height = 0;

reg[17:0] counter = 0;
reg[17:0] counter2 = 0;
  
  
integer i, j, k, l;
  
// creating a new bigger matrix to store the larger image
reg [7:0] up_image_buff[0:(WIDTH*RESIZE_SIZE)-1][0:(HEIGHT*RESIZE_SIZE)-1];
  
// padding process
parameter padded_WIDTH = WIDTH + 1;
parameter padded_HEIGHT = HEIGHT + 2;

// for 5 X 4 with resize = 3
//parameter padded_WIDTH = WIDTH + 2;
//parameter padded_HEIGHT = HEIGHT + 1;
integer a, b, c, d, sum;
  
reg [7:0] down_padded_image_buff[0:(padded_WIDTH)-1][0:(padded_HEIGHT)-1];  
reg [7:0] down_image_buff[0:((padded_WIDTH)/RESIZE_SIZE)-1][0:((padded_HEIGHT)/RESIZE_SIZE)-1];

reg temp_finish;

integer f;

assign finish = temp_finish;

initial 
f = $fopen ("down.txt", "w");
always @(posedge clk) begin
	if (enable) begin
		if (counter != 0)
		begin
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
	end 
	counter = counter + 1;
	if (counter == (TOTAL))
		temp_finish = 1;
	else
		temp_finish = 0;
	end 

	else if (enable_process) begin
      if (scale == 1) // increase size
        begin	
          // going through the original matrix and then dividing it up depending on the RESIZE_SIZE
          for (i = 0; i < HEIGHT*RESIZE_SIZE; i = i + 1)
              for (j = 0; j < WIDTH*RESIZE_SIZE; j = j + 1)
		begin
                  for (k = 0; k < RESIZE_SIZE; k = k + 1)
                      for (l = 0; l < RESIZE_SIZE; l = l + 1)
			begin
                          up_image_buff[j*RESIZE_SIZE+l][i*RESIZE_SIZE+k] = image_buff[j][i];
			end
		  	//$display("UP IMAGE BUFF i = %0d  j = %0d -- %0d", i, j, up_image_buff[j][i]);
			$fwrite(f, "%d,", up_image_buff[j][i]);
		end
			
          temp_finish = 1;
 	 $fclose(f);
        end
      else if (scale == 0)
        begin
          // going through the original matrix and then dividing it up depending on the RESIZE_SIZE
          // TODO: what about cases where we don't have perfect number of pixels, so 
          // some pixels are not covered by the window size
          
          // making everything in the padded array 0
	  // This works
          for (i = 0; i < padded_HEIGHT; i = i + 1)
            begin
              for (j = 0; j < padded_WIDTH; j = j + 1)
                begin
                  down_padded_image_buff[j][i] = 0;
		 //$display("INITIAL PADDED MATRIX i = %d  j = %d -- %d",i, j, down_padded_image_buff[i][j]);
                end
            end
          
                  
          // transferring original array to the padded array
          for (i = 0; i < HEIGHT; i = i + 1)
            begin
              for (j = 0; j < WIDTH; j = j + 1)
                begin
                  down_padded_image_buff[j][i] = image_buff[j][i]; 
                end
            end
          
          
          
          for (i = 0; i < padded_HEIGHT/RESIZE_SIZE; i = i + 1)  // i < 2
            begin
            for (j = 0; j < padded_WIDTH/RESIZE_SIZE; j = j + 1)
              begin
              sum = 0;
                  for (k = 0; k < RESIZE_SIZE; k = k + 1)
                    begin
                      for (l = 0; l < RESIZE_SIZE; l = l + 1)
                        begin
                          sum = sum + down_padded_image_buff[j*RESIZE_SIZE+l][i*RESIZE_SIZE+k];
                        end
                    end
			  down_image_buff[j][i] = sum / (RESIZE_SIZE*RESIZE_SIZE);
			  //$display("DOWN IMAGE BUFF i = %0d  j = %0d -- %0d", i, j, down_image_buff[j][i]);
		 	 $fwrite(f, "%0d,", down_image_buff[j][i]);
              end
            end
 	if (counter2 == TOTAL)
		temp_finish = 0;
	else
		temp_finish = 1;
        end
      $fclose(f);
	end
end

endmodule