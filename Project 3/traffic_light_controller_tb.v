module traffic_light_controller_tb();
  reg clk, sensor, walk_button;
  wire walk_light, main_green, main_yellow, main_red, side_green, side_yellow, side_red, new_clk;
  
  
  traffic_light_controller traffic_light_controller_tb(.clk(clk), .sensor(sensor), .walk_button(walk_button), .walk_light(walk_light), .main_green(main_green), .main_yellow(main_yellow), .main_red(main_red), .side_green(side_green), .side_yellow(side_yellow), .side_red(side_red), .new_clk(new_clk));
  
  //initial begin
  //$dumpfile("dump.vcd");
  //$dumpvars;
  //#5000
  //$finish;
	//end
  
initial begin
	clk = 0;
	sensor = 0;
	walk_button = 0;
	#10000
	sensor = 1;
	#7000
	sensor = 0;
	#3000
	walk_button = 1;
	#7000
	walk_button = 0;
	#7000
	$finish;
end
  
  always
	#20 clk = !clk;
endmodule
