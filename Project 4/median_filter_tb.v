module median_filter_tb;

reg [7:0] image_input;
reg enable = 0;
reg enable_process = 0;
reg clk = 1;
wire [7:0] image_output;
wire finish;

parameter WIDTH = 410;
parameter HEIGHT = 361;
parameter FILTER_SIZE = 3;

median_filter median_filter(
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

enable = 0;
enable_process = 1;
#1;

out_fd = $fopen("median_filter.text", "w");
for (i = 0; i < WIDTH * HEIGHT - 1; i = i + 1) begin
	$fwrite(out_fd, "%d,", image_output);
	#2;
end
$fwrite(out_fd, "%d", image_output);
#2;

$finish;

end

always begin
	#1 clk = !clk;
end

endmodule