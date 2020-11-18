// Code your design here
module brightness (
image_input, do_bright, bright, enable, enable_process, clk, image_output, finish);

// inputs
input wire[7:0] image_input;
input wire[7:0] bright;
input wire do_bright;
input wire enable, enable_process, clk;

// outputs
output wire[7:0] image_output;
output wire finish;

// the width and height of the cat picture
//parameter WIDTH = 410;
//parameter HEIGHT = 361;
parameter WIDTH = 4;
parameter HEIGHT = 5;
//parameter FILTER_SIZE = 3;

// image buffer to read the input image into
//reg [7:0] image_buff[0:WIDTH][0:HEIGHT];
reg [7:0] image_buff[0:WIDTH-1][0:HEIGHT-1];
reg [7:0] read_loc_width = 0;
reg [7:0] read_loc_height = 0;
  
integer i, j;

reg temp_finish;

reg[31:0] counter = -1;

reg[31:0] counter2 = 0;


reg [7:0] temp_output;

assign image_output = temp_output;
//genvar a, b;

	//for (a = 0; a < WIDTH; a = a +1)
		//for (b = 0; b < HEIGHT; b = b +1)
			//assign image_output = image_buff[a][b];


assign finish = temp_finish;

always @(posedge clk) begin
	if (enable) 
      begin
		// read the image_input into our buffer at read_loc_width, read_loc_height
		if (counter != -1)
		begin
		image_buff[read_loc_width][read_loc_height] = image_input;
		$display("input is: %0d", image_input);
		// move to the next pixel in the same height
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
		end
	counter = counter + 1;
	if (counter == 19)
		temp_finish = 1;
	else
		temp_finish = 0;
	end 
  else if (enable_process)
    begin
      if (do_bright == 1)
        begin  
          for (i = 0; i < HEIGHT; i = i + 1)
            begin
              for (j = 0; j < WIDTH; j = j + 1)
		begin
                  image_buff[j][i] = image_buff[j][i] + bright;
		  temp_output = image_buff[j][i];
		$display("temp_output is for i = %0d & j = %0d: %0d",i,j, temp_output);
		counter2 = counter2 + 1;
		$display("counter = %0d", counter2);
                end
            end
	if (counter2 == 20)
		temp_finish = 0;
	else
		temp_finish = 1;
        end
      else if (do_bright == 0)
        begin
          for (i = 0; i < WIDTH; i = i + 1)
            begin
              for (j = 0; j < HEIGHT; j = j + 1)
                begin
                  image_buff[i][j] = image_buff[i][j] - bright;
                end
            end
        end
	
      end
end

endmodule
