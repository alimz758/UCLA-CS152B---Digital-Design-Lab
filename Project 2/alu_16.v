// Code your design here
/* ALU Arithmetic and Logic Operations
----------------------------------------------------------------------
|ALU_Sel|   ALU Operation
----------------------------------------------------------------------
| 0000  |   ALU_Out = A - B;	subtraction
----------------------------------------------------------------------
| 0001  |   ALU_Out = A + B;	addition
----------------------------------------------------------------------
| 0010  |   ALU_Out = A | B;	bitwise OR
----------------------------------------------------------------------
| 0011  |   ALU_Out = A & B;	bitwise AND
----------------------------------------------------------------------
| 0100  |   ALU_Out = A - 1;	decrement (what about B?)
----------------------------------------------------------------------
| 0101  |   ALU_Out = A + 1;	increment (what about B?)
----------------------------------------------------------------------
| 0110  |   ALU_Out = ~A;		invert (what about B?)
----------------------------------------------------------------------
| 1100  |   ALU_Out = A <<< 1;	arithmetic shift left
----------------------------------------------------------------------
| 1110  |   ALU_Out = A >>> 1;	arithmetic shift right
----------------------------------------------------------------------
| 1000  |   ALU_Out = A << 1;	logical shift left
----------------------------------------------------------------------
| 1010  |   ALU_Out = A >> 1;	logical shift right
----------------------------------------------------------------------
| 1001  |   ALU_Out = 1 if A>= B else 0;	set less than or equal to
----------------------------------------------------------------------*/
module addbit(s, cout, cin, a, b);

	input cin, a, b;
	output s, cout;
	wire o1, o2, o3;

	xor i1(o1, a, b);
	and i2(o2, a, b);
	and i3(o3, o1, cin);
	or  i4(cout, o2, o3);
	xor i5(s, o1, cin);
  
endmodule

module full_adder(sum, c_in, aa, bb, c_out);
  
  wire [15:0] ss;
  output [15:0] sum;
  output c_out;
  wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16;
  input c_in;
  input [15:0] aa;
  input [15:0] bb;	//testing the sum
  
  addbit u0(.s(ss[0]), .cout(c1), .cin(c_in), .a(aa[0]), .b(bb[0]));
  addbit u1(.s(ss[1]), .cout(c2), .cin(c1), .a(aa[1]), .b(bb[1]));
  addbit u2(.s(ss[2]), .cout(c3), .cin(c2), .a(aa[2]), .b(bb[2]));
  addbit u3(.s(ss[3]), .cout(c4), .cin(c3), .a(aa[3]), .b(bb[3]));
  addbit u4(.s(ss[4]), .cout(c5), .cin(c4), .a(aa[4]), .b(bb[4]));
  addbit u5(.s(ss[5]), .cout(c6), .cin(c5), .a(aa[5]), .b(bb[5]));
  addbit u6(.s(ss[6]), .cout(c7), .cin(c6), .a(aa[6]), .b(bb[6]));
  addbit u7(.s(ss[7]), .cout(c8), .cin(c7), .a(aa[7]), .b(bb[7]));
  addbit u8(.s(ss[8]), .cout(c9), .cin(c8), .a(aa[8]), .b(bb[8]));
  addbit u9(.s(ss[9]), .cout(c10), .cin(c9), .a(aa[9]), .b(bb[9]));
  addbit u10(.s(ss[10]), .cout(c11), .cin(c10), .a(aa[10]), .b(bb[10]));
  addbit u11(.s(ss[11]), .cout(c12), .cin(c11), .a(aa[11]), .b(bb[11]));
  addbit u12(.s(ss[12]), .cout(c13), .cin(c12), .a(aa[12]), .b(bb[12]));
  addbit u13(.s(ss[13]), .cout(c14), .cin(c13), .a(aa[13]), .b(bb[13]));
  addbit u14(.s(ss[14]), .cout(c15), .cin(c14), .a(aa[14]), .b(bb[14]));
  addbit u15(.s(ss[15]), .cout(c16), .cin(c15), .a(aa[15]), .b(bb[15]));
  
  
  assign sum = ss;
  assign c_out = c16;
  
  
endmodule


