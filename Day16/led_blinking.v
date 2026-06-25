`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 12:37:44
// Design Name: 
// Module Name: led_blinking
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
module led_blinking(clk,led);
input clk;
output reg [7:0]led=0;

reg [23:0]counter=0;

always @(posedge clk)begin
   if(counter==24'd11_999_999)begin
      counter = 24'd0;
	  led=~led;
   end else
      counter=counter +1;
end
endmodule
