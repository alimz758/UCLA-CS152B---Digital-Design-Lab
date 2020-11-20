// Code your testbench here
// or browse Examples


module resize_filter_tb();


  reg scale;
  reg clk = 1;
  reg[7:0] image_input;
  reg enable = 0, enable_process = 0;
  

  wire[7:0] image_output;
  wire finish;

  parameter WIDTH = 410;
  parameter HEIGHT = 361;

  parameter padded_WIDTH = WIDTH + 1;
  parameter padded_HEIGHT = HEIGHT + 2;

  parameter FILTER_SIZE = 3;
  
resize_filter resize_filter_tb(.clk(clk), .scale(scale), .image_input(image_input), .enable(enable), .enable_process(enable_process), .image_output(image_output), .finish(finish));



integer fd = 0;
integer out_fd = 0;
integer i;

initial begin

enable = 1;
enable_process = 0;

fd = $fopen("noisy_image.text", "r");
for (i = 0; i < WIDTH * HEIGHT; i = i + 1) begin
	$fscanf(fd, "%d,", image_input);
	#2;
end
$fclose(fd);

enable = 0;
// scale = 1;
scale = 0;
enable_process = 1;
#1;

// out_fd = $fopen("resize_up.txt", "w");
out_fd = $fopen("resize_down.txt", "w");
//for (i = 0; i < (WIDTH*FILTER_SIZE) * (HEIGHT*FILTER_SIZE) - 1; i = i + 1) begin  // For scale up
for (i = 0; i < (padded_WIDTH/FILTER_SIZE) * (padded_HEIGHT/FILTER_SIZE) - 1; i = i + 1) begin	// For scale down
	$fwrite(out_fd, "%d,", image_output);
	//$display("%0d", image_output);
	#2;
end
$fwrite(out_fd, "%d", image_output);
#2;
$fclose(out_fd);

$finish;

end

always begin
	#1 clk = !clk;
end

endmodule
