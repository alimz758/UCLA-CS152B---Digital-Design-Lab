module divis3_tb();

reg [15:0] bcd;
wire out;
divis3 divis3_tb(.bcd(bcd), .out(out));

initial begin
  //bcd = 16'b1000_0011_0010_1001;   // 8329
  //bcd = 16'b0000000000100001;	//		21
  //bcd = 16'b0000_0000_0010_0010;		//  22
  //bcd = 16'b1001_1001_1001_1001;		// 9999
  //bcd = 16'b0000_0000_0011_0010;		// 32	alternate sum is -1
  //bcd = 16'b0000_0000_0011_0011;		// 33
  bcd = 16'b1001_1001_0000_0011;		//9903  alternate sum is -3
  #50
  
  $display("%b", out);
  $finish;
  
end

endmodule
