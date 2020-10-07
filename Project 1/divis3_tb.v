{\rtf1\ansi\ansicpg1252\cocoartf2511
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 // Code your testbench here\
// or browse Examples\
module divis3_tb();\
\
reg [15:0] bcd;\
wire out;\
divis3 divis3_tb(.bcd(bcd), .out(out));\
\
initial begin\
  //bcd = 16'b1000_0011_0010_1001;   // 8329\
  //bcd = 16'b0000000000100001;	//		21\
  //bcd = 16'b0000_0000_0010_0010;		//  22\
  //bcd = 16'b1001_1001_1001_1001;		// 9999\
  //bcd = 16'b0000_0000_0011_0010;		// 32	alternate sum is -1\
  //bcd = 16'b0000_0000_0011_0011;		// 33\
  bcd = 16'b1001_1001_0000_0011;		//9903  alternate sum is -3\
  #50\
  \
  $display("%b", out);\
  $finish;\
  \
end\
\
endmodule}