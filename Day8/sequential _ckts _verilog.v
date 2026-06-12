1)Write RTL and Testbench for SR latch using Gate level modelling. 
module sr_latch (
    input S,
    input R,
    output Q,
    output Qbar
);

nand(Q, S, Qbar);
nand(Qbar, R, Q);

endmodule

module tb_sr_latch;

reg S, R;
wire Q, Qbar;

sr_latch U0 (
    .S(S),
    .R(R),
    .Q(Q),
    .Qbar(Qbar)
);

initial begin
    $monitor("Time=%0t S=%b R=%b Q=%b Qbar=%b",
              $time,S,R,Q,Qbar);

    S=1; R=1;   // Hold
    #10;

    S=0; R=1;   // Set
    #10;

    S=1; R=1;   // Hold
    #10;

    S=1; R=0;   // Reset
    #10;

    S=1; R=1;   // Hold
    #10;

    S=0; R=0;   // Invalid
    #10;

    $finish;
end

endmodule

2)Write RTL and Testbench for JK Flip Flop, using parameter declaration for the respective scenarios (HOLD, TOGGLE, SET, RESET).
module jk_ff (
    input J,
    input K,
    input clk,
    output reg Q
);

parameter HOLD   = 2'b00;
parameter RESET  = 2'b01;
parameter SET    = 2'b10;
parameter TOGGLE = 2'b11;

always @(posedge clk)
begin
    case ({J,K})

        HOLD   : Q <= Q;

        RESET  : Q <= 1'b0;

        SET    : Q <= 1'b1;

        TOGGLE : Q <= ~Q;

    endcase
end

endmodule

module tb_jk_ff;

reg J,K,clk;
wire Q;

jk_ff U0 (
    .J(J),
    .K(K),
    .clk(clk),
    .Q(Q)
);

always #5 clk = ~clk;

initial
begin
    clk=0;

    J=0; K=0;   // Hold
    #10;

    J=1; K=0;   // Set
    #10;

    J=0; K=1;   // Reset
    #10;

    J=1; K=1;   // Toggle
    #20;

    $finish;
end

initial
$monitor("Time=%0t J=%b K=%b Q=%b",
          $time,J,K,Q);

endmodule

3)Write RTL and Testbench for for a T Flip Flop using D Flip Flop.
module d_ff (
    input D,
    input clk,
    output reg Q
);

always @(posedge clk)
    Q <= D;

endmodule

module t_ff (
    input T,
    input clk,
    output Q
);

wire q_int;
wire D;

assign D = T ^ q_int;

d_ff U0 (
    .D(D),
    .clk(clk),
    .Q(q_int)
);

assign Q = q_int;

endmodule

module tb_t_ff;

reg T,clk;
wire Q;

t_ff U0 (
    .T(T),
    .clk(clk),
    .Q(Q)
);

always #5 clk = ~clk;

initial
begin
    clk=0;

    T=0;
    #20;

    T=1;
    #40;

    T=0;
    #20;

    $finish;
end

initial
$monitor("Time=%0t T=%b Q=%b",
          $time,T,Q);

endmodule

4)Write RTL and Testbench for a 4-bit synchronous and loadable binary up counter. 
module up_counter_load (
    input clk,
    input rst,
    input load,
    input [3:0] D,
    output reg [3:0] Q
);

always @(posedge clk)
begin
    if(rst)
        Q <= 4'b0000;

    else if(load)
        Q <= D;

    else
        Q <= Q + 1'b1;
end

endmodule

module tb_up_counter_load;

reg clk,rst,load;
reg [3:0] D;
wire [3:0] Q;

up_counter_load U0 (
    .clk(clk),
    .rst(rst),
    .load(load),
    .D(D),
    .Q(Q)
);

always #5 clk=~clk;

initial
begin
    clk=0;
    rst=1;
    load=0;
    D=4'b0000;

    #10 rst=0;

    #20 load=1;
    D=4'b1010;

    #10 load=0;

    #50 $finish;
end

initial
$monitor("Time=%0t Q=%b",$time,Q);

endmodule

5)Write RTL and Testbench to design a 4-bit MOD-12 loadable binary synchronous up counter.
module mod12_counter (
    input clk,
    input rst,
    input load,
    input [3:0] D,
    output reg [3:0] Q
);

always @(posedge clk)
begin
    if(rst)
        Q <= 4'd0;

    else if(load)
        Q <= D;

    else if(Q == 4'd11)
        Q <= 4'd0;

    else
        Q <= Q + 1'b1;
end

endmodule

module tb_mod12;

reg clk,rst,load;
reg [3:0] D;
wire [3:0] Q;

mod12_counter U0 (
    .clk(clk),
    .rst(rst),
    .load(load),
    .D(D),
    .Q(Q)
);

always #5 clk=~clk;

initial
begin
    clk=0;
    rst=1;
    load=0;

    #10 rst=0;

    #30 load=1;
    D=4'd8;

    #10 load=0;

    #100 $finish;
end

initial
$monitor("Time=%0t Count=%d",$time,Q);

endmodule

6)Write RTL and Testbench to design a 4-bit loadable binary synchronous up-down counter.
module up_down_counter (
    input clk,
    input rst,
    input load,
    input up_down,
    input [3:0] D,
    output reg [3:0] Q
);

always @(posedge clk)
begin
    if(rst)
        Q <= 4'b0000;

    else if(load)
        Q <= D;

    else if(up_down)
        Q <= Q + 1'b1;

    else
        Q <= Q - 1'b1;
end

endmodule

module tb_up_down;

reg clk,rst,load,up_down;
reg [3:0] D;
wire [3:0] Q;

up_down_counter U0 (
    .clk(clk),
    .rst(rst),
    .load(load),
    .up_down(up_down),
    .D(D),
    .Q(Q)
);

always #5 clk=~clk;

initial
begin
    clk=0;
    rst=1;
    load=0;
    up_down=1;

    #10 rst=0;

    #30;

    load=1;
    D=4'd10;

    #10 load=0;

    #30 up_down=0;

    #50 $finish;
end

initial
$monitor("Time=%0t Count=%d",$time,Q);

endmodule.

