delay
module delay(input a,clk,output a_delay);
reg[2:0]a_reg;
always@(posedge clk)
begin
a_reg[0]<=a;
a_reg[1]<=a_reg[0];
a_reg[2]<=a_reg[1];
end
assign a_delay=a_reg[2];
endmodule

delay_tb
module delay_tb;
reg clk=0,a=1;
wire a_delay;
delay uut(a,clk,a_delay);
always
begin
a=1;#15;
a=0;
end
always
begin
clk=~clk;
#10;
end
endmodule

delay_100
module delay_100(input a,clk,output a_delay);
reg[99:0]a_reg;
integer i;
always @(posedge clk)
begin
a_reg[0]<= a;
for(i=0;i<100;i=i+1)
a_reg[i]<=a_reg[i-1];
end
assign a_delay=a_reg[99];
endmodule

delay_100_tb
module delay_100_tb;
reg a,clk;
wire a_delay;
delay_100 dut(.a(a),.clk(clk),.a_delay(a_delay));
always #5 clk=~clk;
initial begin
clk=0;
a=0;
#10;
a=1;
#10;
a=0;
#1200;
$finish;
end
endmodule

delay_param
module delay_param#(parameter N=3)(input a,clk,output a_delay);
reg [N-1:0]a_reg;
integer i;
always@(posedge clk)
begin
a_reg[0]<=a;
for(i=1;i<N;i=i+1)
a_reg[i]<=a_reg[i-1];
end
assign a_delay=a_reg[N-1];
endmodule

delay_param_tb
module delay_param_tb;
parameter N=3;
reg clk,a;
wire a_delay;
delay_param #(N) uut(a,clk,a_delay);
always #10 clk=~clk;
initial begin
clk=0;
a=0;
#20 a=1;
#20 a=0;
#100 $finish;
end
endmodule

delay_wait
module delay_wait(input a,clk,output a_delay);
reg[2:0]a_reg=3'b000;
always@(posedge clk)
begin
a_reg[0]<=a;
a_reg[1]<=a_reg[0];
a_reg[2]<=a_reg[1];
end
assign a_delay=a_reg[2];
endmodule

delay_wait_tb
module delay_wait_tb;
reg clk=0,a=0;
wire a_delay;
delay_wait dut(a,clk,a_delay);
always begin
#10;
clk=~clk;
end
initial begin
a=0;
wait(clk==1);
a=1;
wait(clk==0);
wait(clk==1);
a=0;
#100;
$finish;
end
endmodule