module alu_16(
  input signed [15:0]  A,B,	
  input [3:0] ALUCtrl,
  output [15:0] S,
  output zero,
  output OverFlow
    );
  
  reg [15:0] Result;
  reg [15:0] temp;
  reg zero_temp;
  reg overflow_temp;
  reg [15:0] temp_B;
  reg [15:0] sum;
  reg [15:0] sum_B, sum_A, sub_A;
  reg [15:0] subtract;
  wire c_out;
  integer i;
  assign S = temp;
  assign zero = zero_temp;
  assign OverFlow = overflow_temp;
  
  //summing
  full_adder fl1(.sum(sum), .c_in(1'b0), .aa(A), .bb(B), .c_out(c_out));
  
  //subtracting
  assign temp_B = ~B;
  full_adder fl2(.sum(sum_B), .c_in(1'b0), .aa(16'b0000000000000001), .bb(temp_B), .c_out(c_out)); //adding 1
  full_adder fl3(.sum(subtract), .c_in(1'b0), .aa(A), .bb(sum_B), .c_out(c_out));
  
  //adding 1 to A
  full_adder fl4(.sum(sum_A), .c_in(1'b0), .aa(A), .bb(16'b0000000000000001), .c_out(c_out));
  
  //subtracting 1 from A
  full_adder fl5(.sum(sub_A), .c_in(1'b0), .aa(A), .bb(16'b1111111111111111), .c_out(c_out));
  
  always @(*)
    begin
        case(ALUCtrl)
          4'b0000:	// subtraction
            
            begin
            Result = A - B;
            temp = subtract;

            if (temp == 16'd0)
              zero_temp = 16'd1;
            else
              zero_temp = 16'd0;

            if (temp == Result)
                $display("CORRECT");
            else
                $display("WRONG, correct value is: %b", Result);
            end
          
          4'b0001:	// Addition
            begin
            Result = A + B;
            temp = sum;
              
            if (temp == 16'd0)
              zero_temp = 16'd1;
            else
              zero_temp = 16'd0;
              
          	if (temp == Result)
              	$display("CORRECT");
            else
            	$display("WRONG, correct value is: %b", Result);
            end
          
          4'b0010:	//bitwise OR
            begin
            Result = A | B;
            for (i = 0; i < 16; i = i + 1) 
              begin
            	if (A[i] == 0 && B[i] == 0)
              		temp[i] = 0;
            	else
              		temp[i] = 1;
          	  end
              
            if (temp == 16'd0)
              zero_temp = 16'd1;
            else
              zero_temp = 16'd0;
              
            if (temp == Result)
              $display("CORRECT");
            else
              $display("WRONG");
              end
          
          4'b0011:	//bitwise AND
			begin
            Result = A & B;
            for (i = 0; i < 16; i = i + 1) 
              begin
              	if (A[i] == 1 && B[i] == 1)
                	temp[i] = 1;
            	else
              		temp[i] = 0;
          		end
              
            if (temp == 16'd0)
              zero_temp = 16'd1;
            else
              zero_temp = 16'd0;
              
            if (temp == Result)
              $display("CORRECT");
            else
              $display("WRONG");
            end
          
          4'b0100:	// subtract 1 form A
            begin
            Result = A - 1'b1;
			temp = sub_A;
              
            if (temp == 16'd0)
              zero_temp = 16'd1;
            else
              zero_temp = 16'd0;
              
			if (temp == Result)
            	$display("CORRECT");
            else
            	$display("WRONG");
            end
          
          4'b0101: // add 1 to A
            begin
            Result = A + 1'b1;
            temp = sum_A;
              
            if (temp == 16'd0)
              zero_temp = 16'd1;
            else
              zero_temp = 16'd0;
              
			if (temp == Result)
            	$display("CORRECT");
            else
            	$display("WRONG");
            end
          
          4'b0110: //invert
            begin
              for (i = 0; i < 16; i = i +1) begin
                if(A[i] == 0)
                  temp[i] = 1;
                else
                  temp[i] = 0;
              end
            	Result = ~A;

            if (temp == 16'd0)
              zero_temp = 16'd1;
            else
              zero_temp = 16'd0;
              
            if (temp == Result)
              $display("CORRECT");
            else
              $display("WRONG");
            end
          
          4'b1100:	//arithmetic shift left
            begin
            Result = A <<< 1;
            temp[15:0] = {A[15:0],1'b0};
              
            if (temp == 16'd0)
              zero_temp = 16'd1;
            else
              zero_temp = 16'd0;
              
            if (A[15] != temp[15])
              overflow_temp = 1;
            else
              overflow_temp = 0;
              
            if (temp == Result)
              $display("CORRECT");
            else
               $display("WRONG, correct value is: %b", Result);
            end
          
          4'b1110:	//arithmetic shift right
            begin
              Result = A >>> 1;
              temp[15:0] = {A[15],A[15:1]};
              
              if (A[15] != temp[15])
                overflow_temp = 1;
              else
                overflow_temp = 0;
              
              if (temp == 16'd0)
                zero_temp = 16'd1;
              else
                zero_temp = 16'd0;
              if (temp == Result)		// why is the verilog operation giving a different value?
        	      $display("CORRECT");
	          else
    	          $display("WRONG, correct value is: %b", Result);
            end
          
          4'b1000:	//logical shift left
            
            begin
            Result = A <<< 1;
              temp[15:0] = {A[15:0],1'b0};
              if (temp == 16'd0)
                zero_temp = 16'd1;
              else
                zero_temp = 16'd0;
			  if (temp == Result)
              	$display("CORRECT");
              else
            	$display("WRONG, correct value is: %b", Result);
            end
          
          4'b1010:	//logical shift right
            begin
            Result = A >> 1;
              temp[15:0] = {1'b0,A[15:1]};
              if (temp == 16'd0)
                zero_temp = 16'd1;
              else
                zero_temp = 16'd0;
			  if (temp == Result)
              	$display("CORRECT");
              else
            	$display("WRONG, correct value is: %b", Result);
            end
          
          4'b1001:	//set less than or equal
            begin
              Result = (A<=B)?16'd1:16'd0;
              //temp = (A<=B)?15'd1:15'd0;
            	if (subtract <= 0)
	           	 	temp = 16'd1;
             	else
                	temp = 16'd0;
              	if (temp == 16'd0)
                	zero_temp = 16'd1;
              	else
               	 	zero_temp = 16'd0;
				if (temp == Result)
             		$display("CORRECT");
          		else
            		$display("WRONG, correct value is: %b", Result);
             	end
                
          
          //default: //$display("Nothing Happened");
        endcase
    end
  
endmodule
