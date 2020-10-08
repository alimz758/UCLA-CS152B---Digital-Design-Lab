module divis3_tb();

reg [15:0] bcd;
wire out;
divis3 divis3_tb(.bcd(bcd), .out(out));
localparam t = 200;

initial begin
	
  
  bcd = 16'b1000_0011_0010_1001;   // 8329
  #t
  $display("BCD = 8329 | Result: %b", out);
  #t
  bcd = 16'b0000000000100001;	//		21
  #t
  $display("BCD = 21 | Result: %b", out);
  #t
  bcd = 16'b0000_0000_0010_0010;		//  22
  #t
  $display("BCD = 22 | Result: %b", out);
  #t
  bcd = 16'b1001_1001_1001_1001;		// 9999
  #t
  $display("BCD = 9999 | Result: %b", out);
  #t
  bcd = 16'b0000_0000_0011_0010;		// 32
  #t
  $display("BCD = 32 | Result: %b", out);
  #t
  bcd = 16'b0000_0000_0011_0011;		// 33
  #t
  $display("BCD = 33 | Result: %b", out);
  #t
  bcd = 16'b1001_1001_0000_0011;		//9903
  #t
  $display("BCD = 9903 | Result: %b", out);
  #t
  bcd = 16'b0000_0000_0000_0000;		//0
  #t
  $display("BCD = 0 | Result: %b", out);
  
  
  $finish;
  
end

endmodule
