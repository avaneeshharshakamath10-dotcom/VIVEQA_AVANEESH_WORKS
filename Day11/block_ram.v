module block_ram(input clk,[9:0]w_addr,[9:0]r_addr,we,re,[31:0]write_data,output reg [31:0]read_data);
reg[31:0]mem[0:1023];//reg[width]mem[depth]
always@(posedge clk)begin
if(we)
mem[w_addr]<=write_data;
end
always@(posedge clk)begin
if(re)
read_data<=mem[r_addr];
end
endmodule

module block_ram_tb();
reg clk;
reg we;
reg re;
reg [9:0]w_addr;
reg [9:0]r_addr;
reg [31:0]write_data;
wire[31:0]read_data;
block_ram dut(clk,w_addr,r_addr,we,re,write_data,read_data);
always #5 clk=~clk;
initial begin
clk=1'b0;
w_addr=10'h0;
r_addr=10'h0;
we=1'b0;
re=1'b0;
write_data=32'h0;

#12
//Test case Starts here
we=1'b1;
#12 w_addr=10'h1; write_data=32'h1;
#12 w_addr=10'h2; write_data=32'h2;
#12 w_addr=10'h3; write_data=32'h3;
#12 w_addr=10'h4; write_data=32'h4;
#12 w_addr=10'h5; write_data=32'h5;

#12 re=1'b1;
#12 w_addr=10'h6; write_data=32'h6; r_addr=10'h1; //Writing addr 6 data 6 and read from addr 1
#12 w_addr=10'h7; write_data=32'h7; r_addr=10'h2;
#12 w_addr=10'h8; write_data=32'h8; r_addr=10'h3;
#12 w_addr=10'h9; write_data=32'h9; r_addr=10'h4;
#12 w_addr=10'hA; write_data=32'hA; r_addr=10'h5;
#24 we=1'b0;re=1'b0;
$finish;

end
endmodule