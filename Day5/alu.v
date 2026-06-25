module alu(A,B,control,result,zero,negative);
input[3:0]A,B,control;
output reg [3:0]result;
output zero,negative;
always@(*)begin
case(control)
4'd0:result=A+B;
4'd1:result=A-B;
4'd2:result=A&B;
4'd3:result=A|B;
4'd4:result=A^B;
4'd5:result=A>>2;
4'd6:result=A<<2;
4'd7:result=A*B;
4'd8:result=A+1;
4'd9:result=A-1;
4'd10:result=~A;
4'd11:result=~B;
default:result=4'd0;
endcase
end
assign zero=~|result;
assign negative =result[3];
endmodule

module alu_tb();
reg signed[3:0]A,B;
reg [3:0]control;
wire [3:0]result;
wire zero,negative;

alu dut(A,B,control,result,zero,negative);

initial begin
A=4'd0;B=4'd0;control=4'd0;
#5 A=4'd1;B=4'd2;control=4'd0;
#5 A=4'd2;B=4'd1;control=4'd1;
#5 A=4'd1;B=4'd2;control=4'd2;
#5 A=4'd1;B=4'd2;control=4'd3;
#5 A=4'd1;B=4'd2;control=4'd4;
#5 A=4'd1;B=4'd2;control=4'd5;
#5 A=4'd1;B=4'd2;control=4'd6;
#5 A=4'd1;B=4'd2;control=4'd7;
#5 A=4'd1;B=4'd2;control=4'd8;
#5 A=4'd1;B=4'd2;control=4'd9;
#5 A=4'd1;B=4'd2;control=4'd10;
#5 A=4'd1;B=4'd2;control=4'd11;
#5 $finish;

end
endmodule


fuction
module function_1(input[31:0]address,output reg parity_reg);
function parity_cal;
input[31:0]data;
begin
parity_cal=~^data;
end
endfunction
always@(address)
parity_reg=parity_cal(address);
endmodule

task
module task_1(input[31:0]address,output reg parity_reg);
task parity_cal;
input[31:0] data;
output parity;
begin
 parity =~^data;
end
endtask
always@(address)
begin
parity_cal(address,parity_reg);
end
endmodule

task_tb
module task_1_tb();
reg [31:0]address;
wire parity_reg;
task_1 uut(.address(address),.parity_reg(parity_reg));
initial begin
address=32'b0000;
#10;
address=32'b0001;
#10;
address=32'b0011;
#10;
address=32'b0111;
#10;
$finish;
end
endmodule