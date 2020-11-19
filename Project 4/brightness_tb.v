// Code your testbench here
// or browse Examples


module brightness_tb();
  reg clk;
  reg[7:0] image_input;
  reg[7:0] bright;
  reg do_bright;
  reg enable, enable_process;
  

  wire[7:0] image_output;
  wire finish;
  
 brightness brightness_tb(.clk(clk), .image_input(image_input), .bright(bright), .do_bright(do_bright), .enable(enable), .enable_process(enable_process), .image_output(image_output), .finish(finish));


reg [7:0] data; // needs to be an "integral number of bytes in length"


integer data_file ; // file handler
integer scan_file ; // file handler
`define NULL 0
reg [7:0] test[19:0];
reg [31:0] test_counter;


initial begin
  bright = 'd55;
  clk = 0;
  do_bright = 0;
  enable = 0;
  enable_process = 0;
  data_file = $fopen("noisy.txt", "r");
  if (data_file == `NULL) begin
  $display("data_file handle was NULL");
  $finish;
  end
  enable = 1;

 

  end

always @(posedge clk) begin
scan_file = $fscanf(data_file, "%d,",data);

if (!$feof(data_file)) begin
//use captured_data as you would any other wire or reg value;
image_input = data;
end
//$display("OUTPUT IS: %0d", image_output);
if (finish == 1)
begin
$display("FINISHED PROCESSING");
enable = 0;
enable_process = 1;
end



if (finish == 0 && enable_process == 1)
begin
enable_process = 0;
$display("FINISHED CALCULATION");
end

end


  always
	 #1 clk = !clk;
endmodule
