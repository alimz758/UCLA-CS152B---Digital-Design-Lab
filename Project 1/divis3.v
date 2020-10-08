// Code your design here
//`include "add.sv"
module divis3(
  input [15:0] bcd,
  output out
);
  
  
  
reg [5:0] sum; // maximum number is 100100
reg[2:0] fin;
reg temp;
reg[3:0] test;
  
reg [3:0] op1;
reg [3:0] op2;
reg [3:0] op3;
reg [3:0] op4;

reg [4:0] s1;
reg [4:0] c1p;
reg [4:0] c1;
reg [4:0] s2;
reg [4:0] c2p;
reg [4:0] c2;
reg [4:0] s3;
reg [4:0] c3p;
reg [4:0] c3;
reg [4:0] s4;
reg [4:0] c4p;
  
reg [4:0] s5;
reg [4:0] c5p;
reg [4:0] c5;
reg [4:0] s6;
reg [4:0] c6p;
reg [4:0] c6;
reg [4:0] s7;
reg [4:0] c7p;
reg [4:0] c7;
reg [4:0] s8;
reg [4:0] c8p;

reg [5:0] s5_;
reg [5:0] c5p_;
reg [5:0] c5_;
reg [5:0] s6_;
reg [5:0] c6p_;
reg [5:0] c6_;
reg [5:0] s7_;
reg [5:0] c7p_;
reg [5:0] c7_;
reg [5:0] s8_;
reg [5:0] c8p_;
  
reg[4:0] num1;
reg[4:0] num2;
  
reg[5:0] num1X;
reg[5:0] num2X;

reg[2:0] NFIN1;
reg[2:0] NFIN2;
  
  always @(bcd)
    begin
	  sum = 6'b000000;
      fin = 3'b000;
      //sum = bcd[15:12] + bcd[11:8] + bcd[7:4] + bcd[3:0];
      
      //fin = sum[0]-sum[1]+sum[2]-sum[3]+sum[4]-sum[5];

      op1 = bcd[15:12];
      op2 = bcd[11:8];
      op3 = bcd[7:4];
      op4 = bcd[3:0];
      
       s1 = op1 ^ op2;
       c1p = op1 & op2;
       c1 = {c1p[3:0], 1'b0};

       s2 = s1 ^ c1;
       c2p = s1 & c1;
       c2 = {c2p[3:0], 1'b0};

       s3 = s2 ^ c2;
       c3p = s2 & c2;
       c3 = {c3p[3:0], 1'b0};

       s4 = s3 ^ c3;
       c4p = s3 & c3;
      
       num1 = {c4p,s4};
      
       s5 = op3 ^ op4;
       c5p = op3 & op4;
       c5 = {c5p[3:0], 1'b0};

       s6 = s5 ^ c5;
       c6p = s5 & c5;
       c6 = {c6p[3:0], 1'b0};

       s7 = s6 ^ c6;
       c7p = s6 & c6;
       c7 = {c7p[3:0], 1'b0};

       s8 = s7 ^ c7;
       c8p = s7 & c7;
      
       num2 = {c8p,s8};
      
      /*************************************/
      
       s5_ = num1 ^ num2;
       c5p_ = num1 & num2;
       c5_ = {c5p_[4:0], 1'b0};

       s6_ = s5_ ^ c5_;
       c6p_ = s5_ & c5_;
       c6_ = {c6p_[4:0], 1'b0};

       s7_ = s6_ ^ c6_;
       c7p_ = s6_ & c6_;
       c7_ = {c7p_[4:0], 1'b0};

       s8_ = s7_ ^ c7_;
       c8p_ = s7_ & c7_;
      
      sum = {c8p_,s8_};
      
      num1X = sum & 6'b101010;
      num2X = sum & 6'b010101;
      
      NFIN1 = {num1X[1],num1X[3],num1X[5]};
      NFIN2 = {num2X[0],num2X[2],num2X[4]};
      
      if (NFIN1 == 3'b111 && NFIN2 == 3'b111)
        temp = 1'b1;
      else if (NFIN1 == 3'b111 && NFIN2 == 3'b000)
        temp = 1'b1;
      else if (NFIN1 == 3'b000 && NFIN2 == 3'b111)
        temp = 1'b1;
      else if (NFIN1 == 3'b100 && NFIN2 == 3'b100)
        temp = 1'b1;
      else if (NFIN1 == 3'b000 && NFIN2 == 3'b000)
        temp = 1'b1;
      else if ((NFIN1 == 3'b110 || NFIN1 == 3'b101 || NFIN1 == 3'b011) && (NFIN2 == 3'b110 || NFIN2 == 3'b101 || NFIN2 == 3'b011))
        temp = 1'b1;
      else if ((NFIN1 == 3'b100 || NFIN1 == 3'b001 || NFIN1 == 3'b010) && (NFIN2 == 3'b100 || NFIN2 == 3'b001 || NFIN2 == 3'b010))
        temp = 1'b1;
      else
        temp = 1'b0;
      
    end
//  assign out = temp;
  assign out = temp;
endmodule
