`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/08 17:25:20
// Design Name: 
// Module Name: board_test
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


module board_test(clk_undiv, rst, led);
input clk_undiv, rst;
output [7:0] led;

wire clk;
reg en_in,en2;

CPU_LS cpu_ls1(
.clk(clk),
.rst(rst),
.en_in(en_in),
.en2(en2), 
.led(led)
);

clk_div clk_div1(
.clk_undiv(clk_undiv),
.rst(rst),
.clk(clk)
);

ila_0 ila_0 (
    .clk(clk_undiv), // input wire clk
    .probe0(led), // input wire [7:0]  probe0  
    .probe1(rst) // input wire [0:0]  probe1 
);
  
  initial begin                
                    en_in = 1'b1;
    end
    
initial begin                
                        en2 = 1'b1;
        end
                
                           
endmodule
