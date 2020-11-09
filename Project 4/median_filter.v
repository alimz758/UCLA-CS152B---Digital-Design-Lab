module median_filter (
image_input, enable, enable_process, clk, image_output, finish
);

// inputs
input wire[7:0] image_input;
input wire enable, enable_process, clk;

// outputs
output wire[7:0] image_output;
output wire finish;

// the width and height of the cat picture
parameter WIDTH = 410;
parameter HEIGHT = 361;
parameter FILTER_SIZE = 3;

// image buffer to read the input image into
reg [7:0] image_buff[0:WIDTH][0:HEIGHT];

always @(posedge clk) begin

end

endmodule
