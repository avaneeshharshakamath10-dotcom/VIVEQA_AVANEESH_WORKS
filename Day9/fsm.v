module dff(input clk,rst,D,output reg Q,Qb);
always@ (posedge clk)begin
if(rst)begin 
Q<=1'b0;
Qb<=1'b1;
end 
else begin
Q<=D;
Qb<=~D;
end
end
endmodule

mealey_fsm
module mealy_fsm(input clk,rst,ip,output op);
wire ipb,d1,d0,q0,qb0,q1,qb1;
assign ipb=~ip;
assign d1=q1 & qb0 & ipb | qb1 & q0 &ipb;
assign d0=q1 & qb0 | ip;
assign op= q0 & q1 & ip;

dff dff0(clk,rst,d0,q0,qb0);
dff dff1(clk,rst,d1,q1,qb1);

endmodule

mealey_fsm_tb
module mealy_fsm_tb();
reg clk,rst;
reg ip;
wire op;

mealy_fsm dut(clk,rst,ip,op);

always #5 clk=~clk;

initial begin
clk=1'b0;
rst=1'b0;
ip=1'b0;
#12; rst=1'b1;
#12; rst=1'b0;

#7 ip=1'b0;
#7 ip=1'b1;
#7 ip=1'b0;
#7 ip=1'b0;
#7 ip=1'b1;
#7 ip=1'b0;
#7 ip=1'b0;
#7 ip=1'b1;
#7 ip=1'b1;
#7 ip=1'b0;
#7 ip=1'b0;
#7 ip=1'b1;
#7 ip=1'b0;
#7 ip=1'b0;
#7 ip=1'b1;
#7 ip=1'b0;
#7 ip=1'b0;
#7 ip=1'b1;
#7 ip=1'b1;
#7 ip=1'b0;
#7 ip=1'b0;
#7 ip=1'b1;
#7 ip=1'b0;
#7 ip=1'b0;
#7 ip=1'b1;
#7 ip=1'b0;
#7 ip=1'b1;
#7 ip=1'b1;
#7 ip=1'b0;

$finish;
end

endmodule