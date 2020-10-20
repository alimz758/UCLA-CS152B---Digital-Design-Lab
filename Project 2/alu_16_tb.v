// Code your testbench here
// or browse Examples
module alu_16_tb();

  reg signed [15:0] A,B;
  	reg [3:0] ALUCtrl;
  wire signed [15:0] S;
  	wire zero;
	wire OverFlow;
  
alu_16 alu_16_tb(.A(A),.B(B), .ALUCtrl(ALUCtrl), .S(S), .zero(zero), .OverFlow(OverFlow));
localparam t = 500;

initial begin
/*** Addition ***/
  #t
  A = 16'b0010011100001111;		//9999
  #t
  B = 16'b1111111010100111;		//-345
  #t
  ALUCtrl = 4'b0001;
  #t
  $display("A = %b (decimal = %d)  B = %b (decimal = %d) (Addition)", A, A, B, B);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S,  zero, OverFlow);
  
  /*** Subtraction ***/
  #t
  A = 16'b1111111111001110;		//-50
  #t
  B = 16'b1111110001111100;		//-900
  #t	
  ALUCtrl = 4'b0000;
  #t
  $display("A = %b (decimal = %d)  B = %b (decimal = %d) (Subtraction)", A, A, B, B);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S,  zero, OverFlow);

  /*** bitwise OR ***/
  #t
  A = 16'b0000000000000100;		//4
  #t
  B = 16'b1111111111111110;		//-2
  #t
  ALUCtrl = 4'b0010;
  #t
  $display("A = %b (decimal = %d)  B = %b (decimal = %d) (Bitwise OR)", A, A, B, B);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S, zero, OverFlow);
  /*** bitwise AND ***/
  #t
  A = 16'b0000000001000110;		//70
  #t
  B = 16'b0000111011001010;		//3786
  #t
  ALUCtrl = 4'b0011;
  #t
  $display("A = %b (decimal = %d)  B = %b (decimal = %d) (Bitwise AND)", A, A, B, B);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S, zero, OverFlow);
  /*** decrement ***/
  #t
  A = 16'b1111000000101000;		//-4056
  #t
  B = 16'b1010_0000_0101_0100;
  #t
  ALUCtrl = 4'b0100;
  #t
  $display("A = %b (decimal = %d) (Decrement)", A, A);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S, zero, OverFlow);
  /*** increment ***/
  #t
  A = 16'b0011000000111001;		//12345
  #t
  B = 16'b1010_0000_0101_0100;
  #t
  ALUCtrl = 4'b0101;
  #t
  $display("A = %b (decimal = %d) (Increment)", A, A);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S, zero, OverFlow);
  /*** invert ***/
  #t
  A = 16'b0010101101100111;		//1111
  #t
  B = 16'b1010_0000_0101_0100;
  #t
  ALUCtrl = 4'b0110;
  #t
  $display("A = %b  (decimal = %d) (Invert)", A, A);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S, zero, OverFlow);
  /*** arithmetic shift left ***/
  #t
  A = 16'b1010011100001111;		//9999
  #t
  B = 16'b1010_0000_0101_0100;
  #t
  ALUCtrl = 4'b1100;
  #t
  $display("A = %b (decimal = %d) (Arithmetic Shift Left)", A, A);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S, zero, OverFlow);
  /*** arithmetic shift right ***/
  #t
  A = 16'b1101100011110001;		//-9999
  #t
  B = 16'b1010_0000_0101_0100;
  #t
  ALUCtrl = 4'b1110;
  #t
  $display("A = %b (decimal = %d) (Arithmetic Shift Right)", A, A);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S, zero, OverFlow);
  /*** logical shift left ***/
  #t
  A = 16'b1101110110001001;		//-8823
  #t
  B = 16'b1010_0000_0101_0100;
  #t
  ALUCtrl = 4'b1000;
  #t
  $display("A = %b (decimal = %d) (Logical Shift Left)", A, A);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S, zero, OverFlow);
  /*** logical shift right ***/
  #t
  A = 16'b1111111111110110;		//-10
  #t
  B = 16'b1010_0000_0101_0100;
  #t
  ALUCtrl = 4'b1010;
  #t
  $display("A = %b (decimal = %d) (Logical Shift Right)", A, A);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S, zero, OverFlow);
  /*** set less than or equal to ***/
  #t
  A = 16'b1111111111110001;		//-15
  #t
  B = 16'b0000000000001010;		//10
  #t
  ALUCtrl = 4'b1001;
  #t
  $display("A = %b (decimal = %d) B = %b (decimal = %d) (Set Less Than or Equal)", A, A, B, B);
  $display("\t--S = %b (decimal = %d), Zero = %b, OverFlow = %b \n", S, S, zero, OverFlow);
  
  
  
  
  $finish;
end
endmodule
