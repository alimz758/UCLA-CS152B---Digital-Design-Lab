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
parameter WIDTH = 410;
parameter HEIGHT = 361;
parameter TOTAL = 148010;
//parameter WIDTH = 4;
//parameter HEIGHT = 5;
//parameter FILTER_SIZE = 3;

// image buffer to read the input image into
//reg [7:0] image_buff[0:WIDTH][0:HEIGHT];
reg [8:0] image_buff[0:WIDTH-1][0:HEIGHT-1];
reg [13:0] read_loc_width = 0;
reg [13:0] read_loc_height = 0;
  
integer i, j;

reg temp_finish;

reg[17:0] counter = 0;

reg[17:0] counter2 = 0;


reg [7:0] temp_output;
reg [7:0] temp_bright;


integer f;
//assign image_output = temp_output;
//assign bright = temp_bright;
assign image_output = temp_output;

assign finish = temp_finish;

initial
f = $fopen ("dim.txt", "w");

always @(posedge clk) begin
	if (enable) 
      begin
		// read the image_input into our buffer at read_loc_width, read_loc_height
		if (counter != 0)
		begin
		//$display("counter is %0d", counter);
		image_buff[read_loc_width][read_loc_height] = image_input;
		//$display("LOC WIDTH: %d, LOC HEIGHT: %d", read_loc_width, read_loc_height);
		//$display("input is: %0d", image_input);
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
	if (counter == (TOTAL))
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
		  if (image_buff[j][i] > 'd255)
			image_buff[j][i] = 255;
		 else
		       temp_output = image_buff[j][i];
		//$display("temp_output is for i = %0d & j = %0d: %0d",i,j, temp_output);
		$fwrite(f, "%0d,", temp_output);
		counter2 = counter2 + 1;
		//$display("counter = %0d", counter2);
                end
            end
	if (counter2 == TOTAL)
		temp_finish = 0;
	else
		temp_finish = 1;
        end
      else if (do_bright == 0)
	begin  
          for (i = 0; i < HEIGHT; i = i + 1)
            begin
              for (j = 0; j < WIDTH; j = j + 1)
		begin
                  image_buff[j][i] = image_buff[j][i] - bright;
		       temp_output = image_buff[j][i];
		//$display("temp_output is for i = %0d & j = %0d: %0d",i,j, temp_output);
		$fwrite(f, "%0d,", temp_output);
		counter2 = counter2 + 1;
		//$display("counter = %0d", counter2);
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
