`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/11 14:32:32
// Design Name: 
// Module Name: board_tb
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
//////////////////////////////////////////////////////////////////////////////////


module board_tb();
reg clk_undiv,rst;
wire [7:0]led;

board_test board(
.clk_undiv(clk_undiv),
.rst(rst),
.led(led)
);

parameter Tclk = 10;

  initial begin
             clk_undiv=0;
                forever #(Tclk/2) clk_undiv=~clk_undiv;
            end
            
   initial begin
            rst=0;
            #(Tclk*4)   rst=1; 
            end


endmodule