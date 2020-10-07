module divis3(
  input [15:0] bcd,
  output out
);
  
  
  
reg [5:0] sum; // maximum number is 100100
reg[2:0] fin;
reg temp;
  
  always @(bcd)
    begin
	  sum = 6'b000000;
      fin = 3'b000;
      sum = bcd[15:12] + bcd[11:8] + bcd[7:4] + bcd[3:0];
      
      fin = sum[0]-sum[1]+sum[2]-sum[3]+sum[4]-sum[5];

      if (fin == 2'b00 || fin == 2'b11 ) begin
        temp = 1'b1;
      end
      else 
        temp = 1'b0; 
    end
  assign out = temp;
endmodule
