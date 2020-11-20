// Code your testbench here
// or browse Examples


module brightness_tb();
  reg clk = 1;
  reg[7:0] image_input;
  reg[7:0] bright;
  reg do_bright;
  reg enable = 0, enable_process = 0;
  

  wire[7:0] image_output;
  wire finish;

  parameter WIDTH = 410;
  parameter HEIGHT = 361;
  
 brightness brightness_tb(.clk(clk), .image_input(image_input), .bright(bright), .do_bright(do_bright), .enable(enable), .enable_process(enable_process), .image_output(image_output), .finish(finish));


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

// do_bright = 1;
do_bright = 0;

bright = 70;
enable_process = 1;
#1;

//out_fd = $fopen("brightness_up.txt", "w");
out_fd = $fopen("brightness_down.txt", "w");
for (i = 0; i < WIDTH * HEIGHT - 1; i = i + 1) begin
	$fwrite(out_fd, "%d,", image_output);
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
