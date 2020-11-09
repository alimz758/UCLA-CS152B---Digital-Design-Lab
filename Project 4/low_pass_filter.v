module low_pass_filter (
image_input, enable, enable_process, clk, image_output, finish
);

input wire[7:0] image_input;
input wire enable, enable_process, clk;

output wire[7:0] image_output;
output wire finish;

always @(posedge clk) begin

end

endmodule
