 18 bit *18 bit multiplier

module mul(input[17:0] A ,B,output [35:0]y);
assign y=A*B;
endmodule

31*31 bit multiplier
module mul(input[31:0] A ,B,output [63:0]y);
assign y=A*B;
endmodule

MAC OPERATION
module mul(input[17:0] A ,B,output [47:0]y);
assign y=y+A*B;
endmodule