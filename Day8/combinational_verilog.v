1)Write RTL for 1bit Full adder using Dataflow abstraction and verify the same using a Testbench. 
module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum  = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule

module tb_full_adder;

reg a,b,cin;
wire sum,cout;

full_adder uut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial begin
    $monitor("a=%b b=%b cin=%b sum=%b cout=%b",
              a,b,cin,sum,cout);

    a=0;b=0;cin=0;
    #10 a=0;b=0;cin=1;
    #10 a=0;b=1;cin=0;
    #10 a=0;b=1;cin=1;
    #10 a=1;b=0;cin=0;
    #10 a=1;b=0;cin=1;
    #10 a=1;b=1;cin=0;
    #10 a=1;b=1;cin=1;

    #10 $finish;
end

endmodule

2)Write RTL for 2x4 decoder using Dataflow abstraction and verify the same using a Testbench.
module decoder2x4(
    input a,
    input b,
    output [3:0] y
);

assign y[0] = ~a & ~b;
assign y[1] = ~a &  b;
assign y[2] =  a & ~b;
assign y[3] =  a &  b;

endmodule

module tb_decoder2x4;

reg a,b;
wire [3:0] y;

decoder2x4 uut(
    .a(a),
    .b(b),
    .y(y)
);

initial begin
    $monitor("a=%b b=%b y=%b",a,b,y);

    a=0;b=0;
    #10 a=0;b=1;
    #10 a=1;b=0;
    #10 a=1;b=1;

    #10 $finish;
end

endmodule

3)Write RTL for 8x3 priority encoder using structural model and verify the same using a Testbench. 
module priority_encoder8x3(
    input [7:0] d,
    output [2:0] y
);

assign y[2] = d[4] | d[5] | d[6] | d[7];
assign y[1] = d[2] | d[3] | d[6] | d[7];
assign y[0] = d[1] | d[3] | d[5] | d[7];

endmodule

module tb_priority_encoder8x3;

reg [7:0] d;
wire [2:0] y;

priority_encoder8x3 uut(
    .d(d),
    .y(y)
);

initial begin
    $monitor("d=%b y=%b",d,y);

    d=8'b00000001;
    #10 d=8'b00000010;
    #10 d=8'b00000100;
    #10 d=8'b00001000;
    #10 d=8'b00010000;
    #10 d=8'b00100000;
    #10 d=8'b01000000;
    #10 d=8'b10000000;

    #10 $finish;
end

endmodule

4)Write RTL for the 4 bits Ripple carry Adder using 1-bit Full adder and verify the same using a Testbench. 
module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum  = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule

module ripple_carry_adder(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
);

wire c1,c2,c3;

full_adder FA0(a[0],b[0],cin,sum[0],c1);
full_adder FA1(a[1],b[1],c1,sum[1],c2);
full_adder FA2(a[2],b[2],c2,sum[2],c3);
full_adder FA3(a[3],b[3],c3,sum[3],cout);

endmodule
module tb_ripple_carry_adder;

reg [3:0] a,b;
reg cin;
wire [3:0] sum;
wire cout;

ripple_carry_adder uut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial begin
    $monitor("a=%b b=%b cin=%b sum=%b cout=%b",
              a,b,cin,sum,cout);

    a=4'b0011; b=4'b0101; cin=0;
    #10 a=4'b1111; b=4'b0001;
    #10 a=4'b1010; b=4'b0110;

    #10 $finish;
end

endmodule

5)Write RTL for 4:1 Mux using 2:1 Muxes and verify the same using a Testbench.
module mux2x1(
    input a,
    input b,
    input s,
    output y
);

assign y = s ? b : a;

endmodule

module mux4x1(
    input i0,
    input i1,
    input i2,
    input i3,
    input [1:0] s,
    output y
);

wire w1,w2;

mux2x1 M1(i0,i1,s[0],w1);
mux2x1 M2(i2,i3,s[0],w2);
mux2x1 M3(w1,w2,s[1],y);

endmodule
module tb_mux4x1;

reg i0,i1,i2,i3;
reg [1:0] s;
wire y;

mux4x1 uut(
    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .s(s),
    .y(y)
);

initial begin
    i0=0; i1=1; i2=0; i3=1;

    $monitor("s=%b y=%b",s,y);

    s=2'b00;
    #10 s=2'b01;
    #10 s=2'b10;
    #10 s=2'b11;

    #10 $finish;
end

endmodule

6)Write RTL description and test bench for 3:8 Decoder.
module decoder3x8(
    input [2:0] a,
    output [7:0] y
);

assign y = 8'b00000001 << a;

endmodule

module tb_decoder3x8;

reg [2:0] a;
wire [7:0] y;

decoder3x8 uut(
    .a(a),
    .y(y)
);

initial begin
    $monitor("a=%b y=%b",a,y);

    a=3'b000;
    #10 a=3'b001;
    #10 a=3'b010;
    #10 a=3'b011;
    #10 a=3'b100;
    #10 a=3'b101;
    #10 a=3'b110;
    #10 a=3'b111;

    #10 $finish;
end

endmodule

7)Write RTL description and testbench for 8:3 Priority encoder. 
module priority_encoder(
    input [7:0] d,
    output reg [2:0] y
);

always @(*) begin
    casex(d)
        8'b1xxxxxxx : y = 3'b111;
        8'b01xxxxxx : y = 3'b110;
        8'b001xxxxx : y = 3'b101;
        8'b0001xxxx : y = 3'b100;
        8'b00001xxx : y = 3'b011;
        8'b000001xx : y = 3'b010;
        8'b0000001x : y = 3'b001;
        8'b00000001 : y = 3'b000;
        default     : y = 3'b000;
    endcase
end

endmodule

module tb_priority_encoder;

reg [7:0] d;
wire [2:0] y;

priority_encoder uut(
    .d(d),
    .y(y)
);

initial begin
    $monitor("d=%b y=%b",d,y);

    d=8'b00000001;
    #10 d=8'b00000010;
    #10 d=8'b00000100;
    #10 d=8'b00001000;
    #10 d=8'b00010000;
    #10 d=8'b00100000;
    #10 d=8'b01000000;
    #10 d=8'b10000000;

    #10 $finish;
end

endmodule




