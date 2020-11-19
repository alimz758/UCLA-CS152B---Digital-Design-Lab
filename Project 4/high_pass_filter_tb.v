module high_pass_filter_tb;

reg [7:0] image_input;
reg enable = 0;
reg enable_process = 0;
reg clk = 1;
wire [7:0] image_output;
wire finish;

parameter WIDTH = 410;
parameter HEIGHT = 361;
parameter FILTER_SIZE = 3;

high_pass_filter high_pass_filter(
.image_input(image_input),
.enable(enable),
.enable_process(enable_process),
.clk(clk),
.image_output(image_output),
.finish(finish)
);

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
enable_process = 1;
#1;

out_fd = $fopen("high_pass_filter.text", "w");
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
