{\rtf1\ansi\ansicpg1252\cocoartf2511
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 // Code your design here\
module divis3(\
  input [15:0] bcd,\
  output out\
);\
  \
  \
  \
reg [5:0] sum; // maximum number is 100100\
reg[2:0] fin;\
reg temp;\
  \
  always @(bcd)\
    begin\
	  sum = 6'b000000;\
      fin = 3'b000;\
      sum = bcd[15:12] + bcd[11:8] + bcd[7:4] + bcd[3:0];\
      \
      fin = sum[0]-sum[1]+sum[2]-sum[3]+sum[4]-sum[5];\
\
      if (fin == 2'b00 || fin == 2'b11 ) begin\
        temp = 1'b1;\
      end\
      else \
        temp = 1'b0; \
    end\
  assign out = temp;\
endmodule}