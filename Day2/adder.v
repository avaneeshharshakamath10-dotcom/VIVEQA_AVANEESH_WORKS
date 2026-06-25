full adder
module full_adder(input A,B, Cin,output Sum,Carry);
assign Sum= A^B^Cin;
assign Carry=(A&B)|(B&Cin)|(A&Cin);
endmodule

full adder tb
module full_adder_tb();
reg A,B,Cin;
wire Sum,Carry;
integer i;
full_adder dut(.A(A),.B(B),.Cin(Cin),.Sum(Sum),.Carry(Carry));
initial begin
for(i=0;i<8;i=i+1)
{A,B,Cin}=i;
#10;
$finish;
end
endmodule

ripple adder
module ripple_adder(input[3:0]a,b,cin,output[3:0]sum,cout);
wire c1,c2,c3;
f_a fa0(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(c1));
f_a fa1(.a(a[1]),.b(b[1]),.cin(c1),.sum(sum[1]),.cout(c2));
f_a fa2(.a(a[2]),.b(b[2]),.cin(c2),.sum(sum[2]),.cout(c3));
f_a fa3(.a(a[3]),.b(b[3]),.cin(c3),.sum(sum[3]),.cout(cout));
endmodule

ripple adder tb
module ripple_adder_tb();
reg[3:0] a,b;
 reg cin;
wire [3:0]sum;
wire cout;
integer i;
ripple_adder dut(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));
initial begin
cin=0;
for(i=0;i<16;i=i+1)
begin
a=i;
b=i;
#10;
end
$finish;
end
endmodule