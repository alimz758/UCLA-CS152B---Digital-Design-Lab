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


module alu_16(
  input signed [15:0]  A,B,
  input [3:0] ALUCtrl,
  output [15:0] S,
  output zero,
  output OverFlow
    );
  reg [15:0] Result;
  reg [15:0] temp;
  integer i;
  assign S = temp;
  assign zero = 0;
  assign OverFlow = 0;
    always @(*)
    begin
        case(ALUCtrl)
          4'b0000:	// use module
            Result = A - B;
          4'b0001:	// use module
            Result = A + B;
          4'b0010:	//bitwise OR
            begin
            Result = A | B;
            for (i = 0; i < 16; i = i + 1) begin
            if (A[i] == 0 && B[i] == 0)
              temp[i] = 0;
            else
              temp[i] = 1;
          end
          if (temp == Result)
            $display("CORRECT");
          else
            $display("WRONG");
            end
          4'b0011:	//bitwise AND
			begin
            Result = A & B;
            for (i = 0; i < 16; i = i + 1) begin
              if (A[i] == 1 && B[i] == 1)
                temp[i] = 1;
            else
              temp[i] = 0;
          end
          if (temp == Result)
            $display("CORRECT");
          else
            $display("WRONG");
            end
          4'b0100:	// use module
            Result = A - 1'b1;
          4'b0101: // use module
            Result = A + 1'b1;
          4'b0110: //invert
            begin
              for (i = 0; i < 16; i = i +1) begin
                if(A[i] == 0)
                  temp[i] = 1;
                else
                  temp[i] = 0;
              end
            Result = ~A;
          if (temp == Result)
            $display("CORRECT");
          else
            $display("WRONG");
            end
          4'b1100:	//arithmetic shift left
            begin
            Result = A <<< 1;
              temp[15:0] = {A[15:0],1'b0};
			if (temp == Result)
              $display("CORRECT");
          else
            $display("WRONG, correct value is: %b", Result);
            end
          4'b1110:	//arithmetic shift right
            begin
            Result = A >>> 1;
              temp[15:0] = {A[15],A[15:1]};
              if (temp == Result)		// why is the verilog operation giving a different value?
              $display("CORRECT");
          else
            $display("WRONG, correct value is: %b", Result);
            end
          4'b1000:	//logical shift left
            begin
            Result = A <<< 1;
              temp[15:0] = {A[15:0],1'b0};
			if (temp == Result)
              $display("CORRECT");
          else
            $display("WRONG, correct value is: %b", Result);
            end
          4'b1010:	//logical shift right
            begin
            Result = A >> 1;
              temp[15:0] = {1'b0,A[15:1]};
			if (temp == Result)
              $display("CORRECT");
          else
            $display("WRONG, correct value is: %b", Result);
            end
          4'b1001:
            Result = (A<=B)?15'd1:15'd0;
          default: $display("Nothing Happened");
        endcase
    end
  
endmodule
